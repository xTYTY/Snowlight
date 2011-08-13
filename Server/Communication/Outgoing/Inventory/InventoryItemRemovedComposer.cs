using System;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryItemRemovedComposer
    {
        public static ServerMessage Compose(uint ItemId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_ITEM_REMOVED);
            Message.AppendUInt32(ItemId);
            return Message;
        }
    }
}
