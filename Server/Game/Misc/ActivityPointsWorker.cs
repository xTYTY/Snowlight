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
        private static Thread mWorkerThread;

        public static void Initialize()
        {
            if (!(bool)ConfigManager.GetValue("activitypoints.enabled"))
            {
                return;
            }

            mWorkerThread = new Thread(new ThreadStart(ProcessThread));
            mWorkerThread.Priority = ThreadPriority.Lowest;
            mWorkerThread.Name = "ActivityPointsWorkerThread";
            mWorkerThread.Start();
        }

        public static void Stop()
        {
            if (mWorkerThread != null)
            {
                mWorkerThread.Abort();
                mWorkerThread = null;
            }
        }

        private static void ProcessThread()
        {
            try
            {
                int Interval = (int)ConfigManager.GetValue("activitypoints.interval");
                int Amount = (int)ConfigManager.GetValue("activitypoints.amount");

                Thread.Sleep(60000);

                while (Program.Alive)
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

                    Thread.Sleep((Interval / 5) * 1000);
                }
            }
            catch (ThreadAbortException) { }
        }
    }
}
