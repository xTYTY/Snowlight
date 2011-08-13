using System;
using System.Collections.Generic;
using System.Text;

using Snowlight.Game.Characters;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerSearchResultsComposer
    {
        public static ServerMessage Compose(List<CharacterInfo> Friends, List<CharacterInfo> NonFriends)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_SEARCH_RESULT);
            Message.AppendInt32(Friends.Count);

            foreach (CharacterInfo Info in Friends)
            {
                Session FriendSession = SessionManager.GetSessionByCharacterId(Info.Id);

                Message.AppendUInt32(Info.Id);
                Message.AppendStringWithBreak(Info.Username);
                Message.AppendStringWithBreak(Info.Motto);
                Message.AppendBoolean(Info.HasLinkedSession);
                Message.AppendBoolean(FriendSession != null ? FriendSession.InRoom : false);
                Message.AppendStringWithBreak(string.Empty);
                Message.AppendBoolean(true);
                Message.AppendStringWithBreak(Info.HasLinkedSession ? Info.Figure : string.Empty);

                if (Info.HasLinkedSession)
                {
                    Message.AppendStringWithBreak(string.Empty);
                }
                else
                {
                    DateTime LastOnline = UnixTimestamp.GetDateTimeFromUnixTimestamp(Info.TimestampLastOnline);
                    Message.AppendStringWithBreak(LastOnline.ToShortDateString() + " " + LastOnline.ToShortTimeString());
                }

                Message.AppendStringWithBreak(string.Empty);
            }

            Message.AppendInt32(NonFriends.Count);

            foreach (CharacterInfo Info in NonFriends)
            {
                Message.AppendUInt32(Info.Id);
                Message.AppendStringWithBreak(Info.Username);
                Message.AppendStringWithBreak(Info.Motto);
                Message.AppendBoolean(Info.HasLinkedSession);
                Message.AppendBoolean(false); // TODO: InRoom (really needed here??)
                Message.AppendStringWithBreak(string.Empty);
                Message.AppendBoolean(false);
                Message.AppendStringWithBreak(Info.HasLinkedSession ? Info.Figure : string.Empty);

                if (Info.HasLinkedSession)
                {
                    Message.AppendStringWithBreak(string.Empty);
                }
                else
                {
                    DateTime LastOnline = UnixTimestamp.GetDateTimeFromUnixTimestamp(Info.TimestampLastOnline);
                    Message.AppendStringWithBreak(LastOnline.ToShortDateString() + " " + LastOnline.ToShortTimeString());
                }

                Message.AppendStringWithBreak(string.Empty);
            }

            return Message;
        }
    }
}
