using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Rooms;
using Snowlight.Game.Moderation;
using Snowlight.Util;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationRoomChatlogsComposer
    {
        public static ServerMessage Compose(RoomInfo Info, ReadOnlyCollection<ModerationChatlogEntry> Entries)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_CHATLOGS_ROOM);
            Message.AppendBoolean(Info.Type == RoomType.Public);
            Message.AppendUInt32(Info.Id);
            Message.AppendStringWithBreak(Info.Name);
            Message.AppendInt32(Entries.Count);

            foreach (ModerationChatlogEntry Entry in Entries)
            {
                DateTime Time = UnixTimestamp.GetDateTimeFromUnixTimestamp(Entry.Timestamp);

                Message.AppendInt32(Time.Hour);
                Message.AppendInt32(Time.Minute);
                Message.AppendUInt32(Entry.UserId);
                Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(Entry.UserId));
                Message.AppendStringWithBreak(Entry.Message);
            }

            return Message;
        }
    }
}
