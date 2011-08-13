using System;
using System.Collections.Generic;
using System.Text;

using Snowlight.Game.Rooms;
using Snowlight.Communication;

namespace Snowlight.Game.Navigation
{
    public enum NavigatorOfficialItemDisplayType
    {
        Banner = 0,
        Detailed = 1
    }

    public enum NavigatorOfficialItemImageType
    {
        Internal = 0,
        External = 1
    }

    public class NavigatorOfficialItem
    {
        private uint mId;
        private uint mParentId;
        private uint mRoomId;
        private bool mIsCategory;
        private NavigatorOfficialItemDisplayType mDisplayType;
        private string mName;
        private string mDescr;
        private NavigatorOfficialItemImageType mImageType;
        private string mImage;
        private string mBannerLabel;
        private bool mCategoryAutoExpand;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public uint ParentId
        {
            get
            {
                return mParentId;
            }
        }

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public bool IsCategory
        {
            get
            {
                return mIsCategory;
            }
        }

        public NavigatorOfficialItemDisplayType DisplayType
        {
            get
            {
                return mDisplayType;
            }
        }

        public string Name
        {
            get
            {
                return mName;
            }
        }

        public string Descr
        {
            get
            {
                return mDescr;
            }
        }

        public NavigatorOfficialItemImageType ImageType
        {
            get
            {
                return mImageType;
            }
        }

        public string Image
        {
            get
            {
                return mImage;
            }
        }

        public string BannerLabel
        {
            get
            {
                return mBannerLabel;
            }
        }

        public bool CategoryAutoExpand
        {
            get
            {
                return mCategoryAutoExpand;
            }
        }

        public NavigatorOfficialItem(uint Id, uint ParentId, uint RoomId, bool IsCategory,
            NavigatorOfficialItemDisplayType DisplayType, string Name, string Descr, NavigatorOfficialItemImageType ImageType,
            string Image, string BannerLabel, bool CategoryAutoExpand)
        {
            mId = Id;
            mParentId = ParentId;
            mRoomId = RoomId;
            mIsCategory = IsCategory;
            mDisplayType = DisplayType;
            mName = Name;
            mDescr = Descr;
            mImageType = ImageType;
            mImage = Image;
            mBannerLabel = BannerLabel;
            mCategoryAutoExpand = CategoryAutoExpand;
        }

        public RoomInstance TryGetRoomInstance()
        {
            return RoomManager.GetInstanceByRoomId(mRoomId);
        }

        public RoomInfo GetRoomInfo()
        {
            return RoomInfoLoader.GetRoomInfo(mRoomId);
        }
    }
}
