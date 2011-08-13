using System;

namespace Snowlight.Game.Moderation
{
    public class HelpCategory
    {
        private uint mId;
        private string mName;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Name
        {
            get
            {
                return mName;
            }
        }

        public int ArticleCount
        {
            get
            {
                return HelpTool.GetArticleCountForCategory(mId);
            }
        }

        public HelpCategory(uint Id, string Name)
        {
            mId = Id;
            mName = Name;
        }
    }
}
