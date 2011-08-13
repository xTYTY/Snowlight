using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Moderation;
using Snowlight.Game.Rooms;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationTicketChatlogsComposer
    {
        public static ServerMessage Compose(ModerationTicket Ticket, RoomInfo Info, ReadOnlyCollection<ModerationChatlogEntry> Entries)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_CHATLOGS_TICKET);
            Message.AppendUInt32(Ticket.Id);
            Message.AppendUInt32(Ticket.ReporteeUserId);
            Message.AppendUInt32(Ticket.ReportedUserId);
            Message.AppendUInt32(Ticket.Id); // Number to display in title. Chatlog ID?
            Message.AppendBoolean(Info != null ? Info.Type == RoomType.Public : false);
            Message.AppendUInt32(Info != null ? Info.Id : 0);
            Message.AppendStringWithBreak(Info != null ? Info.Name : "(Unknown room)");

            Message.AppendInt32(Entries.Count);

            foreach (ModerationChatlogEntry Entry in Entries)
            {
                DateTime Time = UnixTimestamp.GetDateTimeFromUnixTimestamp(Entry.Timestamp);

                Message.AppendInt32(Time.Hour);
                Message.AppendInt32(Time.Minute);
                Message.AppendUInt32(Entry.UserId);
                Message.AppendStringWithBreak(Entry.UserName);
                Message.AppendStringWithBreak(Entry.Message);
            }

            return Message;
        }
    }
}
