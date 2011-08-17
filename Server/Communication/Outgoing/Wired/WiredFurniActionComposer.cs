using System;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniActionComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
            return new ServerMessage(OpcodesOut.WIRED_FURNI_ACTION); // TODO: Needs to be completed.. this is just header..
        }
    }
}
