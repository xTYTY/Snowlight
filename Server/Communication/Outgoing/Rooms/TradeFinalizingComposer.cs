using System;
namespace Snowlight.Communication.Outgoing
{
    public static class TradeFinalizingComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_TRADE_FINALIZING);
        }
    }
}
