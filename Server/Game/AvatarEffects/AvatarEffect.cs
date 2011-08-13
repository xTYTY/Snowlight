using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.AvatarEffects
{
    public class AvatarEffect
    {
        private uint mId;
        private int mSpriteId;
        private double mDuration;
        private bool mActivated;
        private double mTimestampActivated;
        private int mQuantity;
        private object mSyncRoot;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public int SpriteId
        {
            get
            {
                return mSpriteId;
            }
        }

        public double Duration
        {
            get
            {
                return mDuration;
            }
        }

        public bool Activated
        {
            get
            {
                return mActivated;
            }
        }

        public double TimeUsed
        {
            get
            {
                return UnixTimestamp.GetCurrent() - mTimestampActivated;
            }
        }

        public double TimeLeft
        {
            get
            {
                double tl = (mActivated ? mDuration - TimeUsed : mDuration);

                if (tl < 0)
                {
                    tl = 0;
                }

                return tl;
            }
        }

        public bool HasExpired
        {
            get
            {
                return mActivated && TimeLeft <= 0;
            }
        }

        public int Quantity
        {
            get
            {
                return mQuantity;
            }
        }

        public AvatarEffect(uint Id, int SpriteId, double Duration, int Quantity, bool Activated, double TimestampActivated)
        {
            mId = Id;
            mSpriteId = SpriteId;
            mDuration = Duration;
            mActivated = Activated;
            mTimestampActivated = TimestampActivated;
            mQuantity = Quantity;
            mSyncRoot = new object();
        }

        public void Activate()
        {
            lock (mSyncRoot)
            {
                mActivated = true;
                mTimestampActivated = UnixTimestamp.GetCurrent();

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", mId);
                    MySqlClient.SetParameter("timestamp", mTimestampActivated);
                    MySqlClient.ExecuteNonQuery("UPDATE avatar_effects SET activated = '1', timestamp_activated = @timestamp WHERE id = @id LIMIT 1");
                }
            }
        }

        public void HandleExpiration(Session Session)
        {
            lock (mSyncRoot)
            {
                mQuantity--;

                mActivated = false;
                mTimestampActivated = 0;

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", mId);

                    if (mQuantity < 1)
                    {
                        MySqlClient.ExecuteNonQuery("DELETE FROM avatar_effects WHERE id = @id LIMIT 1");
                    }
                    else
                    {
                        MySqlClient.SetParameter("quantity", mQuantity);
                        MySqlClient.ExecuteNonQuery("UPDATE avatar_effects SET quantity = @quantity, activated = '0', timestamp_activated = 0 WHERE id = @id LIMIT 1");
                    }
                }

                Session.SendData(UserEffectRemovedComposer.Compose(this));

                RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

                if (Instance == null)
                {
                    return;
                }

                RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

                if (Actor == null)
                {
                    return;
                }

                if (Actor.AvatarEffectId == mSpriteId)
                {
                    Actor.ApplyEffect(0);
                    Session.CurrentEffect = 0;
                }
            }
        }

        public void AddToQuantity()
        {
            lock (mSyncRoot)
            {
                mQuantity++;

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", mId);
                    MySqlClient.SetParameter("quantity", mQuantity);
                    MySqlClient.ExecuteNonQuery("UPDATE avatar_effects SET quantity = @quantity WHERE id = @id LIMIT 1");
                }
            }
        }
    }
}
