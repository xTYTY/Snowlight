using System;

namespace Snowlight.Communication.Outgoing
{
    public static class AuthenticationOkComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
            return new ServerMessage(OpcodesOut.AUTHENTICATION_OK);
        }
    }
}
