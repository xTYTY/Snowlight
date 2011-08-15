using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class ActivityPointsMessageComposer
    {
        public static ServerMessage Compose()
        {
            ServerMessage Message = new ServerMessage(628); // TODO: Update Opcodes
            Message.AppendInt32(1);
            Message.AppendInt32(0);
            Message.AppendInt32(2971);
            return Message;
        }
    }
}
