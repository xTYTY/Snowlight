using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomRightsRemovedConfirmationComposer
    {
        public static ServerMessage Compose(uint RoomId, uint UserId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_RIGHTS_REMOVED_CONFIRMATION);
            Message.AppendUInt32(RoomId);
            Message.AppendUInt32(UserId);
            return Message;
        }
    }
}
