using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomOwnerRightsComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_RIGHTS_OWNER);
        }
    }

    public static class RoomRightsComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_RIGHTS);
        }
    }

    public static class RoomRightsRemovedComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_RIGHTS_REMOVED);
        }
    }
}
