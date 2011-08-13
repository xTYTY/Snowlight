using System;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomItemUpdatedComposer
    {
        public static ServerMessage Compose(Item Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_ITEM_UPDATED);

            switch (Item.Definition.Type)
            {
                default:
                case ItemType.FloorItem:

                    RoomItemComposer.SerializeFloorItem(Message, Item);
                    break;

                case ItemType.WallItem:

                    RoomItemComposer.SerializeWallItem(Message, Item);
                    break;
            }

            return Message;
        }
    }
}
