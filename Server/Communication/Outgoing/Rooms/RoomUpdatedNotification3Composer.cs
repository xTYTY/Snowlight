using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUpdatedNotification3Composer
    {
        public static ServerMessage Compose(uint RoomId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_UPDATED_NOTIFICATION_3);
            Message.AppendUInt32(RoomId);
            Message.AppendBoolean(true);
            return Message;
        }
    }
}
