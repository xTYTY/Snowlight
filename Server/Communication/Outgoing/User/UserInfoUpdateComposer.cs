using System;

using Snowlight.Game.Characters;

namespace Snowlight.Communication.Outgoing
{
    public static class UserInfoUpdateComposer
    {
        public static ServerMessage Compose(uint ActorId, string Look, CharacterGender Gender, string Motto, int Score)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_INFO_UPDATE);

            if (ActorId == 0)
            {
                Message.AppendInt32(-1);
            }
            else
            {
                Message.AppendUInt32(ActorId);
            }

            Message.AppendStringWithBreak(Look);
            Message.AppendStringWithBreak(Gender == CharacterGender.Male ? "m" : "f");
            Message.AppendStringWithBreak(Motto);
            Message.AppendInt32(Score);
            return Message;
        }
    }
}
