using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserEffectComposer
    {
        public static ServerMessage Compose(uint ActorId, int EffectId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_EFFECT);
            Message.AppendUInt32(ActorId);
            Message.AppendInt32(EffectId);
            return Message;
        }
    }
}
