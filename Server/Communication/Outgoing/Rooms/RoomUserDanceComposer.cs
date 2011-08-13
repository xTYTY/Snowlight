using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserDanceComposer
    {
        public static ServerMessage Compose(uint ActorId, int DanceId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_DANCE);
            Message.AppendUInt32(ActorId);
            Message.AppendInt32(DanceId);
            return Message;
        }
    }
}
