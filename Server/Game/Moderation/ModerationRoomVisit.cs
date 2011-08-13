using System;

namespace Snowlight.Game.Moderation
{
    public class ModerationRoomVisit
    {
        private uint mRoomId;
        private double mTimestampEntered;
        private double mTimestampLeft;

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public double TimestampEntered
        {
            get
            {
                return mTimestampEntered;
            }
        }

        public double TimestampLeft
        {
            get
            {
                return mTimestampLeft;
            }
        }
        
        public ModerationRoomVisit(uint RoomId, double TimestampEntered, double TimestampLeft)
        {
            mRoomId = RoomId;
            mTimestampEntered = TimestampEntered;
            mTimestampLeft = TimestampLeft;
        }
    }
}
