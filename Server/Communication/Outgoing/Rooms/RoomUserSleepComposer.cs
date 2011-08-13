using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserSleepComposer
    {
        public static ServerMessage Compose(uint ActorId, bool SleepState)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_SLEEP);
            Message.AppendUInt32(ActorId);
            Message.AppendBoolean(SleepState);
            return Message;
        }
    }
}
