using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomIgnoreResultComposer
    {
        public static ServerMessage Compose(int Code)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_IGNORE_RESULT);
            Message.AppendInt32(Code);
            return Message;
        }
    }
}
