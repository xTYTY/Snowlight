using System;

namespace Snowlight.Communication.Outgoing
{
    public static class AchievementScoreUpdateComposer
    {
        public static ServerMessage Compose(int Score)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACHIEVEMENT_SCORE_UPDATE);
            Message.AppendInt32(Score);
            return Message;
        }
    }
}
