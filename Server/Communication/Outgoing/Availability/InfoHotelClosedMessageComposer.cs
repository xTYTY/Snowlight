using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class InfoHotelClosedMessageComposer
    {
        public static ServerMessage Compose(int ReopeningHour, int ReopeningMinute)
        {
            // com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
            ServerMessage Message = new ServerMessage(292);
            Message.AppendInt32(ReopeningHour);
            Message.AppendInt32(ReopeningMinute);
            return Message;
        }
    }
}
