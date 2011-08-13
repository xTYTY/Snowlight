using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomItemHeightmapComposer
    {
        public static ServerMessage Compose(string Heightmap)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_HEIGHTMAP);
            Message.AppendStringWithBreak(Heightmap);
            return Message;
        }
    }
}
