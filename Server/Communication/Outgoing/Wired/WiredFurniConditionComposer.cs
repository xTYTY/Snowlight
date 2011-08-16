using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class WiredFurniConditionComposer
    {
        public static ServerMessage Compose()
        {
            // com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
            return new ServerMessage(652); // TODO: Needs to be completed.. this is just header..
        }
    }
}
