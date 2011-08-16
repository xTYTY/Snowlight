using System;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Handlers
{
    public static class GlobalHandler
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.SESSION_PONG, new ProcessRequestCallback(OnSessionPong), true);
            DataRouter.RegisterHandler(OpcodesIn.SESSION_USER_AGENT_INFORMATION, new ProcessRequestCallback(OnUserAgent), true);
            DataRouter.RegisterHandler(OpcodesIn.SESSION_LATENCY_TEST, new ProcessRequestCallback(OnSessionLatencyTest), true);
            DataRouter.RegisterHandler(OpcodesIn.SESSION_DEBUG_EVENT, new ProcessRequestCallback(OnDebugEvent), true);
            DataRouter.RegisterHandler(OpcodesIn.SESSION_CLIENT_CONFIGURATION, new ProcessRequestCallback(OnClientConfig));
            DataRouter.RegisterHandler(OpcodesIn.SESSION_DISCONNECT_EVENT, new ProcessRequestCallback(OnClientDisconnectNotification), true);

            // com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
            // this is used for the sound settings, you need to return the volume settings via this request!
            DataRouter.RegisterHandler(228, new ProcessRequestCallback(OnGetSoundSettings));

            // com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
            // this is the call used to "display" the MOTD. Should be responded via this request.
            DataRouter.RegisterHandler(3110, new ProcessRequestCallback(OnGetMotdMessage));
        }

        private static void OnSessionPong(Session Session, ClientMessage Message)
        {
            Session.LatencyTestOk = true;
        }

        private static void OnUserAgent(Session Session, ClientMessage Message)
        {
            string UserAgent = Message.PopString();

            if (UserAgent.Length > 2000)
            {
                UserAgent = UserAgent.Substring(0, 2000);
            }

            Session.UserAgent = UserAgent;
        }

        private static void OnSessionLatencyTest(Session Session, ClientMessage Message)
        {
            // Sesion timer sends a number to the server and expects it right back.
            // Maybe something to do with latency testing... or a keepalive?
            // Seems like a waste of bandwith since we're using pinging

            Session.SendData(LatencyTestResponseComposer.Compose(Message.PopWiredInt32()));
        }

        private static void OnDebugEvent(Session Session, ClientMessage Message)
        {
            // Debug events are sometimes sent when a user clicks an element
            // This information is completely useless to us (+bandwith waste), so we're ignoring it for now
        }

        private static void OnClientConfig(Session Session, ClientMessage Message)
        {
            int Volume = Message.PopWiredInt32();
            bool Something = Message.PopWiredBoolean();

            if (Volume < 0)
            {
                Volume = 0;
            }

            if (Volume > 100)
            {
                Volume = 100;
            }

            Session.CharacterInfo.ConfigVolume = Volume;
        }

        private static void OnClientDisconnectNotification(Session Session, ClientMessage Message)
        {
            SessionManager.StopSession(Session.Id);
        }

        private static void OnGetSoundSettings(Session Session, ClientMessage Message)
        {
            Session.SendData(SoundSettingsComposer.Compose(Session.CharacterInfo.ConfigVolume, false));
        }

        private static void OnGetMotdMessage(Session Session, ClientMessage Message)
        {
            Session.SendData(MessageOfTheDayComposer.Compose("Welcome to uberHotel.org BETA.\n\n\nThank you for participating in the uberHotel.org BETA test. We hope to gather relevant feedback and ideas to help make this hotel into a success.\n\nPlease submit any bugs, feedback, or ideas via:\nhttp://snowlight.uservoice.com\n\n\nHave fun, and thank you for joining us!"));
        }
    }
}
