using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using Snowlight.Storage;
using Snowlight.Communication;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Rights;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Achievements
{
    public static class AchievementManager
    {
        private static Dictionary<string, Achievement> mAchievements;
        private static object mSyncRoot;

        public static Dictionary<string, Achievement> Achievements
        {
            get
            {
                Dictionary<string, Achievement> Achievements = new Dictionary<string, Achievement>();

                lock (mAchievements)
                {
                    foreach (KeyValuePair<string, Achievement> Achievement in mAchievements)
                    {
                        Achievements.Add(Achievement.Key, Achievement.Value);
                    }
                }

                return Achievements;
            }
        }

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mAchievements = new Dictionary<string, Achievement>();
            mSyncRoot = new object();

            ReloadAchievements(MySqlClient);

            DataRouter.RegisterHandler(OpcodesIn.ACHIEVEMENTS_GET_LIST, new ProcessRequestCallback(GetList));
        }

        public static void ReloadAchievements(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mAchievements.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM achievements");

                foreach (DataRow Row in Table.Rows)
                {
                    string Group = (string)Row["group_name"];

                    if (!mAchievements.ContainsKey(Group))
                    {
                        mAchievements.Add(Group, new Achievement((uint)Row["id"], Group, (string)Row["category"]));
                    }

                    mAchievements[Group].AddLevel(new AchievementLevel((int)Row["level"], (int)Row["reward_pixels"],
                        (int)Row["reward_points"], (int)Row["progress_needed"]));
                }
            }
        }

        private static void GetList(Session Session, ClientMessage Message)
        {
            Session.SendData(AchievementListComposer.Compose(Session, mAchievements.Values.ToList().AsReadOnly()));
        }

        public static bool ProgressUserAchievement(SqlDatabaseClient MySqlClient, Session Session, string AchievementGroup, int ProgressAmount)
        {
            if (!mAchievements.ContainsKey(AchievementGroup))
            {
                return false;
            }

            Achievement AchievementData = null;

            lock (mSyncRoot)
            {
                AchievementData = mAchievements[AchievementGroup];
            }

            UserAchievement UserData = Session.AchievementCache.GetAchievementData(AchievementGroup);

            int TotalLevels = AchievementData.Levels.Count;

            if (UserData != null && UserData.Level == TotalLevels)
            {
                return false; // done, no more.
            }

            int TargetLevel = (UserData != null ? UserData.Level + 1 : 1);

            if (TargetLevel > TotalLevels)
            {
                TargetLevel = TotalLevels;
            }

            AchievementLevel TargetLevelData = AchievementData.Levels[TargetLevel];

            int NewProgress = (UserData != null ? UserData.Progress + ProgressAmount : ProgressAmount);
            int NewLevel = (UserData != null ? UserData.Level : 0);
            int NewTarget = NewLevel + 1;

            if (NewTarget > TotalLevels)
            {
                NewTarget = TotalLevels;
            }

            if (NewProgress >= TargetLevelData.Requirement)
            {
                NewLevel++;
                NewTarget++;

                int ProgressRemainder = NewProgress - TargetLevelData.Requirement;
                NewProgress = 0;

                Badge BadgeData = RightsManager.GetBadgeByCode(AchievementGroup + TargetLevel);

                if (NewTarget > TotalLevels)
                {
                    NewTarget = TotalLevels;
                }

                Session.BadgeCache.UpdateAchievementBadge(MySqlClient, AchievementGroup, BadgeData);
                Session.NewItemsCache.MarkNewItem(MySqlClient, 4, BadgeData.Id);
                Session.SendData(InventoryNewItemsComposer.Compose(4, BadgeData.Id));

                Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, TargetLevelData.PixelReward);
                Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance,
                    TargetLevelData.PixelReward));

                Session.SendData(AchievementUnlockedComposer.Compose(AchievementData, TargetLevel, TargetLevelData.PointsReward,
                    TargetLevelData.PixelReward));

                Session.AchievementCache.AddOrUpdateData(MySqlClient, AchievementGroup, NewLevel, NewProgress);

                Session.CharacterInfo.UpdateScore(MySqlClient, TargetLevelData.PointsReward);
                Session.SendData(AchievementScoreUpdateComposer.Compose(Session.CharacterInfo.Score));

                AchievementLevel NewLevelData = AchievementData.Levels[NewTarget];
                Session.SendData(AchievementProgressComposer.Compose(AchievementData, NewTarget, NewLevelData,
                    TotalLevels, Session.AchievementCache.GetAchievementData(AchievementGroup)));

                Session.SendInfoUpdate();

                Session.MessengerFriendCache.BroadcastToFriends(MessengerFriendEventComposer.Compose(Session.CharacterId,
                    MessengerFriendEventType.AchievementUnlocked, BadgeData.Code));

                RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

                if (Instance != null)
                {
                    Instance.BroadcastMessage(RoomUserBadgesComposer.Compose(Session.CharacterId,
                        Session.BadgeCache.EquippedBadges));
                }

                if (ProgressRemainder > 0)
                {
                    ProgressUserAchievement(MySqlClient, Session, AchievementGroup, ProgressRemainder);
                }

                return true;
            }

            Session.AchievementCache.AddOrUpdateData(MySqlClient, AchievementGroup, NewLevel, NewProgress);
            Session.SendData(AchievementProgressComposer.Compose(AchievementData, TargetLevel, TargetLevelData,
            TotalLevels, Session.AchievementCache.GetAchievementData(AchievementGroup)));
            return false;
        }

        public static Achievement GetAchievement(string AchievementGroup)
        {
            lock (mSyncRoot)
            {
                if (mAchievements.ContainsKey(AchievementGroup))
                {
                    return mAchievements[AchievementGroup];
                }
            }

            return null;
        }
    }
}
