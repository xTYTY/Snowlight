using System;

using Snowlight.Game.Advertisements;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomInterstitialComposer
    {
        public static ServerMessage Compose(Interstitial Interstitial)
        {
            ServerMessage Message = new ServerMessage(258);
            Message.AppendStringWithBreak(Interstitial == null ? string.Empty : Interstitial.Image);
            Message.AppendStringWithBreak(Interstitial == null ? string.Empty : Interstitial.Url);
            return Message;
        }
    }
}
