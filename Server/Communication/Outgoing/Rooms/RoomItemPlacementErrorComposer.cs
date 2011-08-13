using System;

namespace Snowlight.Communication.Outgoing
{
    public enum RoomItemPlacementErrorCode
    {
        InsufficientRights = 1,
        FurniLimitReached = 20,
        PetLimitReached = 21,
        RollerLimitReached = 22,
        CannotPlaceMusicPlayer = 23
    }

    public static class RoomItemPlacementErrorComposer
    {
        public static ServerMessage Compose(RoomItemPlacementErrorCode ErrorCode)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_ITEM_PLACEMENT_ERROR);
            Message.AppendInt32((int)ErrorCode);
            return Message;
        }
    }
}
