using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomFloorItemRemovedComposer
    {
        public static ServerMessage Compose(uint ItemId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_REMOVE_FLOOR_ITEM);
            Message.AppendRawUInt32(ItemId);
            Message.AppendStringWithBreak(string.Empty);
            Message.AppendBoolean(false);
            return Message;
        }
    }
}
