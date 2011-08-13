using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserRespectedComposer
    {
        public static ServerMessage Compose(uint UserId, int Respect)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_RESPECTED);
            Message.AppendUInt32(UserId);
            Message.AppendInt32(Respect);
            return Message;
        }
    }
}
