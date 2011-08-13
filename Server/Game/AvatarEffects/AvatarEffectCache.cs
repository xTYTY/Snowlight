using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;

using Snowlight.Storage;
using Snowlight.Specialized;
using Snowlight.Game.Sessions;

namespace Snowlight.Game.AvatarEffects
{
    public class AvatarEffectCache : IDisposable
    {
        private uint mUserId;
        private Dictionary<uint, AvatarEffect> mInner;
        private object mSyncRoot;

        public Dictionary<uint, AvatarEffect> Effects
        {
            get
            {
                lock (mSyncRoot)
                {
                    Dictionary<uint, AvatarEffect> Copy = new Dictionary<uint, AvatarEffect>();

                    foreach (KeyValuePair<uint, AvatarEffect> Data in mInner)
                    {
                        Copy.Add(Data.Key, Data.Value);
                    }

                    return new Dictionary<uint, AvatarEffect>(Copy);
                }
            }
        }

        public AvatarEffectCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mInner = new Dictionary<uint, AvatarEffect>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("userid", mUserId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT id,sprite_id,duration,activated,timestamp_activated,quantity FROM avatar_effects WHERE user_id = @userid");

                foreach (DataRow Row in Table.Rows)
                {
                    mInner.Add((uint)Row["id"], new AvatarEffect((uint)Row["id"], (int)Row["sprite_id"],
                        (double)Row["duration"], (int)Row["quantity"], (Row["activated"].ToString() == "1"),
                        (double)Row["timestamp_activated"]));
                }                
            }
        }

        public void Dispose()
        {
            lock (mSyncRoot)
            {
                if (mInner != null)
                {
                    mInner.Clear();
                    mInner = null;
                }
            }
        }

        public void Add(AvatarEffect Effect)
        {
            lock (mSyncRoot)
            {
                mInner.Add(Effect.Id, Effect);
            }
        }

        public void Remove(uint EffectId)
        {
            lock (mSyncRoot)
            {
                if (mInner.ContainsKey(EffectId))
                {
                    mInner.Remove(EffectId);
                }
            }
        }

        public bool HasEffect(int SpriteId, bool ActivatedOnly = false, bool UnactivatedOnly = false)
        {
            return (GetEffect(SpriteId, ActivatedOnly, UnactivatedOnly) != null);
        }

        public AvatarEffect GetEffect(int SpriteId, bool ActivatedOnly = false, bool UnactivatedOnly = false)
        {
            lock (mSyncRoot)
            {
                foreach (AvatarEffect Effect in mInner.Values)
                {
                    if (!Effect.HasExpired && Effect.SpriteId == SpriteId && (!ActivatedOnly || Effect.Activated)
                        && (!UnactivatedOnly || !Effect.Activated))
                    {
                        return Effect;
                    }
                }
            }

            return null;
        }

        public void CheckEffectExpiry(Session Session)
        {
            lock (mSyncRoot)
            {
                foreach (AvatarEffect Effect in mInner.Values)
                {
                    if (Effect.HasExpired)
                    {
                        Effect.HandleExpiration(Session);
                    }
                }
            }
        }
    }
}
