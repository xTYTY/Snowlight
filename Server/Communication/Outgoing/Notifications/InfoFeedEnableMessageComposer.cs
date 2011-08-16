using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class InfoFeedEnableMessageComposer
    {
        public static ServerMessage Compose(uint Status)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INFO_FEED_ENABLE);
            Message.AppendUInt32(Status);
            return Message;
        }
    }
}
