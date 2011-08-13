using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Achievements;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class AchievementListComposer
    {
        public static ServerMessage Compose(Session Session, ReadOnlyCollection<Achievement> Achievements)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACHIEVEMENTS_LIST);
            Message.AppendInt32(Achievements.Count);

            foreach (Achievement Achievement in Achievements)
            {
                UserAchievement UserData = Session.AchievementCache.GetAchievementData(Achievement.GroupName);
                int TargetLevel = (UserData != null ? UserData.Level + 1 : 1);
                int TotalLevels = Achievement.Levels.Count;

                if (TargetLevel > TotalLevels)
                {
                    TargetLevel = TotalLevels;
                }
                
                AchievementLevel TargetLevelData = Achievement.Levels[TargetLevel];

                Message.AppendUInt32(Achievement.Id);                                                           // Unknown (ID?)
                Message.AppendInt32(TargetLevel);                                                   // Target level
                Message.AppendStringWithBreak(Achievement.GroupName + TargetLevel);                 // Target name/desc/badge
                Message.AppendInt32(TargetLevelData.Requirement);                                   // Progress req/target        
                Message.AppendInt32(TargetLevelData.PixelReward);                                   // Pixel reward       
                Message.AppendInt32(TargetLevelData.PointsReward);                                  // Unknown(??)
                Message.AppendInt32(UserData != null ? UserData.Progress : 0);                      // Current progress
                Message.AppendBoolean(UserData != null ? (UserData.Level >= TotalLevels) : false);  // Set 100% completed(??)
                Message.AppendStringWithBreak(Achievement.Category);                                // Category
                Message.AppendInt32(TotalLevels);                                                   // Total amount of levels 
            }

            return Message;
        }
    }
}
