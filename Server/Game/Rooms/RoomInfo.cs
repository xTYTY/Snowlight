using System;
using System.Collections.Generic;
using System.Text;
using Snowlight.Util;
using System.Collections.ObjectModel;
using Snowlight.Storage;
using System.Data;
using Snowlight.Game.Navigation;
using Snowlight.Specialized;

namespace Snowlight.Game.Rooms
{
    public enum RoomType
    {
        Public = 0,
        Flat = 1
    }

    public enum RoomAccessType
    {
        Open = 0,
        Locked = 1,
        PasswordProtected = 2
    }

    public class RoomInfo
    {
        private uint mId;
        private RoomType mType;
        private uint mOwnerId;
        private string mName;
        private string mDescription;
        private List<string> mTags;
        private RoomAccessType mAccessType;
        private string mPassword;
        private RoomIcon mIcon;
        private int mCategoryId;
        private int mMaxUsers;
        private string mSwfs;
        private double mCacheAge;
        private int mScore;
        private string mModelName;
        private bool mAllowPets;
        private bool mAllowPetEating;
        private bool mDisableRoomBlocking;
        private bool mHideWalls;
        private int mWallThickness;
        private int mFloorThickness;
        private string mPubInternalName;
        private Dictionary<string, string> mDecorations;
        private object mSyncRoot;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public RoomType Type
        {
            get
            {
                return mType;
            }
        }

        public uint OwnerId
        {
            get
            {
                return (mType == RoomType.Public ? 0 : mOwnerId);
            }
        }

        public string OwnerName
        {
            get
            {
                return (OwnerId == 0 ? string.Empty : CharacterResolverCache.GetNameFromUid(OwnerId));
            }
        }

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

        public ReadOnlyCollection<string> Tags
        {
            get
            {
                return mTags.AsReadOnly();
            }
        }

        public RoomAccessType AccessType
        {
            get
            {
                return mAccessType;
            }

            set
            {
                mAccessType = value;
            }
        }

        public string Password
        {
            get
            {
                return mPassword;
            }

            set
            {
                mPassword = value;
            }
        }

