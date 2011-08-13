using System;
using System.Collections.Generic;
using System.Data;
using System.Threading;

using Snowlight.Storage;

namespace Snowlight.Game.Rooms
{
    public static class RoomInfoLoader
    {
        private const double CACHE_LIFE_TIME = 300;

        private static Dictionary<uint, RoomInfo> mRoomInfoCache;
        private static Thread mCacheMonitorThread;

        public static void Initialize()
        {
            mRoomInfoCache = new Dictionary<uint, RoomInfo>();

            mCacheMonitorThread = new Thread(new ThreadStart(MonitorCache));
            mCacheMonitorThread.Name = "RoomInfoLoader Cache Monitor";
            mCacheMonitorThread.Priority = ThreadPriority.Lowest;
            mCacheMonitorThread.Start();
        }

        private static void MonitorCache()
        {
            try
            {
                while (Program.Alive)
                {
                    lock (mRoomInfoCache)
                    {
                        List<uint> ToRemove = new List<uint>();

                        foreach (RoomInfo Info in mRoomInfoCache.Values)
                        {
                            if (RoomManager.GetInstanceByRoomId(Info.Id) != null || Info.CacheAge >= CACHE_LIFE_TIME)
                            {
                                ToRemove.Add(Info.Id);
                                continue;
                            }
                        }

                        foreach (uint RemoveUid in ToRemove)
                        {
                            mRoomInfoCache.Remove(RemoveUid);
                        }
                    }

                    Thread.Sleep(30000);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }

        public static void RemoveFromCache(uint RoomId)
        {
            lock (mRoomInfoCache)
            {
                if (mRoomInfoCache.ContainsKey(RoomId))
                {
                    mRoomInfoCache.Remove(RoomId);
                }
            }
        }

        private static RoomInfo TryGetInfoFromCache(uint RoomId)
        {
            lock (mRoomInfoCache)
            {
                if (mRoomInfoCache.ContainsKey(RoomId))
                {
                    return mRoomInfoCache[RoomId];
                }
            }

            return null;
        }

        public static RoomInfo GetRoomInfo(uint RoomId)
        {
            return GetRoomInfo(RoomId, false);
        }

        public static RoomInfo GetRoomInfo(uint RoomId, bool IgnoreCache)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(RoomId);

            if (Instance != null)
            {
                return Instance.Info;
            }

            if (!IgnoreCache)
            {
                RoomInfo CachedInfo = TryGetInfoFromCache(RoomId);

                if (CachedInfo != null)
                {
                    return CachedInfo;
                }
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("id", RoomId);
                DataRow Row = MySqlClient.ExecuteQueryRow("SELECT * FROM rooms WHERE id = @id LIMIT 1");

                if (Row != null)
                {
                    return GenerateRoomInfoFromRow(Row);
                }
            }

            return null;
        }

        public static RoomInfo GenerateRoomInfoFromRow(DataRow Row)
        {
            List<string> Tags = new List<string>();

            foreach (string Tag in Row["tags"].ToString().Split(','))
            {
                Tags.Add(Tag);
            }

            RoomAccessType AccessType = RoomAccessType.Open;

            switch (Row["access_type"].ToString())
            {
                case "doorbell":

                    AccessType = RoomAccessType.Locked;
                    break;

                case "password":

                    AccessType = RoomAccessType.PasswordProtected;
                    break;
            }

            string RawIconData = (string)Row["icon"];
            RoomIcon Icon = new RoomIcon();

            if (RawIconData.Length > 0)
            {
                Icon.Deserialize((string)Row["icon"]);
            }

            Dictionary<string, string> Decorations = new Dictionary<string, string>();

            string[] DecorationBits = Row["decorations"].ToString().Split('|');

            foreach (string DecoBit in DecorationBits)
            {
                string[] Sub = DecoBit.Split('=');

                if (Sub.Length == 2)
                {
                    Decorations.Add(Sub[0], Sub[1]);
                }
            }

            return new RoomInfo((uint)Row["id"], (Row["type"].ToString() == "public" ? RoomType.Public : RoomType.Flat),
                (uint)Row["owner_id"], (string)Row["name"], (string)Row["description"], Tags, AccessType, (string)Row["password"],
                Icon, (int)Row["category"], (int)Row["max_users"], (string)Row["swfs"], (int)Row["score"], (string)Row["model"],
                (Row["allow_pets"].ToString() == "1"), (Row["allow_pet_eating"].ToString() == "1"),
                (Row["disable_blocking"].ToString() == "1"), (Row["hide_walls"].ToString() == "1"),
                (string)Row["pub_internal_name"], (int)Row["thickness_wall"], (int)Row["thickness_floor"], Decorations);
        }
    }
}