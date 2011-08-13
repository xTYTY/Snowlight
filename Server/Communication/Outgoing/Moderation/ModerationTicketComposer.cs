using System;
using Snowlight.Game.Moderation;
using Snowlight.Util;
using Snowlight.Game.Rooms;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationTicketComposer
    {
        public static ServerMessage Compose(ModerationTicket Ticket)
        {
            string DisplayRoomName = string.Empty;

            if (Ticket.RoomId > 0)
            {
                RoomInfo Info = RoomInfoLoader.GetRoomInfo(Ticket.RoomId);
                DisplayRoomName = Info == null ? "(Unknown room " + Ticket.RoomId + ")" : Info.Name;
            }

            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_TICKET);
            Message.AppendUInt32(Ticket.Id);
            Message.AppendUInt32(Ticket.TabId);
            Message.AppendUInt32(11); // ?? unknown
            Message.AppendUInt32(Ticket.CategoryId);
            Message.AppendUInt32(11); // ?? unknown
            Message.AppendUInt32(Ticket.Score);
            Message.AppendUInt32(Ticket.ReporteeUserId);
            Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(Ticket.ReporteeUserId)); 
            Message.AppendUInt32(Ticket.ReportedUserId);
            Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(Ticket.ReportedUserId)); 
            Message.AppendUInt32(Ticket.ModeratorUserId);
            Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(Ticket.ModeratorUserId));
            Message.AppendStringWithBreak(Ticket.Message);
            Message.AppendUInt32(Ticket.RoomId);
            Message.AppendStringWithBreak(DisplayRoomName);
            return Message;
        }
    }
}
