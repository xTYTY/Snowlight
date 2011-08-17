using System;

namespace Snowlight.Communication.Outgoing
{
    public static class UniqueMachineIdComposer
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
