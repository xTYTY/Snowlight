using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading;

using Snowlight.Game.Sessions;
using Snowlight.Storage;

namespace Snowlight.Game.Characters
{
    public static class CharacterInfoLoader
    {
        private const double CACHE_LIFE_TIME = 300;

        private static Dictionary<uint, CharacterInfo> mCharacterInfoCache;
        private static Thread mCacheMonitorThread;

        public static void Initialize()
        {
            mCharacterInfoCache = new Dictionary<uint, CharacterInfo>();

            mCacheMonitorThread = new Thread(new ThreadStart(MonitorCache));
            mCacheMonitorThread.Name = "CharacterInfoLoader Cache Monitor";
            mCacheMonitorThread.Priority = ThreadPriority.Lowest;
            mCacheMonitorThread.Start();
        }

        private static void MonitorCache()
        {
            try
            {
                while (Program.Alive)
                {
                    lock (mCharacterInfoCache)
                    {
                        List<uint> ToRemove = new List<uint>();

                        foreach (CharacterInfo Info in mCharacterInfoCache.Values)
                        {
                            if (SessionManager.ContainsCharacterId(Info.Id) || Info.CacheAge >= CACHE_LIFE_TIME)
                            {
                                ToRemove.Add(Info.Id);
                                continue;
                            }
                        }

                        foreach (uint RemoveUid in ToRemove)
                        {
                            mCharacterInfoCache.Remove(RemoveUid);
                        }
                    }

                    Thread.Sleep(30000);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }

        private static CharacterInfo TryGetInfoFromCache(uint CharacterId)
        {
            lock (mCharacterInfoCache)
            {
                if (mCharacterInfoCache.ContainsKey(CharacterId))
                {
                    return mCharacterInfoCache[CharacterId];
                }
            }

            return null;
        }

        public static CharacterInfo GetCharacterInfo(SqlDatabaseClient MySqlClient, uint CharacterId)
        {
            return GetCharacterInfo(MySqlClient, CharacterId, 0, false);
        }

        public static CharacterInfo GetCharacterInfo(SqlDatabaseClient MySqlClient, uint CharacterId, uint LinkedClientId, bool IgnoreCache)
        {
            if (SessionManager.ContainsCharacterId(CharacterId))
            {
                Session Session = SessionManager.GetSessionByCharacterId(CharacterId);
                return Session.CharacterInfo;
            }

            if (!IgnoreCache)
            {
                CharacterInfo CachedInfo = TryGetInfoFromCache(CharacterId);

                if (CachedInfo != null)
                {
                    return CachedInfo;
                }
            }

            MySqlClient.SetParameter("id", CharacterId);
            DataRow Row = MySqlClient.ExecuteQueryRow("SELECT * FROM characters WHERE id = @id LIMIT 1");

            if (Row != null)
            {
                return GenerateCharacterInfoFromRow(MySqlClient, LinkedClientId, Row);
            }

            return null;
        }
        
        public static CharacterInfo GenerateCharacterInfoFromRow(SqlDatabaseClient MySqlClient, uint LinkedClientId, DataRow Row)
        {
            return new CharacterInfo(MySqlClient, LinkedClientId, (uint)Row["id"], (string)Row["username"], (string)Row["real_name"],
                (string)Row["figure"], (Row["gender"].ToString() == "M" ? CharacterGender.Male : CharacterGender.Female),
                (string)Row["motto"], (int)Row["credits_balance"], (int)Row["activity_points_balance"],
                (double)Row["activity_points_last_update"], (Row["privacy_accept_friends"].ToString() == "1"),
                (uint)Row["home_room"], (int)Row["score"], (int)Row["config_volume"],
                (int)Row["moderation_tickets"], (int)Row["moderation_tickets_abusive"], (double)Row["moderation_tickets_cooldown"],
                (int)Row["moderation_bans"], (int)Row["moderation_cautions"], (double)Row["timestamp_lastvisit"],
                (double)Row["timestamp_created"], (int)Row["respect_points"], (int)Row["respect_credit_humans"],
                (int)Row["respect_credit_pets"], (double)Row["moderation_muted_until_timestamp"]);
        }

        public static CharacterInfo GenerateNullCharacter(uint Id)
        {
            return new CharacterInfo(null, 0, Id, "Unknown", string.Empty, string.Empty, CharacterGender.Male, string.Empty,
                0, 0, 0, false, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        }
    }
}
