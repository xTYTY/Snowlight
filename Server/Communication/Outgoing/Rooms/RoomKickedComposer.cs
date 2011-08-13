using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomKickedComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_KICKED);
        }
    }
}
