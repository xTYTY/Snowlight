using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomCanCreateEventComposer
    {
        public static ServerMessage Compose(int ErrorCode)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_EVENT_CAN_CREATE);
            Message.AppendBoolean(ErrorCode < 1);
            Message.AppendInt32(ErrorCode);
            return Message;
        }
    }
}
