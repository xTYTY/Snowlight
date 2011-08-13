using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Sessions;
using Snowlight.Util;
using Snowlight.Game.Characters;
using Snowlight.Storage;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerFriendListComposer
    {
        public static ServerMessage Compose(ReadOnlyCollection<uint> Friends)
        {
            // @LXKAXKAXVBXaCHIkXuzd0zoNeXxIHHH01-01-2011 13:18:32Alex BrookerPYQA
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_FRIENDS_LIST);
            Message.AppendInt32(300);
            Message.AppendInt32(300);
            Message.AppendInt32(800);
            Message.AppendInt32(1100);
            Message.AppendInt32(0); // unknown. club membership limits y/n maybe??
            Message.AppendInt32(Friends.Count);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                foreach (uint FriendId in Friends)
                {
                    CharacterInfo Info = CharacterInfoLoader.GetCharacterInfo(MySqlClient, FriendId);

                    if (Info == null)
                    {
                        continue;
                    }

                    Session Session = SessionManager.GetSessionByCharacterId(Info.Id);

                    Message.AppendUInt32(Info.Id);
                    Message.AppendStringWithBreak(Info.Username);
                    Message.AppendBoolean(true);
                    Message.AppendBoolean(Info.HasLinkedSession);
                    Message.AppendBoolean(Session != null && Session.InRoom);
                    Message.AppendStringWithBreak(Info.HasLinkedSession ? Info.Figure : string.Empty);
                    Message.AppendBoolean(false);
                    Message.AppendStringWithBreak(Info.HasLinkedSession ? Info.Motto : string.Empty);

                    if (Info.HasLinkedSession)
                    {
                        Message.AppendStringWithBreak(string.Empty);
                    }
                    else
                    {
                        DateTime LastOnline = UnixTimestamp.GetDateTimeFromUnixTimestamp(Info.TimestampLastOnline);
                        Message.AppendStringWithBreak(LastOnline.ToShortDateString() + " " + LastOnline.ToShortTimeString());
                    }

                    Message.AppendStringWithBreak(Info.RealName);
                    Message.AppendStringWithBreak(string.Empty); // Unknown - since RELEASE63-33530-33497
                }
            }

            return Message;
        }
    }
}
