using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class EventStreamComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.friendlist.EventStreamEvent;
            ServerMessage Message = new ServerMessage(950);
            // TODO: Packet log this
            return Message;
        }
    }
}
