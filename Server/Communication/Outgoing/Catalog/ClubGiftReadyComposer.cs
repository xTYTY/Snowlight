using System;

namespace Snowlight.Communication.Outgoing
{
    public static class ClubGiftReadyComposer
    {
        public static ServerMessage Compose(int GiftAmount)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CLUB_GIFT_READY);
            Message.AppendInt32(GiftAmount);
            return Message;
        }
    }
}
