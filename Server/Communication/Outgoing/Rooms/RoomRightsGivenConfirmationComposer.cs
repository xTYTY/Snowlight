using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomRightsGivenConfirmationComposer
    {
        public static ServerMessage Compose(uint RoomId, uint UserId, string Name)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_RIGHTS_GIVEN_CONFIRMATION);
            Message.AppendUInt32(RoomId);
            Message.AppendUInt32(UserId);
            Message.AppendStringWithBreak(Name);
            return Message;
        }
    }
}
