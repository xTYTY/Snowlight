using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class InfoHotelClosingMessageComposer
    {
        public static ServerMessage Compose(int ShuttingDownInMinutes)
        {
            // com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
            ServerMessage Message = new ServerMessage(291);
            Message.AppendInt32(ShuttingDownInMinutes);
            return Message;
        }
    }
}
