using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUpdatedNotification1Composer
    {
        public static ServerMessage Compose(uint RoomId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_UPDATED_NOTIFICATION_1);
            Message.AppendUInt32(RoomId);
            return Message;
        }
    }
}
