using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomDecorationComposer
    {
        public static ServerMessage Compose(string Key, string Value)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_DECORATION);
            Message.AppendStringWithBreak(Key);
            Message.AppendStringWithBreak(Value);
            return Message;
        }
    }
}
