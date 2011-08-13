using System;
using Snowlight.Game.Sessions;
using Snowlight.Specialized;
using Snowlight.Game.Rights;

namespace Snowlight.Game.Rooms
{
    public enum RoomModelType
    {
        Public = 0,
        Flat = 1
    }

    public class RoomModel
    {
        private string mId;
        private RoomModelType mType;
        private Heightmap mHeightmap;
        private Vector3 mDoorPosition;
        private int mDoorRotation;
        private ClubSubscriptionLevel mSubscriptionRequirement;
        private int mMaxUsers;

        public string Id
        {
            get
            {
                return mId;
            }
        }

        public RoomModelType Type
        {
            get
            {
                return mType;
            }
        }

        public Heightmap Heightmap
        {
            get
            {
                return mHeightmap;
            }
        }

        public Vector3 DoorPosition
        {
            get
            {
                return mDoorPosition;
            }
        }

        public int DoorRotation
        {
            get
            {
                return mDoorRotation;
            }
        }

        public ClubSubscriptionLevel SubscriptionRequirement
        {
            get
            {
                return mSubscriptionRequirement;
            }
        }

        public int MaxUsers
        {
            get
            {
                return mMaxUsers;
            }
        }

        public RoomModel(string Id, RoomModelType Type, Heightmap Heightmap, Vector3 DoorPosition, int DoorRotation,
            ClubSubscriptionLevel SubscriptionRequirement, int MaxUsers)
        {
            mId = Id;
            mType = Type;
            mHeightmap = Heightmap;
            mDoorPosition = DoorPosition;
            mDoorRotation = DoorRotation;
            mSubscriptionRequirement = SubscriptionRequirement;
            mMaxUsers = MaxUsers;
        }

        public bool IsUsableBySession(Session Session)
        {
            if (mType == RoomModelType.Public)
            {
                return false;
            }

            switch (mSubscriptionRequirement)
            {
                default:
                case ClubSubscriptionLevel.None:

                    return true;

                case ClubSubscriptionLevel.BasicClub:

                    return (Session.HasRight("club_regular") || Session.HasRight("club_vip"));

                case ClubSubscriptionLevel.VipClub:

                    return (Session.HasRight("club_vip"));
            }
        }
    }
}
