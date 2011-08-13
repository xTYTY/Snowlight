using System;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Handlers
{
    public static class WarningSurpressors
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(3032, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(228, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(3110, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(233, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(3011, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(473, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(126, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(3105, new ProcessRequestCallback(SurpressingHandler));
            DataRouter.RegisterHandler(316, new ProcessRequestCallback(SurpressingHandler));
        }

        private static void SurpressingHandler(Session Session, ClientMessage Message)
        {
            // No idea what these requests do, but to surpress ugly and creepy warning messages we register the handlers.
        }
    }
}
