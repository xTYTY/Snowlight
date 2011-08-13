using System;
using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryItemAddedComposer
    {
        public static ServerMessage Compose(Item Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_ITEM_ADDED);
            InventoryComposer.SerializeInventoryItem(Message, Item);
            return Message;
        }
    }
}
