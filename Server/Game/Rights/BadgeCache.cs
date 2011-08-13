using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;

using Snowlight.Storage;
using Snowlight.Game.Achievements;
using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Rights
{
    public class BadgeCache
    {
        private uint mUserId;
        private object mSyncRoot;

        private Dictionary<int, Badge> mEquippedBadges;
        private List<Badge> mStaticBadges;
        private Dictionary<string, Badge> mAchievementBadges;
        private List<string> mIndexCache;
        private List<string> mRightsCache;

        public SortedDictionary<int, Badge> EquippedBadges
        {
            get
            {
                SortedDictionary<int, Badge> Copy = new SortedDictionary<int, Badge>();

                lock (mSyncRoot)
                {
                    foreach (KeyValuePair<int, Badge> Data in mEquippedBadges)
                    {
                        Copy.Add(Data.Key, Data.Value);
                    }
                }

                return Copy;
            }
        }

        public List<Badge> Badges
        {
            get
            {
                List<Badge> Copy = new List<Badge>();

                lock (mSyncRoot)
                {
                    Copy.AddRange(mStaticBadges);
                    Copy.AddRange(mAchievementBadges.Values.ToList());
                }

                return Copy;
            }
        }

        public BadgeCache(SqlDatabaseClient MySqlClient, uint UserId, AchievementCache UserAchievementCache)
        {
            mUserId = UserId;
            mSyncRoot = new object();

            mEquippedBadges = new Dictionary<int, Badge>();
            mStaticBadges = new List<Badge>();
            mAchievementBadges = new Dictionary<string, Badge>();
            mIndexCache = new List<string>();
            mRightsCache = new List<string>();

            ReloadCache(MySqlClient, UserAchievementCache);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient, AchievementCache UserAchievementCache)
        {
            Dictionary<int, Badge> EquippedBadges = new Dictionary<int, Badge>();
            List<Badge> StaticBadges = new List<Badge>();
            Dictionary<string, Badge> AchievementBadges = new Dictionary<string, Badge>();
            List<string> IndexCache = new List<string>();

            MySqlClient.SetParameter("userid", mUserId);
            DataTable Table = MySqlClient.ExecuteQueryTable("SELECT badge_id,slot_id,source_type,source_data FROM badges WHERE user_id = @userid");

            foreach (DataRow Row in Table.Rows)
            {
                Badge Badge = RightsManager.GetBadgeById((uint)Row["badge_id"]);

                if (Badge == null)
                {
                    continue;
                }

                string SourceType = Row["source_type"].ToString();
                string SourceData = Row["source_data"].ToString();

                Badge BadgeToEquip = null;

                if (SourceType == "static")
                {
                    BadgeToEquip = Badge;
                    StaticBadges.Add(BadgeToEquip);
                }
                else if (SourceType == "achievement")
                {
                    if (AchievementBadges.ContainsKey(SourceData))
                    {
                        continue;
                    }

                    UserAchievement UserAchievement = UserAchievementCache.GetAchievementData(SourceData);

                    if (UserAchievement == null || UserAchievement.Level < 1)
                    {
                        MySqlClient.SetParameter("userid", mUserId);
                        MySqlClient.SetParameter("badgeid", Badge.Id);
                        MySqlClient.ExecuteNonQuery("DELETE FROM badges WHERE user_id = @userid AND badge_id = @badgeid");
                        continue;
                    }

                    string Code = UserAchievement.GetBadgeCodeForLevel();

                    BadgeToEquip = (Badge.Code == Code ? Badge : RightsManager.GetBadgeByCode(Code));
                    AchievementBadges.Add(SourceData, BadgeToEquip);
                }

                if (BadgeToEquip != null)
                {
                    int SlotId = (int)Row["slot_id"];

                    if (!EquippedBadges.ContainsKey(SlotId) && SlotId >= 1 && SlotId <= 5)
                    {
                        EquippedBadges.Add(SlotId, BadgeToEquip);
                    }

                    IndexCache.Add(BadgeToEquip.Code);
                }
            }

            lock (mSyncRoot)
            {
                mEquippedBadges = EquippedBadges;
                mStaticBadges = StaticBadges;
                mAchievementBadges = AchievementBadges;
                mRightsCache = RegenerateRights();
                mIndexCache = IndexCache;
            }
        }

        public List<string> RegenerateRights()
        {
            List<string> Rights = new List<string>();
            Rights.AddRange(RightsManager.GetDefaultRights());

            lock (mSyncRoot)
            {
                foreach (Badge Badge in mStaticBadges)
                {
                    Rights.AddRange(RightsManager.GetRightsForBadge(Badge));
                }

                foreach (Badge Badge in mAchievementBadges.Values)
                {
                    Rights.AddRange(RightsManager.GetRightsForBadge(Badge));
                }
            }

            return Rights;
        }

        public bool ContainsCode(string BadgeCode)
        {
            lock (mSyncRoot)
            {
                return mIndexCache.Contains(BadgeCode);
            }
        }

        public bool HasRight(string Right)
        {
            lock (mSyncRoot)
            {
                return mRightsCache.Contains(Right);
            }
        }

        public void UpdateAchievementBadge(SqlDatabaseClient MySqlClient, string AchievementGroup, Badge NewBadge)
        {
            MySqlClient.SetParameter("userid", mUserId);
            MySqlClient.SetParameter("sourcetype", "achievement");
            MySqlClient.SetParameter("sourcedata", AchievementGroup);
            MySqlClient.SetParameter("badgeid", NewBadge.Id);

            lock (mSyncRoot)
            {
                if (mAchievementBadges.ContainsKey(AchievementGroup))
                {
                    Badge OldBadge = mAchievementBadges[AchievementGroup];

                    if (OldBadge == NewBadge)
                    {
                        MySqlClient.ClearParameters();
                        return;
                    }

                    mIndexCache.Remove(OldBadge.Code);
                    mAchievementBadges[AchievementGroup] = NewBadge;

                    MySqlClient.ExecuteNonQuery("UPDATE badges SET badge_id = @badgeid WHERE user_id = @userid AND source_type = @sourcetype AND source_data = @sourcedata LIMIT 1");

                    foreach (KeyValuePair<int, Badge> Badge in mEquippedBadges)
                    {
                        if (Badge.Value.Id == OldBadge.Id)
                        {
                            mEquippedBadges[Badge.Key] = NewBadge;
                            break;
                        }
                    }
                }
                else
                {
                    mAchievementBadges.Add(AchievementGroup, NewBadge);
                    MySqlClient.ExecuteNonQuery("INSERT INTO badges (user_id,badge_id,source_type,source_data) VALUES (@userid,@badgeid,@sourcetype,@sourcedata)");
                }

                mRightsCache = RegenerateRights();
                mIndexCache.Add(NewBadge.Code);
            }
        }

        public void UpdateBadgeOrder(SqlDatabaseClient MySqlClient, Dictionary<int, Badge> NewSettings)
        {
            MySqlClient.SetParameter("userid", mUserId);
            MySqlClient.ExecuteNonQuery("UPDATE badges SET slot_id = 0 WHERE user_id = @userid");

            foreach (KeyValuePair<int, Badge> EquippedBadge in NewSettings)
            {
                MySqlClient.SetParameter("userid", mUserId);
                MySqlClient.SetParameter("slotid", EquippedBadge.Key);
                MySqlClient.SetParameter("badgeid", EquippedBadge.Value.Id);
                MySqlClient.ExecuteNonQuery("UPDATE badges SET slot_id = @slotid WHERE user_id = @userid AND badge_id = @badgeid LIMIT 1");
            }

            lock (mSyncRoot)
            {
                mEquippedBadges = NewSettings;
            }
        }

        public void DisableSubscriptionBadge(string BadgeCodePrefix)
        {
            lock (mSyncRoot)
            {
                foreach (KeyValuePair<string, Badge> Data in mAchievementBadges)
                {
                    if (Data.Value.Code.StartsWith(BadgeCodePrefix))
                    {
                        mIndexCache.Remove(Data.Value.Code);
                        mAchievementBadges.Remove(Data.Key);

                        foreach (KeyValuePair<int, Badge> EquipData in mEquippedBadges)
                        {
                            if (EquipData.Value.Code.StartsWith(BadgeCodePrefix))
                            {
                                mEquippedBadges.Remove(EquipData.Key);
                                break;
                            }
                        }

                        break;
                    }
                }

                mRightsCache = RegenerateRights();
            }
        }

        public bool ContainsCodeWith(string Code)
        {
            lock (mSyncRoot)
            {
                foreach (string Item in mIndexCache)
                {
                    if (Item.StartsWith(Code))
                    {
                        return true;
                    }
                }
            }

            return false;
        }
    }
}
