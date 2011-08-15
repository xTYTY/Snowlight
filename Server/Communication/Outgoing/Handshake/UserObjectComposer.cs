using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Game.Characters;

namespace Snowlight.Communication.Outgoing
{
    public static class UserObjectComposer
    {
        public static ServerMessage Compose(Session Session)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_OBJECT);
            Message.AppendStringWithBreak(Session.CharacterId.ToString());
            Message.AppendStringWithBreak(Session.CharacterInfo.Username);
            Message.AppendStringWithBreak(Session.CharacterInfo.Figure);
            Message.AppendStringWithBreak(Session.CharacterInfo.Gender == CharacterGender.Male ? "M" : "F");
            Message.AppendStringWithBreak(Session.CharacterInfo.Motto);
            Message.AppendStringWithBreak(Session.CharacterInfo.RealName);
            Message.AppendInt32(0);
            Message.AppendStringWithBreak("");
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            Message.AppendInt32(Session.CharacterInfo.RespectPoints);
            Message.AppendInt32(Session.CharacterInfo.RespectCreditHuman);
            Message.AppendInt32(Session.CharacterInfo.RespectCreditPets);
            Message.AppendUInt32(24708);
            return Message;
        }
    }
}
