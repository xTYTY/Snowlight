using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Navigation;
using Snowlight.Game.Rooms;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorOfficialRoomsComposer
    {
        public static ServerMessage Message(List<NavigatorOfficialItem> Items)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_OFFICIAL_ROOMS);
            Message.AppendInt32(Items.Count);

            foreach (NavigatorOfficialItem Item in Items)
            {
                if (Item.ParentId != 0)
                {
                    continue;
                }

                SerializeOfficialItem(Item, Message);

                if (Item.IsCategory)
                {
                    foreach (NavigatorOfficialItem Child in Items)
                    {
                        if (Child.ParentId != Item.Id)
                        {
                            continue;
                        }

                        SerializeOfficialItem(Child, Message);
                    }
                }
            }

            return Message;
        }

        private static void SerializeOfficialItem(NavigatorOfficialItem Item, ServerMessage Message)
        {
            RoomInstance Instance = null; 
            RoomInfo Info = null;
            
            if (!Item.IsCategory)
            {
                Instance = Item.TryGetRoomInstance();
                Info = Item.GetRoomInfo();
            }

            int Type = 3;

            if (Item.IsCategory)
            {
                Type = 4;
            }
            else if (Info != null && Info.Type == RoomType.Flat)
            {
                Type = 2;
            }

            Message.AppendUInt32(Item.Id);
            Message.AppendStringWithBreak(Item.Name);
            Message.AppendStringWithBreak(Item.Descr);
            Message.AppendInt32((int)Item.DisplayType);
            Message.AppendStringWithBreak(Item.BannerLabel);
            Message.AppendStringWithBreak(Item.ImageType == NavigatorOfficialItemImageType.External ? Item.Image : string.Empty);
            Message.AppendUInt32(Item.ParentId);
            Message.AppendInt32(Info != null ? Info.CurrentUsers : 0);
            Message.AppendInt32(Type);

            if (Item.IsCategory)
            {
                Message.AppendBoolean(Item.CategoryAutoExpand); // Category auto expand
            }
            else if (Info != null && Info.Type == RoomType.Public)
            {
                Message.AppendStringWithBreak(Item.ImageType == NavigatorOfficialItemImageType.Internal ? Item.Image : string.Empty);
                Message.AppendInt32(0); // Appears to be nothing but junk!
                Message.AppendInt32(0); // Something to do with room parts (e.g. lido part 0 & 1) default 0
                Message.AppendStringWithBreak(Info.SWFs);
                Message.AppendInt32(Info.MaxUsers);
                Message.AppendUInt32(Info.Id);
            }
            else if (Info != null && Info.Type == RoomType.Flat)
            {
                NavigatorRoomListComposer.SerializeRoom(Message, Info);
            }
       }
    }
}
