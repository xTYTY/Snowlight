using System;

using Snowlight.Game.Achievements;

namespace Snowlight.Communication.Outgoing
{
    public static class AchievementUnlockedComposer
    {
        public static ServerMessage Compose(Achievement Achievement, int Level, int PointReward, int PixelReward)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACHIEVEMENT_UNLOCKED);
            Message.AppendUInt32(Achievement.Id);                                           // Achievement ID
            Message.AppendInt32(Level);                                                     // Achieved level
            Message.AppendInt32(144);                                                         // Unknown. Random useless number.
            Message.AppendStringWithBreak(Achievement.GroupName + Level);                   // Achieved name
            Message.AppendInt32(PointReward);                                               // Point reward
            Message.AppendInt32(PixelReward);                                               // Pixel reward
            Message.AppendInt32(0);                                                         // Unknown.
            Message.AppendInt32(10);                                                         // Unknown.
            Message.AppendInt32(21);                                                         // Unknown. (Extra reward?)
            Message.AppendStringWithBreak(Level > 1 ? Achievement.GroupName + (Level - 1) : string.Empty);
            Message.AppendStringWithBreak(Achievement.Category.ToString());
            return Message;
        }
    }
}
