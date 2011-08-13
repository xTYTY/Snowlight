using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomRelativeHeightmapComposer
    {
        public static ServerMessage Compose(string Heightmap)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_HEIGHTMAP_RELATIVE);
            Message.AppendStringWithBreak(Heightmap);
            return Message;
        }
    }
}
