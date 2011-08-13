using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Snowlight.Game.Sessions;
using Snowlight.Specialized;

namespace Snowlight.Game.Misc
{
    public static class EffectsCacheWorker
    {
        private static Thread mWorkerThread;

        public static void Initialize()
        {
            mWorkerThread = new Thread(new ThreadStart(ProcessThread));
            mWorkerThread.Priority = ThreadPriority.Lowest;
            mWorkerThread.Name = "EffectsCacheWorker";
            mWorkerThread.Start();
        }

        private static void ProcessThread()
        {
            try
            {
                while (Program.Alive)
                {
                    Dictionary<uint, Session> Sessions = SessionManager.Sessions;

                    foreach (Session Session in Sessions.Values)
                    {
                        if (Session.Stopped || !Session.Authenticated || Session.AvatarEffectCache == null)
                        {
                            continue;
                        }

                        Session.AvatarEffectCache.CheckEffectExpiry(Session);
                    }

                    Thread.Sleep(5000);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }
    }
}
