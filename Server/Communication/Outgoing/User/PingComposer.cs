using System;

namespace Snowlight.Communication.Outgoing
{
    public static class PingComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.PING);
        }
    }
}
