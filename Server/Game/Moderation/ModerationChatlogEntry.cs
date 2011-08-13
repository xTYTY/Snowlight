using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Util;

namespace Snowlight.Game.Moderation
{
    public class ModerationChatlogEntry
    {
        private uint mUserId;
        private uint mRoomId;
        private double mTimestamp;
        private string mMessage;

        public uint UserId
        {
            get
            {
                return mUserId;
            }
        }

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public double Timestamp
        {
            get
            {
                return mTimestamp;
            }
        }

        public string Message
        {
            get
            {
                return mMessage;
            }
        }

        public string UserName
        {
            get
            {
                return CharacterResolverCache.GetNameFromUid(mUserId);
            }
        }

        public ModerationChatlogEntry(uint UserId, uint RoomId, double Timestamp, string Message)
        {
            mUserId = UserId;
            mRoomId = RoomId;
            mTimestamp = Timestamp;
            mMessage = Message;
        }
    }
}
