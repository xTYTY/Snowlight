using System;
using System.Collections.Generic;

using Snowlight.Game.Rooms.Events;
using Snowlight.Util;
using System.Collections.ObjectModel;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomEventInfoComposer
    {
        public static ServerMessage Compose(RoomEvent Event)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_EVENT_INFO);

            if (Event == null)
            {
                Message.AppendStringWithBreak("-1");
            }
            else
            {
                Message.AppendStringWithBreak(Event.OwnerId.ToString());
                Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(Event.OwnerId));
                Message.AppendStringWithBreak(Event.RoomId.ToString());
                Message.AppendInt32(Event.CategoryId);
                Message.AppendStringWithBreak(Event.Name);
                Message.AppendStringWithBreak(Event.Description);
                Message.AppendStringWithBreak(UnixTimestamp.GetDateTimeFromUnixTimestamp(Event.TimestampStarted).ToShortTimeString());

                List<string> Tags = Event.Tags;

                Message.AppendInt32(Tags.Count);

                foreach (string Tag in Tags)
                {
                    Message.AppendStringWithBreak(Tag);
                }
            }

            return Message;
        }
    }
}
