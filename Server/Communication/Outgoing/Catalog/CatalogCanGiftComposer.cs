using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogCanGiftComposer
    {
        public static ServerMessage Compose(uint ItemId, bool CanGift)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_CAN_GIFT);
            Message.AppendUInt32(ItemId);
            Message.AppendBoolean(false/*CanGift*/);
            return Message;
        }
    }
}
