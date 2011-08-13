using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Game.Moderation
{
    public enum HelpTopicPriority
    {
        NormalTopic = 0,
        FrequentlyAskedQuestion = 1,
        ImportantIssue = 2
    }

    public class HelpTopic
    {
        private uint mId;
        private uint mCategory;
        private string mTitle;
        private string mBody;
        private HelpTopicPriority mPriority;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public uint Category
        {
            get
            {
                return mCategory;
            }
        }

        public string Title
        {
            get
            {
                return mTitle;
            }
        }

        public string Body
        {
            get
            {
                return mBody;
            }
        }

        public HelpTopicPriority Priority
        {
            get
            {
                return mPriority;
            }
        }

        public HelpTopic(uint Id, uint Category, string Title, string Body, HelpTopicPriority Priority)
        {
            mId = Id;
            mCategory = Category;
            mTitle = Title;
            mBody = Body;
            mPriority = Priority;
        }
    }
}
