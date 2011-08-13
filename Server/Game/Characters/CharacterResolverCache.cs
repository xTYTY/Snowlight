using System;
using System.Collections.Generic;

using Snowlight.Storage;

namespace Snowlight.Util
{
    public static class CharacterResolverCache
    {
        private static Dictionary<uint, string> mNameCache = new Dictionary<uint, string>();

        public static void AddToCache(uint Id, string Name, bool Override)
        {
            lock (mNameCache)
            {
                if (mNameCache.ContainsKey(Id))
                {
                    if (Override)
                    {
                        mNameCache[Id] = Name;
                    }

                    return;
                }

                mNameCache.Add(Id, Name);
            }
        }

        public static string GetNameFromUid(uint UserId)
        {
            lock (mNameCache)
            {
                if (mNameCache.ContainsKey(UserId))
                {
                    return mNameCache[UserId];
                }

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", UserId);
                    string Username = (string)MySqlClient.ExecuteScalar("SELECT username FROM characters WHERE id = @id LIMIT 1");

                    if (Username != null && Username.Length > 0)
                    {
                        mNameCache.Add(UserId, Username);
                        return Username;
                    }
                }
            }

            return "Unknown User";
        }

        public static uint GetUidFromName(string Name)
        {
            lock (mNameCache)
            {
                foreach (KeyValuePair<uint, string> CachedName in mNameCache)
                {
                    if (CachedName.Value.ToLower() == Name.ToLower())
                    {
                        return CachedName.Key;
                    }
                }

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("username", Name);
                    object Result = MySqlClient.ExecuteScalar("SELECT id FROM characters WHERE username = @username LIMIT 1");

                    if (Result != null)
                    {
                        uint Id = (uint)Result;
                        mNameCache.Add(Id, Name);
                        return Id;
                    }
                }
            }

            return 0;
        }
    }
}
