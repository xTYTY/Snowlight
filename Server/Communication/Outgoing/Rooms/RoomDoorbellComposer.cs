using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomDoorbellComposer
    {
        public static ServerMessage Compose(string Username = "")
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_DOORBELL);
            Message.AppendStringWithBreak(Username);
            return Message;
        }
    }
}
