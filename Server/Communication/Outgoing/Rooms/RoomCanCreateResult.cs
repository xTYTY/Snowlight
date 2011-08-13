using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomCanCreateResult
    {
        public static ServerMessage Compose(bool Error, int RoomLimit)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_CAN_CREATE_RESULT);
            Message.AppendBoolean(Error);
            Message.AppendInt32(RoomLimit);
            return Message;
        }
    }
}
