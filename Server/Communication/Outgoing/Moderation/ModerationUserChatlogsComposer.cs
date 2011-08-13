using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Util;
using Snowlight.Game.Rooms;
using Snowlight.Game.Moderation;
using Snowlight.Specialized;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationUserChatlogsComposer
    {
        public static ServerMessage Compose(uint UserId, Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>> Entries)
        {
            string CharacterNameString = CharacterResolverCache.GetNameFromUid(UserId);

            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_CHATLOGS_USER);
            Message.AppendUInt32(UserId);
            Message.AppendStringWithBreak(CharacterNameString);
            Message.AppendInt32(Entries.Count);

            foreach (KeyValuePair<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>> EntryData in Entries)
            {
                RoomInfo Info = RoomInfoLoader.GetRoomInfo(EntryData.Key.RoomId);

                Message.AppendBoolean(Info != null && Info.Type == RoomType.Public);
                Message.AppendUInt32(Info != null ? Info.Id : 0);
                Message.AppendStringWithBreak(Info != null ? Info.Name : "(Unknown room)");
                Message.AppendInt32(EntryData.Value.Count);

                foreach (ModerationChatlogEntry Entry in EntryData.Value)
                {
                    DateTime Time = UnixTimestamp.GetDateTimeFromUnixTimestamp(Entry.Timestamp);

                    Message.AppendInt32(Time.Hour);
                    Message.AppendInt32(Time.Minute);
                    Message.AppendUInt32(Entry.UserId);
                    Message.AppendStringWithBreak(Entry.UserId == UserId ? CharacterNameString :
                        CharacterResolverCache.GetNameFromUid(Entry.UserId));
                    Message.AppendStringWithBreak(Entry.Message);
                }
            }

            return Message;
        }
    }
}
