using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUrlComposer
    {
        public static ServerMessage Compose(string Url)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_URL);
            Message.AppendStringWithBreak(Url);
            return Message;
        }
    }
}
