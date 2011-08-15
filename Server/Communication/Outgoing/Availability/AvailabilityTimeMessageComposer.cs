using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class AvailabilityTimeMessageComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.availability.AvailabilityTimeMessageEvent;
            return new ServerMessage(293); // TODO: Update opcodes + find out what this is for
        }
    }
}
