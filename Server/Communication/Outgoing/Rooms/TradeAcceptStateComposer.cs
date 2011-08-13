using System;

namespace Snowlight.Communication.Outgoing
{
    public static class TradeAcceptStateComposer
    {
        public static ServerMessage Compose(uint UserId, bool Accept)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_TRADE_ACCEPT_STATE);
            Message.AppendUInt32(UserId);
            Message.AppendBoolean(Accept);
            return Message;
        }
    }
}
