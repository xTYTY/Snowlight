using System;
using System.Collections.Generic;
using Snowlight.Game.Rooms;
using Snowlight.Game.Rooms.Events;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorRoomListComposer
    {
        public static ServerMessage Compose(int CategoryId, int Mode, string UserQuery, List<RoomInstance> Rooms, bool ShowEventData = false)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_ROOM_LIST);
            Message.AppendInt32(CategoryId);
            Message.AppendInt32(Mode);
            Message.AppendStringWithBreak(UserQuery);
            Message.AppendInt32(Rooms.Count);

            foreach (RoomInstance Instance in Rooms)
            {
                SerializeRoom(Message, Instance.Info, (ShowEventData && Instance.HasOngoingEvent ? Instance.Event : null));
            }

            return Message;
        }

        public static ServerMessage Compose(int CategoryId, int Mode, string UserQuery, List<RoomInfo> Rooms)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_ROOM_LIST);
            Message.AppendInt32(CategoryId);
            Message.AppendInt32(Mode);
            Message.AppendStringWithBreak(UserQuery);
            Message.AppendInt32(Rooms.Count);

            foreach (RoomInfo Info in Rooms)
            {
                SerializeRoom(Message, Info);
            }

            return Message;
        }

        public static void SerializeRoom(ServerMessage Message, RoomInfo Info, RoomEvent EventData = null)
        {
            bool ShowingEvent = (EventData != null);

            Message.AppendUInt32(Info.Id);                                                  // Actual priv room ID
            Message.AppendBoolean(ShowingEvent);                                         // Unknown
            Message.AppendStringWithBreak(ShowingEvent ? EventData.Name : Info.Name);                                       // Name
            Message.AppendStringWithBreak(Info.OwnerName);                                  // Descr
            Message.AppendInt32((int)Info.AccessType);                                      // Room state                                    
            Message.AppendInt32(Info.CurrentUsers);           // Users now
            Message.AppendInt32(Info.MaxUsers);                                             // Users max
            Message.AppendStringWithBreak(ShowingEvent ? EventData.Description : Info.Description);                                // Descr
            Message.AppendInt32(0);                                                         // Unknown
            Message.AppendBoolean(Info.CanTrade);                                                   // Enable trade
            Message.AppendInt32(Info.Score);                                                // Score
            Message.AppendInt32(ShowingEvent? EventData.CategoryId : Info.CategoryId);                                           // Category
            Message.AppendStringWithBreak(ShowingEvent ? EventData.TimeStartedString : string.Empty);                                              // Unknown, seems no effect
            Message.AppendInt32(Info.Tags.Count);                                           // Tag count

            foreach (string Tag in Info.Tags)
            {
                Message.AppendStringWithBreak(Tag);                                          
            }
            
            Message.AppendInt32(Info.Icon.BackgroundImageId);                               // Icon bg
            Message.AppendInt32(Info.Icon.OverlayImageId);                                  // Icon overlay
            Message.AppendInt32(Info.Icon.Objects.Count);                           // Icon fg count

            foreach (KeyValuePair<int, int> Data in Info.Icon.Objects)
            {
                Message.AppendInt32(Data.Key);                                                         
                Message.AppendInt32(Data.Value);                                                        
            }

            Message.AppendInt32(0);                                                         // Added in R63; unknown. Seems to have no effect.
            Message.AppendInt32(1);                                                         // Eof message, unknown
        }
    }
}
