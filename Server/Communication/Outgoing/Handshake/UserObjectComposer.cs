using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing.Handshake
{
    public static class UserObjectComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.USER_OBJECT); // TODO: Find out what this actually does
        }
    }
}
