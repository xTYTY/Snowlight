using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniActionComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
            return new ServerMessage(651); // TODO: Needs to be completed.. this is just header..
        }
    }
}
