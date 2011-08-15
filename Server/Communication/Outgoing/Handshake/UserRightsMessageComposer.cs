using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class UserRightsMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
            ServerMessage Message = new ServerMessage(2);  // TODO: Find out what this is, it exists but what does it do?
            return Message;
        }
    }
}
