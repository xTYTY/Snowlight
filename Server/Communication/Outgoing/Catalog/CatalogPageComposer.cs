using System;

using Snowlight.Game.Catalog;
using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogPageComposer
    {
        public static ServerMessage Compose(CatalogPage Page)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_PAGE);
            Message.AppendInt32(Page.Id);
            Message.AppendStringWithBreak(Page.Template);
            Message.AppendInt32(Page.PageStrings1.Count);

            foreach (string PageString in Page.PageStrings1)
            {
                Message.AppendStringWithBreak(PageString);
            }

            Message.AppendInt32(Page.PageStrings2.Count);

            foreach (string PageString in Page.PageStrings2)
            {
                Message.AppendStringWithBreak(PageString);
            }

            Message.AppendInt32(Page.Items.Count);

            foreach (CatalogItem Item in Page.Items)
            {
                Message.AppendUInt32(Item.Id);
                Message.AppendStringWithBreak(Item.DisplayName);
                Message.AppendInt32(Item.CostCredits);
                Message.AppendInt32(Item.CostActivityPoints);
                Message.AppendInt32(0); // other cost
                Message.AppendInt32(1); // unknown.
                Message.AppendStringWithBreak(Item.Definition.TypeLetter);
                Message.AppendUInt32(Item.Definition.SpriteId);
                Message.AppendStringWithBreak(Item.ShowPresetFlags ? Item.PresetFlags : string.Empty); // unknown
                Message.AppendInt32(Item.Amount); // amount
                Message.AppendInt32(-1); // unknown [for deals??]
                Message.AppendInt32(Item.ClubRestriction); // Added in RELEASE63-34159-34129-201106010852
            }

            Message.AppendInt32(-1);
            return Message;
        }
    }
}
