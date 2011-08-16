using System;
using System.Threading;

using Snowlight.Game.Sessions;

using Snowlight.Communication.Outgoing;
using Snowlight.Storage;
using Snowlight.Specialized;
using System.Collections.Generic;
using Snowlight.Config;

namespace Snowlight.Game.Misc
{
    public static class ActivityPointsWorker
    {
        private static int Interval;
        private static int Amount;
        private static Timer mWorker;

        public static void Initialize()
        {
            if (!(bool)ConfigManager.GetValue("activitypoints.enabled"))
            {
                return;
            }
            
            Interval = (int)ConfigManager.GetValue("activitypoints.interval");
            Amount = (int)ConfigManager.GetValue("activitypoints.amount");

            mWorker = new Timer(new TimerCallback(ProcessThread), null, TimeSpan.FromSeconds(60), TimeSpan.FromSeconds(30));
        }

        public static void Stop()
        {
            if (mWorker != null)
            {
                mWorker.Dispose();
                mWorker = null;
            }
        }

        private static void ProcessThread(object state)
        {
            Dictionary<uint, Session> Sessions = SessionManager.Sessions;

            if (Sessions.Count > 0)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    foreach (Session Session in Sessions.Values)
                    {
                        if (!Session.Authenticated || Session.CharacterInfo.TimeSinceLastActivityPointsUpdate <= Interval)
                        {
                            continue;
                        }

                        Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, Amount);
                        Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance, Amount));
                        Session.CharacterInfo.SetLastActivityPointsUpdate(MySqlClient);
                    }
                }
            }
        }
    }
}
