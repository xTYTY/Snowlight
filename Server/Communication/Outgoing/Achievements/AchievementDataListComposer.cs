using System;
using System.Collections.Generic;

using Snowlight.Game.Achievements;

namespace Snowlight.Communication.Outgoing
{
    public static class AchievementDataListComposer
    {
        public static ServerMessage Compose(List<Achievement> Achievements)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACHIEVEMENT_DATA_LIST);
            Message.AppendInt32(Achievements.Count);

            foreach (Achievement Achievement in Achievements)
            {
                string DisplayName = Achievement.GroupName;

                if (DisplayName.StartsWith("ACH_"))
                {
                    DisplayName = DisplayName.Substring(4);
                }

                Message.AppendStringWithBreak(DisplayName);
                Message.AppendInt32(Achievement.Levels.Count);

                foreach (AchievementLevel Level in Achievement.Levels.Values)
                {
                    Message.AppendInt32(Level.Number);
                    Message.AppendInt32(Level.Requirement);
                }
            }

            return Message;
        }
    }
}
