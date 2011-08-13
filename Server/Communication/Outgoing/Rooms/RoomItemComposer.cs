using System;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomItemComposer
    {
        public static void SerializeFloorItem(ServerMessage Message, Item Item)
        {
            uint SecondaryId = 0;

            if (Item.Definition.Behavior == ItemBehavior.MusicDisk)
            {
                uint.TryParse(Item.DisplayFlags, out SecondaryId);
            }

            Message.AppendUInt32(Item.Id);
            Message.AppendUInt32(Item.Definition.SpriteId);
            Message.AppendInt32(Item.RoomPosition.X);
            Message.AppendInt32(Item.RoomPosition.Y);
            Message.AppendInt32(Item.RoomRotation);
            Message.AppendRawDouble(Item.RoomPosition.Z);
            Message.AppendUInt32(SecondaryId);
            Message.AppendStringWithBreak(Item.DisplayFlags);
            Message.AppendInt32(Item.PendingExpiration ? (int)((double)(Math.Ceiling(Item.ExpireTimeLeft / 60))) + 1 : 0); // Rental expire
            Message.AppendBoolean(Item.Definition.Usable); // Since RELEASE63-33578-33561 => "Use" button
        }

        public static void SerializeWallItem(ServerMessage Message, Item Item)
        {
            // AS3166254YhO:w=0,4 l=7,70 l11
            Message.AppendStringWithBreak(Item.Id.ToString());
            Message.AppendUInt32(Item.Definition.SpriteId);
            Message.AppendStringWithBreak(Item.RoomWallPosition);
            Message.AppendStringWithBreak(Item.DisplayFlags);
            Message.AppendBoolean(Item.Definition.Usable); // Since RELEASE63-33578-33561 => "Use" button
        }
    }
}
