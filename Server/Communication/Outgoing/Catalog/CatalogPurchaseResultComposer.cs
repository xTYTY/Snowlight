using System;

using Snowlight.Game.Items;
using Snowlight.Game.Catalog;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogPurchaseResultComposer
    {
        public static ServerMessage Compose(CatalogItem Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_PURCHASE_RESULT);
            Message.AppendUInt32(Item.Definition.Id);
            Message.AppendStringWithBreak(Item.DisplayName);
            Message.AppendInt32(Item.CostCredits);
            Message.AppendInt32(Item.CostActivityPoints);
            Message.AppendInt32(0); // No noticable effect
            Message.AppendInt32(1); // Amount of messages shown to end user
            Message.AppendStringWithBreak(Item.Definition.TypeLetter);
            Message.AppendUInt32(Item.Definition.SpriteId);
            Message.AppendStringWithBreak(Item.PresetFlags);
            Message.AppendInt32(1); // ??????????????????????
            Message.AppendInt32(0); // ?????????????
            Message.AppendInt32(0); // ?????????????????
            return Message;
        }

        public static ServerMessage Compose(CatalogClubOffer Item)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_PURCHASE_RESULT);
            Message.AppendUInt32(Item.Id);
            Message.AppendStringWithBreak(Item.DisplayName);
            Message.AppendInt32(Item.Price);
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            return Message;
        }
    }
}
