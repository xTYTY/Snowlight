using System;

using Snowlight.Game.Characters;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationUserInfoComposer
    {
        public static ServerMessage Compose(CharacterInfo Info, Session Session)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_USER_INFO);
            Message.AppendUInt32(Info.Id);
            Message.AppendStringWithBreak(Info.Username);
            Message.AppendInt32((int)(UnixTimestamp.GetCurrent() - Info.TimestampRegistered) / 60);
            Message.AppendInt32((int)(UnixTimestamp.GetCurrent() - Info.TimestampLastOnline) / 60);
            Message.AppendBoolean(Session != null);
            Message.AppendInt32(Info.ModerationTickets);
            Message.AppendInt32(Info.ModerationTicketsAbusive);
            Message.AppendInt32(Info.ModerationCautions);
            Message.AppendInt32(Info.ModerationBans);
            return Message;
        }
    }
}
