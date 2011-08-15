using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class UniqueMachineIDComposer
    {
        public static ServerMessage Compose(string MachineID)
        {
            // com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
            ServerMessage Message = new ServerMessage(OpcodesOut.UNIQUE_MACHINE_ID); // TODO: Find out how this is actually used
            Message.AppendStringWithBreak(MachineID);
            return Message;
        }
    }
}
