using System;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorFavoriteRoomsChanged
    {
        public static ServerMessage Compose(uint RoomId, bool Added)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_FAVORITE_ROOMS_CHANGED);
            Message.AppendUInt32(RoomId);
            Message.AppendBoolean(Added);
            return Message;
        }
    }
}
