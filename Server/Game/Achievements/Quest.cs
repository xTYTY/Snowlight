using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Game.Achievements
{
    public enum QuestType
    {
        FURNI_MOVE = 0,
        FURNI_ROTATE = 1,
        FURNI_PLACE = 2,
        FURNI_PICK = 3,
        FURNI_SWITCH = 4,
        FURNI_STACK = 5,
        FURNI_DECORATION_FLOOR = 6,
        FURNI_DECORATION_WALL = 7,
        SOCIAL_VISIT = 8,
        SOCIAL_CHAT = 9,
        SOCIAL_FRIEND = 10,
        SOCIAL_RESPECT = 11,
        SOCIAL_DANCE = 12,
        SOCIAL_WAVE = 13,
        PROFILE_CHANGE_LOOK = 14,
        PROFILE_CHANGE_MOTTO = 15,
        PROFILE_BADGE = 16,
        EXPLORE_FIND_ITEM = 17
    }

    public class Quest
    {
        private uint mId;
        private string mCategory;
        private int mSeriesNumber;
        private QuestType mGoalType;
        private uint mGoalData;
        private string mName;
        private int mReward;
        private string mDataBit;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Category
        {
            get
            {
                return mCategory;
            }
        }

        public int Number
        {
            get
            {
                return mSeriesNumber;
            }
        }

        public QuestType GoalType
        {
            get
            {
                return mGoalType;
            }
        }

        public uint GoalData
        {
            get
            {
                return mGoalData;
            }
        }

        public string ActionName
        {
            get
            {
                switch (mGoalType)
                {
                    case QuestType.SOCIAL_WAVE:

                        return "WAVE";

                    case QuestType.SOCIAL_DANCE:

                        return "DANCE";

                    case QuestType.SOCIAL_RESPECT:

                        return "GIVE_RESPECT";

                    case QuestType.SOCIAL_FRIEND:

                        return "REQUEST_FRIEND";

                    case QuestType.SOCIAL_CHAT:

                        return "CHAT_WITH_SOMEONE";

                    case QuestType.SOCIAL_VISIT:

                        return "ENTER_OTHERS_ROOM";

                    case QuestType.PROFILE_BADGE:

                        return "WEAR_BADGE";

                    case QuestType.PROFILE_CHANGE_MOTTO:

                        return "CHANGE_MOTTO";

                    case QuestType.PROFILE_CHANGE_LOOK:

                        return "CHANGE_FIGURE";

                    case QuestType.FURNI_DECORATION_WALL:

                        return "PLACE_WALLPAPER";

                    case QuestType.FURNI_DECORATION_FLOOR:

                        return "PLACE_FLOOR";

                    case QuestType.FURNI_STACK:

                        return "STACK_ITEM";

                    case QuestType.FURNI_SWITCH:

                        return "SWITCH_ITEM_STATE";

                    case QuestType.FURNI_PICK:

                        return "PICKUP_ITEM";

                    case QuestType.FURNI_PLACE:

                        return "PLACE_ITEM";

                    case QuestType.FURNI_ROTATE:

                        return "ROTATE_ITEM";

                    case QuestType.FURNI_MOVE:

                        return "MOVE_ITEM";

                    default:
                    case QuestType.EXPLORE_FIND_ITEM:

                        return "FIND_STUFF";
                }
            }
        }

        public string QuestName
        {
            get
            {
                return mName;
            }
        }

        public int Reward
        {
            get
            {
                return mReward;
            }
        }

        public string DataBit
        {
            get
            {
                return mDataBit;
            }
        }

        public Quest(uint Id, string Category, int Number, QuestType GoalType, uint GoalData, string Name, int Reward,
            string DataBit)
        {
            mId = Id;
            mCategory = Category;
            mSeriesNumber = Number;
            mGoalType = GoalType;
            mGoalData = GoalData;
            mName = Name;
            mReward = Reward;
            mDataBit = DataBit;
        }

        public bool IsCompleted(int UserProgress)
        {
            switch (mGoalType)
            {
                default:

                    return (UserProgress >= mGoalData);

                case QuestType.EXPLORE_FIND_ITEM:

                    return (UserProgress >= 1);
            }
        }
    }
}
