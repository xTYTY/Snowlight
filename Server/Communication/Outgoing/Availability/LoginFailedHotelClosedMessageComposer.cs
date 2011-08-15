using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class LoginFailedHotelClosedMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
            return new ServerMessage(294); // TODO: Update opcodes + find out what this is used for?
        }
    }
}
