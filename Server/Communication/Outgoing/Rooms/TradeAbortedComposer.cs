using System;

namespace Snowlight.Communication.Outgoing
{
    public static class TradeAbortedComposer
    {
        public static ServerMessage Compose(uint UserId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_TRADE_ABORTED);
            Message.AppendUInt32(UserId);
            return Message;
        }
    }
}
