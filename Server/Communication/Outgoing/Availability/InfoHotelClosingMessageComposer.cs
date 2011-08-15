using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class InfoHotelClosingMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
            return new ServerMessage(291);
        }
    }
}
