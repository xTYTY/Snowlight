using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Snowlight.Game.Rooms.Events
{
    public class RoomEvent
    {
        private string mName;
        private string mDescription;
        private int mCategoryId;
        private List<string> mTags;
        private uint mOwnerId;
        private uint mRoomId;
        private double mTimestampStarted;

        public string Name
        {
            get
            {
                return mName;
            }

            set
            {
                mName = value;
            }
        }

        public string Description
        {
            get
            {
                return mDescription;
            }

            set
            {
                mDescription = value;
            }
        }

        public int CategoryId
        {
            get
            {
                return mCategoryId;
            }

            set
            {
                mCategoryId = value;
            }
        }

        public List<string> Tags
        {
            get
            {
                return mTags;
            }

            set
            {
                mTags = value;
            }
        }

        public uint OwnerId
        {
            get
            {
                return mOwnerId;
            }
        }

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public double TimestampStarted
        {
            get
            {
                return mTimestampStarted;
            }
        }

        public string TimeStartedString
        {
            get
            {
                return UnixTimestamp.GetDateTimeFromUnixTimestamp(mTimestampStarted).ToShortTimeString();
            }
        }

        public RoomEvent(string Name, string Description, int CategoryId, List<string> Tags, uint OwnerId, uint RoomId)
        {
            mName = Name;
            mDescription = Description;
            mCategoryId = CategoryId;
            mTags = Tags;
            mOwnerId = OwnerId;
            mRoomId = RoomId;
            mTimestampStarted = UnixTimestamp.GetCurrent();
        }
    }
}
