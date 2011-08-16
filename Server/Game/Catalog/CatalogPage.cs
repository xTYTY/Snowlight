using System;
using System.Collections.Generic;
using Snowlight.Game.Items;
using Snowlight.Storage;

using System.Data;

namespace Snowlight.Game.Catalog
{
    public class CatalogPage
    {
        private int mId;
        private int mParentId;
        private string mCaption;
        private int mIcon;
        private int mColor;
        private string mRequiredRight;
        private bool mVisible;
        private bool mDummyPage;
        private string mTemplate;
        private List<string> mPageStrings1;
        private List<string> mPageStrings2;
        private List<CatalogItem> mItems;

        public int Id
        {
            get
            {
                return mId;
            }
        }

        public int ParentId
        {
            get
            {
                return mParentId;
            }
        }

        public bool RootPage
        {
            get
            {
                return (mParentId == 0);
            }
        }

        public string Caption
        {
            get
            {
                return mCaption;
            }
        }

        public int Icon
        {
            get
            {
                return mIcon;
            }
        }

        public int Color
        {
            get
            {
                return mColor;
            }
        }

        public string RequiredRight
        {
            get
            {
                return mRequiredRight;
            }
        }

        public bool Visible
        {
            get
            {
                return mVisible;
            }
        }

        public bool DummyPage
        {
            get
            {
                return mDummyPage;
            }
        }

        public string Template
        {
            get
            {
                return mTemplate;
            }
        }

        public List<string> PageStrings1
        {
            get
            {
                return mPageStrings1;
            }
        }

        public List<string> PageStrings2
        {
            get
            {
                return mPageStrings2;
            }
        }

        public List<CatalogItem> Items
        {
            get
            {
                return mItems;
            }
        }

        public CatalogPage(int Id, int ParentId, string Caption, int Icon, int Color, string RequiredRight, bool Visible,
            bool DummyPage, string Template, List<string> PageStrings1, List<string> PageStrings2,
            List<CatalogItem> Items)
        {
            mId = Id;
            mParentId = ParentId;
            mCaption = Caption;
            mIcon = Icon;
            mColor = Color;
            mRequiredRight = RequiredRight;
            mVisible = Visible;
            mDummyPage = DummyPage;
            mTemplate = Template;
            mPageStrings1 = PageStrings1;
            mPageStrings2 = PageStrings2;
            mItems = Items;
        }

        public CatalogItem GetItem(uint ItemId)
        {
            foreach (CatalogItem Item in mItems)
            {
                if (Item.Id == ItemId)
                {
                    return Item;
                }
            }

            return null;
        }
    }
}