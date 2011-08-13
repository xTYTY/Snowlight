using System;
using System.Collections.Generic;

using Snowlight.Specialized;

namespace Snowlight.Game.Achievements
{
    public class Achievement
    {
        private uint mId;
        private string mGroupName;
        private string mCategory;
        private Dictionary<int, AchievementLevel> mLevels;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string GroupName
        {
            get
            {
                return mGroupName;
            }
        }

        public string Category
        {
            get
            {
                return mCategory;
            }
        }

        public Dictionary<int, AchievementLevel> Levels
        {
            get
            {
                return new Dictionary<int,AchievementLevel>(mLevels);
            }
        }

        public Achievement(uint Id, string GroupName, string Category)
        {
            mId = Id;
            mGroupName = GroupName;
            mCategory = Category;
            mLevels = new Dictionary<int, AchievementLevel>();
        }

        public void AddLevel(AchievementLevel Level)
        {
            mLevels.Add(Level.Number, Level);
        }
    }
}
