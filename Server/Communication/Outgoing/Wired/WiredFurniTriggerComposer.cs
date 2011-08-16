using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniTriggerComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
            return new ServerMessage(650); // TODO: Needs to be completed.. this is just header..
        }
    }
}
