using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserTypingComposer
    {
        public static ServerMessage Compoze(uint ActorId, bool IsTyping)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_TYPING);
            Message.AppendUInt32(ActorId);
            Message.AppendBoolean(IsTyping);
            return Message;
        }
    }
}
