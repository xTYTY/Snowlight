using System;

namespace Snowlight.Communication.Outgoing
{
    public static class TradeInitiatedComposer
    {
        public static ServerMessage Compose(uint UserOne, bool UserOneCanTrade, uint UserTwo, bool UserTwoCanTrade)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_TRADE_INITIATED);
            Message.AppendUInt32(UserOne);
            Message.AppendBoolean(UserOneCanTrade);
            Message.AppendUInt32(UserTwo);
            Message.AppendBoolean(UserTwoCanTrade);
            return Message;
        }
    }
}
