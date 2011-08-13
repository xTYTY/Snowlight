using System;
using System.Collections.Generic;

using Snowlight.Storage;

namespace Snowlight.Game.Misc
{
    public static class TeleporterLinkFinder
    {
        private static Dictionary<uint, uint> mCache = new Dictionary<uint, uint>();
         
        public static uint GetValue(uint LinkedItemId)
        {
            return (mCache.ContainsKey(LinkedItemId) ? mCache[LinkedItemId] : 0);
        }

        public static void FillCache(SqlDatabaseClient MySqlClient, uint LinkedItemId)
        {
            if (mCache.ContainsKey(LinkedItemId))
            {
                mCache.Remove(LinkedItemId);
            }

            uint IdValue = 0;

            MySqlClient.SetParameter("id", LinkedItemId);
            object Result = MySqlClient.ExecuteScalar("SELECT room_id FROM items WHERE id = @id LIMIT 1");

            if (Result != null)
            {
                IdValue = (uint)Result;
            }

            if (IdValue > 0)
            {         
                mCache.Add(LinkedItemId, IdValue);
            }
        }
    }
}
