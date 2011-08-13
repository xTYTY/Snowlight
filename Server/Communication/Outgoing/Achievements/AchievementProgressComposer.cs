using System;

using Snowlight.Game.Achievements;

namespace Snowlight.Communication.Outgoing
{
    public static class AchievementProgressComposer
    {
        public static ServerMessage Compose(Achievement Achievement, int TargetLevel, AchievementLevel TargetLevelData,
            int TotalLevels, UserAchievement UserData)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACHIEVEMENTS_PROGRESS_UPDATE);
            Message.AppendUInt32(Achievement.Id);                                               // Unknown (ID?)
            Message.AppendInt32(TargetLevel);                                                   // Target level
            Message.AppendStringWithBreak(Achievement.GroupName + TargetLevel);                 // Target name/desc/badge
            Message.AppendInt32(TargetLevelData.Requirement);                                   // Progress req/target        
            Message.AppendInt32(TargetLevelData.PixelReward);                                   // Pixel reward       
            Message.AppendInt32(TargetLevelData.PointsReward);                                  // Unknown(??)
            Message.AppendInt32(UserData != null ? UserData.Progress : 0);                      // Current progress
            Message.AppendBoolean(UserData != null ? (UserData.Level >= TotalLevels) : false);  // Set 100% completed(??)
            Message.AppendStringWithBreak(Achievement.Category);                                // Category
            Message.AppendInt32(TotalLevels);                                                   // Total amount of levels 
            return Message;
        }
    }
}
