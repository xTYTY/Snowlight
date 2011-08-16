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
            // com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetBadgePointLimitsComposer; 
            // used for badge point limits?? what is this anyone know??
            DataRouter.RegisterHandler(3032, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
            // this is used for the sound settings, you need to return the volume settings via this request!
            DataRouter.RegisterHandler(228, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
            // this is the call used to "display" the MOTD. Should be responded via this request.
            DataRouter.RegisterHandler(3110, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.friendlist.GetBuddyRequestsMessageComposer;
            // get buddy requests packet this is used for the messenger so it needs to be implemented properly
            DataRouter.RegisterHandler(233, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer; 
            // marketplace configuration event.....
            DataRouter.RegisterHandler(3011, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.catalog.GetGiftWrappingConfigurationComposer;
            // something to do with gift wrapping!??
            DataRouter.RegisterHandler(473, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.advertisement.GetRoomAdMessageComposer;
            // used for returning the room ads...
            DataRouter.RegisterHandler(126, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.users.GetUserNotificationsMessageComposer;
            // something to do with user notifs...
            DataRouter.RegisterHandler(3105, new ProcessRequestCallback(SurpressingHandler));

            // com.sulake.habbo.communication.messages.outgoing.tracking.LatencyPingReportMessageComposer;
            // something to do with latency..
            DataRouter.RegisterHandler(316, new ProcessRequestCallback(SurpressingHandler));
        }

        private static void SurpressingHandler(Session Session, ClientMessage Message)
        {
            // No idea what these requests do, but to surpress ugly and creepy warning messages we register the handlers.
        }
    }
}
