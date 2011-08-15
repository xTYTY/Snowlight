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
        private static Timer mWorker;

        public static void Initialize()
        {
            mWorker = new Timer(ProcessThread, null, TimeSpan.FromSeconds(5), TimeSpan.FromSeconds(5));
        }

        private static void ProcessThread(object state)
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
        }
    }
}
