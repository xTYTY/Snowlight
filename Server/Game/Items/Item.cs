using System;
using System.Data;

using Snowlight.Storage;
using Snowlight.Specialized;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;
using System.Collections.Generic;

namespace Snowlight.Game.Items
{
    public class Item
    {
        private uint mId;
        private uint mDefinitionId;
        private uint mUserId;
        private uint mRoomId;
        private Vector3 mRoomPos;
        private string mRoomWallPos;
        private int mRoomRot;
        private string mFlags;
        private string mDisplayFlags;
        private string mInitialFlags;
        private bool mUntradable;
        private ItemDefinition mCachedDefinition;
        private bool mUpdateNeeded;
        private int mUpdateTicks;
        private Dictionary<int, uint> mTmpInteractingUsers;
        private uint mSoundManagerId;
        private int mSoundManagerOrder;
        private double mExpireTimestamp;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public ItemDefinition Definition
        {
            get
            {
                if (mCachedDefinition == null)
                {
                    mCachedDefinition = ItemDefinitionManager.GetDefinition(mDefinitionId);
                }

                return mCachedDefinition;
            }
        }

        public uint DefinitionId
        {
            get
            {
                return mDefinitionId;
            }
        }

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

        public Vector3 RoomPosition
        {
            get
            {
                return mRoomPos;
            }
        }

        public Vector2 SquareInFront
        {
            get
            {
                Vector2 NewPosition = mRoomPos.GetVector2();

                if (mRoomRot == 0)
                {
                    NewPosition.Y--;
                }
                else if (mRoomRot == 2)
                {
                    NewPosition.X++;
                }
                else if (mRoomRot == 4)
                {
                    NewPosition.Y++;
                }
                else if (mRoomRot == 6)
                {
                    NewPosition.X--;
                }

                return NewPosition;
            }
        }

        public Vector2 SquareBehind
        {
            get
            {
                Vector2 NewPosition = mRoomPos.GetVector2();

                if (mRoomRot == 0)
                {
                    NewPosition.Y++;
                }
                else if (mRoomRot == 2)
                {
                    NewPosition.X--;
                }
                else if (mRoomRot == 4)
                {
                    NewPosition.Y--;
                }
                else if (mRoomRot == 6)
                {
                    NewPosition.X++;
                }

                return NewPosition;
            }
        }

        public string RoomWallPosition
        {
            get
            {
                return mRoomWallPos;
            }
        }

        public int RoomRotation
        {
            get
            {
                return mRoomRot;
            }
        }

        public string Flags
        {
            get
            {
                return mFlags;
            }

            set
            {
                mFlags = value;
            }
        }

        public string DisplayFlags
        {
            get
            {
                return mDisplayFlags;
            }

            set
            {
                mDisplayFlags = value;
            }
        }

        public bool CanTrade
        {
            get
            {
                return (!mUntradable && Definition.AllowTrade);
            }
        }

        public bool CanRecycle
        {
            get
            {
                return (!mUntradable && Definition.AllowRecycle);
            }
        }

        public bool CanSell
        {
            get
            {
                return (!mUntradable && Definition.AllowSell);
            }
        }

        public bool InRoom
        {
            get
            {
                return (mRoomId > 0);
            }
        }

        private bool UpdateNeeded
        {
            get
            {
                return mUpdateNeeded;
            }
        }

        private int UpdateTicks
        {
            get
            {
                return mUpdateTicks;
            }
        }

        public Dictionary<int, uint> TemporaryInteractionReferenceIds
        {
            get
            {
                return mTmpInteractingUsers;
            }

            set
            {
                mTmpInteractingUsers = value;
            }
        }

        public bool InSoundManager
        {
            get
            {
                return mSoundManagerId > 0;
            }
        }

        public uint SoundManagerId
        {
            get
            {
                return mSoundManagerId;
            }
        }

        public int SoundManagerOrder
        {
            get
            {
                return mSoundManagerOrder;
            }
        }

        public bool PendingExpiration
        {
            get
            {
                return (mExpireTimestamp > 0);
            }
        }

        public double ExpireTimeLeft
        {
            get
            {
                return mExpireTimestamp - UnixTimestamp.GetCurrent();
            }
        }

