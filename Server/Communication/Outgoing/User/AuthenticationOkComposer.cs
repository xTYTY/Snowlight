using System;

namespace Snowlight.Communication.Outgoing
{
    public static class AuthenticationOkComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.AUTHENTICATION_OK);
        }
    }
}
