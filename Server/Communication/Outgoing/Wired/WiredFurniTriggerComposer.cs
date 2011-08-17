using System;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniTriggerComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
            return new ServerMessage(OpcodesOut.WIRED_FURNI_TRIGGER); // TODO: Needs to be completed.. this is just header..
        }
    }
}
