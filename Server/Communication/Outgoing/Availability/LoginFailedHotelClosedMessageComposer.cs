using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class LoginFailedHotelClosedMessageComposer
    {
        public static ServerMessage Compose(int ReopeningHour, int ReopeningMinute)
        {
            // com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
            ServerMessage Message = new ServerMessage(294);
            Message.AppendInt32(ReopeningHour);
            Message.AppendInt32(ReopeningMinute);
            return Message;
        }
    }
}
