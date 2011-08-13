using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomFloorItemUpdateFlagsComposer
    {
        public static ServerMessage Compose(uint ItemId, string Flags)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_FLOOR_ITEM_UPDATE_FLAGS);
            Message.AppendStringWithBreak(ItemId.ToString());
            Message.AppendStringWithBreak(Flags);
            return Message;
        }
    }
}
