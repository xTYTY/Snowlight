using System;
using System.Collections.ObjectModel;
using System.Collections.Generic;

using Snowlight.Specialized;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryNewItemsComposer
    {
        public static ServerMessage Compose(int TabId, uint ItemId)
        {
            Dictionary<int, List<uint>> Base = new Dictionary<int, List<uint>>();
            Base.Add(TabId, new List<uint>() { ItemId });
            return Compose(new Dictionary<int, List<uint>>(Base));
        }

        public static ServerMessage Compose(Dictionary<int, List<uint>> NewItems)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_NEW_ITEM);
            Message.AppendInt32(NewItems.Count);

            foreach (KeyValuePair<int, List<uint>> Data in NewItems)
            {
                Message.AppendInt32(Data.Key);
                Message.AppendInt32(Data.Value.Count);

                foreach (uint Id in Data.Value)
                {
                    Message.AppendUInt32(Id);
                }
            }

            return Message;
        }
    }
}
