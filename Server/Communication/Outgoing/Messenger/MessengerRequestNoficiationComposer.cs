using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerRequestNoficiationComposer
    {
        public static ServerMessage Compose(uint SenderId, string SenderName)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_REQUEST_NOTIFICATION);
            Message.AppendUInt32(SenderId);
            Message.AppendStringWithBreak(SenderName);
            Message.AppendStringWithBreak(SenderId.ToString());
            return Message;
        }
    }
}
