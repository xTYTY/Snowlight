using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class InfoHotelClosedMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
            return new ServerMessage(292); // TODO: Update opcodes + find out what this is for
        }
    }
}
