using System;
using System.Threading;

using Snowlight.Storage;
using Snowlight.Game.Sessions;

namespace Snowlight.Util
{
    public static class StatisticsSyncUtil
    {
        public static void Initialize()
        {
            Thread Thread = new Thread(new ThreadStart(ProcessThread));
            Thread.Priority = ThreadPriority.Lowest;
            Thread.Name = "StatisticsDbSyncThread";
            Thread.Start();
        }

        private static void ProcessThread()
        {
            while (Program.Alive)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("skey", "active_connections");
                    MySqlClient.SetParameter("sval", SessionManager.ActiveConnections);
                    MySqlClient.ExecuteNonQuery("UPDATE server_statistics SET sval = @sval WHERE skey = @skey LIMIT 1");
                }

                Thread.Sleep(60 * 1000);
            }
        }
    }
}
