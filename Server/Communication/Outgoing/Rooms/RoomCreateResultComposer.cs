using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomCreateResultComposer
    {
        public static ServerMessage Compose(uint RoomId, string Name)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_CREATE_RESULT);
            Message.AppendUInt32(RoomId);
            Message.AppendStringWithBreak(Name);
            return Message;
        }
    }
}
