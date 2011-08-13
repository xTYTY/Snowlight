using System;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomFloorItemPlacedComposer
    {
        public static ServerMessage Compose(Item Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_ITEM_PLACED);
            RoomItemComposer.SerializeFloorItem(Message, Item);
            return Message;
        }
    }
}
