using System;

namespace Snowlight.Communication.Outgoing
{
    public static class UserHomeRoomComposer
    {
        public static ServerMessage Compose(uint RoomId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_HOME_ROOM);
            Message.AppendUInt32(RoomId);
            return Message;
        }
    }
}
