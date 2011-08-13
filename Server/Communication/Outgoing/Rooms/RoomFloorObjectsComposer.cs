using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomFloorObjectsComposer
    {
        public static ServerMessage Compose(ReadOnlyCollection<Item> Items)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_FLOOR_OBJECTS);
            Message.AppendInt32(Items.Count);

            foreach (Item Item in Items)
            {
                RoomItemComposer.SerializeFloorItem(Message, Item);
            }

            return Message;
        }
    }
}
