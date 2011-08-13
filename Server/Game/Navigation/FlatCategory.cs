using System;

namespace Snowlight.Game.Navigation
{
    public class FlatCategory
    {
        private int mId;
        private bool mVisible;
        private string mTitle;
        private bool mAllowTrading;

        public int Id
        {
            get
            {
                return mId;
            }
        }

        public bool Visible
        {
            get
            {
                return mVisible;
            }
        }

        public string Title
        {
            get
            {
                return mTitle;
            }
        }

        public bool AllowTrading
        {
            get
            {
                return mAllowTrading;
            }
        }

        public FlatCategory(int Id, bool Visible, string Title, bool AllowTrading)
        {
            mId = Id;
            mVisible = Visible;
            mTitle = Title;
            mAllowTrading = AllowTrading;
        }
    }
}
