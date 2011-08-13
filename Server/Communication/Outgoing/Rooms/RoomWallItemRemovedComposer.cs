using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomWallItemRemovedComposer
    {
        public static ServerMessage Compose(uint ItemId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_WALL_ITEM_REMOVED);
            Message.AppendRawUInt32(ItemId);
            Message.AppendStringWithBreak(string.Empty);
            Message.AppendBoolean(false);
            return Message;
        }
    }
}
