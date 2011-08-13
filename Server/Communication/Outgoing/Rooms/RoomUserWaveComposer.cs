using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserWaveComposer
    {
        public static ServerMessage Compose(uint ActorId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_WAVE);
            Message.AppendUInt32(ActorId);
            return Message;
        }
    }
}
