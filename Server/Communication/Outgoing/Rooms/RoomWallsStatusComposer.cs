using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomWallsStatusComposer
    {
        public static ServerMessage Compose(bool WallHidden, int WallThickness, int FloorThickness)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_WALLS_STATUS);
            Message.AppendBoolean(WallHidden);
            Message.AppendInt32(WallThickness);
            Message.AppendInt32(FloorThickness);
            return Message;
        }
    }
}
