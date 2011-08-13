using System;

namespace Snowlight.Communication.Outgoing
{
    public static class LatencyTestResponseComposer
    {
        public static ServerMessage Compose(int Number)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.SESSION_LATENCY_TEST);
            Message.AppendInt32(Number);
            return Message;
        }
    }
}
