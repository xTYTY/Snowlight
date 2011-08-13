using System;

namespace Snowlight.Game.Achievements
{
    public class UserAchievement
    {
        private string mAchievementGroup;
        private int mLevel;
        private int mProgress;

        public string AchievementGroup
        {
            get
            {
                return mAchievementGroup;
            }
        }

        public int Level
        {
            get
            {
                return mLevel;
            }

            set
            {
                mLevel = value;
            }
        }

        public int Progress
        {
            get
            {
                return mProgress;
            }

            set
            {
                mProgress = value;
            }
        }

        public UserAchievement(string AchievementGroup, int Level, int Progress)
        {
            mAchievementGroup = AchievementGroup;
            mLevel = Level;
            mProgress = Progress;
        }

        public string GetBadgeCodeForLevel()
        {
            return mAchievementGroup + mLevel;
        }
    }
}
