using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Snowlight.Specialized;
using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryComposer
    {
        public static ServerMessage Compose(string Type, List<Item> Items)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY);
            Message.AppendStringWithBreak(Type.ToUpper());
            Message.AppendBoolean(true);
            Message.AppendBoolean(true);
            Message.AppendInt32(Items.Count);

            // tGArTCS[]pGArTCXVOI[]HHIHM[]H
            foreach (Item Item in Items)
            {
                SerializeInventoryItem(Message, Item);
            }

            return Message;
        }

        public static void SerializeInventoryItem(ServerMessage Message, Item Item)
        {
            int TypeNumber = 1;
            uint SecondaryId = 0;

            switch (Item.Definition.Behavior)
            {
                default:
                case ItemBehavior.StaticItem:

                    TypeNumber = 1;
                    break;

                case ItemBehavior.Wallpaper:

                    TypeNumber = 2;
                    break;

                case ItemBehavior.Floor:

                    TypeNumber = 3;
                    break;

                case ItemBehavior.Landscape:

                    TypeNumber = 4;
                    break;

                case ItemBehavior.MusicDisk:

                    TypeNumber = 8;
                    uint.TryParse(Item.DisplayFlags, out SecondaryId);
                    break;
            }

            Message.AppendUInt32(Item.Id); // Item ID in the negatives (0 - id)
            Message.AppendStringWithBreak(Item.Definition.TypeLetter.ToUpper()); // Type (I, S, E, etc)
            Message.AppendUInt32(Item.Id); // Item ID in the positives (0 + id)
            Message.AppendUInt32(Item.Definition.SpriteId); // Sprite
            Message.AppendInt32(TypeNumber);
            Message.AppendStringWithBreak(Item.DisplayFlags); // Unknown
            Message.AppendBoolean(Item.CanRecycle);
            Message.AppendBoolean(Item.CanTrade);
            Message.AppendBoolean(Item.Definition.AllowInventoryStack);
            Message.AppendBoolean(Item.CanSell);
            Message.AppendInt32(-1);

            if (Item.Definition.Type == ItemType.FloorItem)
            {
                Message.AppendStringWithBreak(string.Empty);
                Message.AppendUInt32(SecondaryId);
            }
        }
    }
}