        public Item(uint Id, uint DefinitionId, uint UserId, uint RoomId, Vector3 RoomPos, string RoomWallPos, int Rotation,
            string Flags, string DisplayFlags, bool Untradable, uint SoundManagerId, int SoundManagerOrder, double ExpireTimestamp)
        {
            mId = Id;
            mDefinitionId = DefinitionId;
            mUserId = UserId;
            mRoomId = RoomId;
            mRoomPos = RoomPos;
            mRoomWallPos = RoomWallPos;
            mRoomRot = Rotation;
            mFlags = Flags;
            mDisplayFlags = DisplayFlags;
            mInitialFlags = Flags;
            mUntradable = Untradable;
            mCachedDefinition = ItemDefinitionManager.GetDefinition(mDefinitionId);
            mTmpInteractingUsers = new Dictionary<int, uint>();
            mSoundManagerId = SoundManagerId;
            mSoundManagerOrder = SoundManagerOrder;
            mExpireTimestamp = ExpireTimestamp;
        }

        public void Update(RoomInstance Instance)
        {
            if (mUpdateTicks > 0)
            {
                mUpdateTicks--;
            }

            if (mUpdateNeeded && mUpdateTicks <= 0)
            {
                mUpdateNeeded = false;
                ItemEventDispatcher.InvokeItemEventHandler(null, this, Instance, ItemEventType.UpdateTick);
            }
        }

        public void RequestUpdate(int Ticks)
        {
            mUpdateNeeded = true;
            mUpdateTicks = Ticks;
        }

        public void MoveToUserInventory(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mRoomId = 0;
            mRoomPos = new Vector3(0, 0, 0);
            mRoomWallPos = string.Empty;
            mRoomRot = 0;
            mSoundManagerId = 0;
            mSoundManagerOrder = 0;

            if (MySqlClient != null)
            {
                SynchronizeDatabase(MySqlClient);
                RoomManager.UnmarkWriteback(this);
            }
        }

        public void MoveToRoom(SqlDatabaseClient MySqlClient, uint RoomId, Vector3 Position, int Rotation, string WallPos = "")
        {
            mUserId = 0;
            mRoomId = RoomId;
            mRoomPos = Position;
            mRoomWallPos = WallPos;
            mRoomRot = Rotation;
            mSoundManagerId = 0;
            mSoundManagerOrder = 0;

            if (MySqlClient != null)
            {
                SynchronizeDatabase(MySqlClient);
                RoomManager.UnmarkWriteback(this);
            }
        }

        public void MoveToSoundManager(SqlDatabaseClient MySqlClient, uint SoundManagerId, int Order)
        {
            mUserId = 0;
            mRoomId = 0;
            mRoomPos = new Vector3();
            mRoomWallPos = string.Empty;
            mRoomRot = 0;
            mSoundManagerId = SoundManagerId;
            mSoundManagerOrder = Order;

            if (MySqlClient != null)
            {
                SynchronizeDatabase(MySqlClient);
                RoomManager.UnmarkWriteback(this);
            }
        }

        public void SynchronizeDatabase(SqlDatabaseClient MySqlClient, bool FlagsOnly = false)
        {
            MySqlClient.SetParameter("id", mId);
            MySqlClient.SetParameter("flags", mFlags);
            MySqlClient.SetParameter("flagsd", mDisplayFlags);

            if (FlagsOnly)
            {
                MySqlClient.ExecuteNonQuery("UPDATE items SET flags = @flags, flags_display = @flagsd WHERE id = @id LIMIT 1");
            }
            else
            {
                MySqlClient.SetParameter("userid", mUserId);
                MySqlClient.SetParameter("roomid", mRoomId);
                MySqlClient.SetParameter("roompos", mRoomPos.ToString());
                MySqlClient.SetParameter("roomwallpos", mRoomWallPos);
                MySqlClient.SetParameter("roomrot", mRoomRot);
                MySqlClient.SetParameter("soundmgrid", mSoundManagerId);
                MySqlClient.SetParameter("soundmgrorder", mSoundManagerOrder);
                MySqlClient.ExecuteNonQuery("UPDATE items SET user_id = @userid, room_id = @roomid, room_pos = @roompos, room_wall_pos = @roomwallpos, room_rot = @roomrot, flags = @flags, flags_display = @flagsd, soundmanager_id = @soundmgrid, soundmanager_order = @soundmgrorder WHERE id = @id LIMIT 1");
            }
        }

        public void BroadcastStateUpdate(RoomInstance Instance)
        {
            if (mCachedDefinition.Type == ItemType.FloorItem)
            {
                Instance.BroadcastMessage(RoomFloorItemUpdateFlagsComposer.Compose(mId, mDisplayFlags));
            }
            else if (mCachedDefinition.Type == ItemType.WallItem)
            {
                Instance.BroadcastMessage(RoomWallItemMovedComposer.Compose(this));
            }
        }

        public void RemovePermanently(SqlDatabaseClient MySqlClient)
        {
            MySqlClient.SetParameter("id", mId);
            MySqlClient.ExecuteNonQuery("DELETE FROM items WHERE id = @id LIMIT 1");       
        }
    }
}
