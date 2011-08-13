using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserCarryComposer
    {
        public static ServerMessage Compose(uint ActorId, int CarryItemId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_CARRY);
            Message.AppendUInt32(ActorId);
            Message.AppendInt32(CarryItemId); // GbIsIkyN
            return Message;
        }
    }
}