        public RoomIcon Icon
        {
            get
            {
                return (mType == RoomType.Flat ? mIcon : new RoomIcon(0, 0, new Dictionary<int,int>()));
            }

            set
            {
                mIcon = value;
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

        public int CurrentUsers
        {
            get
            {
                RoomInstance Instance = RoomManager.GetInstanceByRoomId(mId);

                if (Instance != null)
                {
                    return Instance.CachedNavigatorUserCount;
                }

                return 0;
            }
        }

        public int MaxUsers
        {
            get
            {
                return mMaxUsers;
            }
        }

        public string SWFs
        {
            get
            {
                return (mType == RoomType.Flat ? string.Empty : mSwfs);
            }
        }

        public double CacheAge
        {
            get
            {
                return (UnixTimestamp.GetCurrent() - mCacheAge);
            }
        }

        public int Score
        {
            get
            {
                return mScore;
            }
        }

        public string ModelName
        {
            get
            {
                return mModelName;
            }
        }

        public bool AllowPets
        {
            get
            {
                return (mType == RoomType.Flat ? mAllowPets : false);
            }
        }

        public bool AllowPetEating
        {
            get
            {
                return (mType == RoomType.Flat ? mAllowPetEating : false);
            }
        }

        public bool DisableRoomBlocking
        {
            get
            {
                return (mType == RoomType.Flat ? mDisableRoomBlocking : true);
            }
        }

        public bool HideWalls
        {
            get
            {
                return (mType == RoomType.Flat ? mHideWalls : false);
            }
        }

        public bool CanTrade
        {
            get
            {
                return (mType == RoomType.Flat ? Navigator.CanTradeInCategory(mCategoryId) : false);
            }
        }

        public string PubInternalName
        {
            get
            {
                return (mType == RoomType.Flat ? string.Empty : mPubInternalName);
            }
        }

        public int WallThickness
        {
            get
            {
                return mWallThickness;
            }
        }

        public int FloorThickness
        {
            get
            {
                return mFloorThickness;
            }
        }

        public Dictionary<string, string> Decorations
        {
            get
            {
                lock (mSyncRoot)
                {
                    Dictionary<string, string> Copy = new Dictionary<string, string>();

                    foreach (KeyValuePair<string, string> Data in mDecorations)
                    {
                        Copy.Add(Data.Key, Data.Value);
                    }

                    return new Dictionary<string, string>(Copy);
                }
            }
        }

        public RoomInfo(uint Id, RoomType Type, uint OwnerId, string Name, string Description, List<string> Tags,
            RoomAccessType AccessType, string Password, RoomIcon Icon, int CategoryId, int MaxUsers, string Swfs,
            int Score, string ModelName, bool AllowPets, bool AllowPetEating, bool DisableBlocking, bool HideWalls,
            string PubInternalName, int WallThickness, int FloorThickness, Dictionary<string, string> Decorations)
        {
            mId = Id;
            mType = Type;
            mOwnerId = OwnerId;
            mName = Name;
            mDescription = Description;
            mTags = Tags;
            mAccessType = AccessType;
            mPassword = Password;
            mIcon = Icon;
            mCategoryId = CategoryId;
            mMaxUsers = MaxUsers;
            mSwfs = Swfs;
            mCacheAge = UnixTimestamp.GetCurrent();
            mScore = Score;
            mModelName = ModelName;
            mAllowPets = AllowPets;
            mAllowPetEating = AllowPetEating;
            mDisableRoomBlocking = DisableBlocking;
            mHideWalls = HideWalls;
            mPubInternalName = PubInternalName;
            mWallThickness = WallThickness;
            mFloorThickness = FloorThickness;
            mDecorations = Decorations;
            mSyncRoot = new object();
        }

        public RoomModel TryGetModel()
        {
            lock (mSyncRoot)
            {
                return RoomManager.GetModel(mModelName);
            }
        }

        public void EditRoom(string Name, string Description, RoomAccessType AccessType, string Password, int UserLimit,
            int CategoryId, List<string> Tags, bool AllowPets, bool AllowPetEating, bool DisableBlocking, bool HideWalls,
            int WallThickness, int FloorThickness)
        {
            lock (mSyncRoot)
            {
                mName = Name;
                mDescription = Description;
                mAccessType = AccessType;
                mPassword = Password;
                mMaxUsers = UserLimit;
                mCategoryId = CategoryId;
                mTags = Tags;
                mAllowPets = AllowPets;
                mAllowPetEating = AllowPetEating;
                mDisableRoomBlocking = DisableBlocking;
                mHideWalls = HideWalls;
                mWallThickness = WallThickness;
                mFloorThickness = FloorThickness;

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    StringBuilder FormattedTags = new StringBuilder();

                    foreach (string Tag in Tags)
                    {
                        if (FormattedTags.Length > 0)
                        {
                            FormattedTags.Append(",");
                        }

                        FormattedTags.Append(Tag);
                    }

                    string AccessTypeString = "open";

                    if (mAccessType == RoomAccessType.PasswordProtected)
                    {
                        AccessTypeString = "password";
                    }
                    else if (mAccessType == RoomAccessType.Locked)
                    {
                        AccessTypeString = "doorbell";
                    }

                    MySqlClient.SetParameter("id", mId);
                    MySqlClient.SetParameter("name", mName);
                    MySqlClient.SetParameter("description", mDescription);
                    MySqlClient.SetParameter("accesstype", AccessTypeString);
                    MySqlClient.SetParameter("password", mPassword);
                    MySqlClient.SetParameter("maxusers", mMaxUsers);
                    MySqlClient.SetParameter("categoryid", mCategoryId);
                    MySqlClient.SetParameter("allowpets", mAllowPets ? "1" : "0");
                    MySqlClient.SetParameter("allowpeteating", mAllowPetEating ? "1" : "0");
                    MySqlClient.SetParameter("disableblocking", mDisableRoomBlocking ? "1" : "0");
                    MySqlClient.SetParameter("hidewalls", mHideWalls ? "1" : "0");
                    MySqlClient.SetParameter("tags", FormattedTags.ToString());
                    MySqlClient.SetParameter("wthickness", mWallThickness);
                    MySqlClient.SetParameter("fthickness", mFloorThickness);
                    MySqlClient.ExecuteNonQuery("UPDATE rooms SET name = @name, description = @description, tags = @tags, access_type = @accesstype, password = @password, category = @categoryid, max_users = @maxusers, allow_pets = @allowpets, allow_pet_eating = @allowpeteating, disable_blocking = @disableblocking, hide_walls = @hidewalls, thickness_wall = @wthickness, thickness_floor = @fthickness WHERE id = @id LIMIT 1");
                }
            }
        }

        public void UpdateIcon(int Background, int Foreground, Dictionary<int, int> Objects)
        {
            lock (mSyncRoot)
            {
                mIcon = new RoomIcon(Background, Foreground, Objects);

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", mId);
                    MySqlClient.SetParameter("icon", mIcon.Serialize());
                    MySqlClient.ExecuteNonQuery("UPDATE rooms SET icon = @icon WHERE id = @id LIMIT 1");
                }
            }
        }

        public void IncreaseScore()
        {
            lock (mSyncRoot)
            {
                mScore++;

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", mId);
                    MySqlClient.SetParameter("score", mScore);
                    MySqlClient.ExecuteNonQuery("UPDATE rooms SET score = @score WHERE id = @id LIMIT 1");
                }
            }
        }

        public void ApplyDecoration(SqlDatabaseClient MySqlClient, string Key, string Value)
        {
            lock (mSyncRoot)
            {
                if (!mDecorations.ContainsKey(Key))
                {
                    mDecorations.Add(Key, Value);
                }
                else
                {
                    mDecorations[Key] = Value;
                }

                StringBuilder DecorationString = new StringBuilder();

                foreach (KeyValuePair<string, string> Decoration in mDecorations)
                {
                    if (DecorationString.Length > 0)
                    {
                        DecorationString.Append('|');
                    }

                    DecorationString.Append(Decoration.Key);
                    DecorationString.Append('=');
                    DecorationString.Append(Decoration.Value);
                }

                MySqlClient.SetParameter("id", mId);
                MySqlClient.SetParameter("decorations", DecorationString);
                MySqlClient.ExecuteNonQuery("UPDATE rooms SET decorations = @decorations WHERE id = @id LIMIT 1");
            }
        }
    }
}
