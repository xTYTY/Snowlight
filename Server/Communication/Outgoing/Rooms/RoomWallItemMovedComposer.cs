using System;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomWallItemMovedComposer
    {
        public static ServerMessage Compose(Item Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_WALL_ITEM_MOVED);
            RoomItemComposer.SerializeWallItem(Message, Item);
            return Message;
        }
    }
}
