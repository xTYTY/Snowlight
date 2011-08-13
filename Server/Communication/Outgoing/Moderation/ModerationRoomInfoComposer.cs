using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Rooms;
using Snowlight.Game.Rooms.Events;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationRoomInfoComposer
    {
        public static ServerMessage Compose(RoomInfo Info, RoomInstance Instance)
        {
            ReadOnlyCollection<string> Tags = Info.Tags;
            RoomEvent Event = (Instance == null ? null : Instance.Event);

            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_ROOM_INFO);
            Message.AppendUInt32(Info.Id);
            Message.AppendInt32(Info.CurrentUsers);
            Message.AppendBoolean(Instance == null ? false : (Instance.GetActorByReferenceId(Info.OwnerId) != null));
            Message.AppendUInt32(Info.OwnerId);
            Message.AppendStringWithBreak(Info.OwnerName);
            Message.AppendUInt32(Info.Id);
            Message.AppendStringWithBreak(Info.Name);
            Message.AppendStringWithBreak(Info.Description);
            Message.AppendInt32(Tags.Count);

            foreach (string Tag in Tags)
            {
                Message.AppendStringWithBreak(Tag);
            }

            Message.AppendBoolean(Event != null);

            if (Event != null)
            {
                List<string> EventTags = Event.Tags;

                Message.AppendStringWithBreak(Event.Name);
                Message.AppendStringWithBreak(Event.Description);
                Message.AppendInt32(EventTags.Count);

                foreach (string Tag in EventTags)
                {
                    Message.AppendStringWithBreak(Tag);
                }
            }

            return Message;
        }
    }
}
