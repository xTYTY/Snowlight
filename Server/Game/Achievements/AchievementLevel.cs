using System;

namespace Snowlight.Game.Achievements
{
    public class AchievementLevel
    {
        private int mLevel;
        private int mRewardPixels;
        private int mRewardPoints;
        private int mRequirement;

        public int Number
        {
            get
            {
                return mLevel;
            }
        }

        public int PixelReward
        {
            get
            {
                return mRewardPixels;
            }
        }

        public int PointsReward
        {
            get
            {
                return mRewardPoints;
            }
        }

        public int Requirement
        {
            get
            {
                return mRequirement;
            }
        }

        public AchievementLevel(int Level, int PixelReward, int PointReward, int Requirement)
        {
            mLevel = Level;
            mRewardPixels = PixelReward;
            mRewardPoints = PointReward;
            mRequirement = Requirement;
        }
    }
}
