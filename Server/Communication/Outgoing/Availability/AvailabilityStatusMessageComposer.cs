using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class AvailabilityStatusMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
            ServerMessage Message = new ServerMessage(290); // TODO: Update opcodes + find out what this is used for?
            Message.AppendInt32(1);
            Message.AppendInt32(0);
            return Message;
        }
    }
}
