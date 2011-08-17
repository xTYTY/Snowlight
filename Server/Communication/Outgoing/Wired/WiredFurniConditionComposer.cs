using System;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniConditionComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
            return new ServerMessage(OpcodesOut.WIRED_FURNI_CONDITION); // TODO: Needs to be completed.. this is just header..
        }
    }
}
