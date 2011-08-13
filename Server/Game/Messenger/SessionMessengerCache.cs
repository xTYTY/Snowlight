using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

using Snowlight.Communication.Outgoing;
using Snowlight.Communication;
using Snowlight.Game.Characters;
using Snowlight.Storage;
using Snowlight.Util;
using Snowlight.Game.Sessions;

namespace Snowlight.Game.Messenger
{
    public class SessionMessengerFriendCache : IDisposable
    {
        private uint mCharacterId;
        private List<uint> mInner;
        private Dictionary<uint, int> mInnerUpdates;

        public ReadOnlyCollection<uint> Friends
        {
            get
            {
                lock (mInner)
                {
                    List<uint> Copy = new List<uint>();
                    Copy.AddRange(mInner);
                    return Copy.AsReadOnly();
                }
            }
        }

        public SessionMessengerFriendCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mCharacterId = UserId;
            mInner = new List<uint>();
            mInnerUpdates = new Dictionary<uint, int>();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mInner)
            {
                mInner.Clear();
                mInnerUpdates.Clear();

                mInner.AddRange(MessengerHandler.GetFriendsForUser(MySqlClient, mCharacterId, 1));
            }
        }

        public void Dispose()
        {
            if (mInner != null)
            {
                mInner.Clear();
                mInner = null;
            }
        }

        public void AddToCache(uint FriendId)
        {
            lock (mInner)
            {
                if (mInner.Contains(FriendId))
                {
                    return;
                }

                mInner.Add(FriendId);
                MarkUpdateNeeded(FriendId, 1);
            }
        }

        public void RemoveFromCache(uint FriendId)
        {
            lock (mInner)
            {
                if (mInner.Contains(FriendId))
                {
                    mInner.Remove(FriendId);
                }

                if (mInnerUpdates.ContainsKey(FriendId))
                {
                    mInnerUpdates.Remove(FriendId);
                }
            }
        }

        public void MarkUpdateNeeded(uint FriendId, int UpdateMode)
        {
            lock (mInnerUpdates)
            {
                if (mInnerUpdates.ContainsKey(FriendId))
                {
                    return;
                }

                mInnerUpdates.Add(FriendId, UpdateMode);
            }
        }

        public ServerMessage ComposeUpdateList()
        {
            lock (mInnerUpdates)
            {
                List<MessengerUpdate> UpdateInfo = new List<MessengerUpdate>();

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    foreach (uint FriendId in mInner)
                    {
                        if (!mInnerUpdates.ContainsKey(FriendId))
                        {
                            continue;
                        }

                        CharacterInfo Info = CharacterInfoLoader.GetCharacterInfo(MySqlClient, FriendId);

                        if (Info == null)
                        {
                            continue;
                        }

                        UpdateInfo.Add(new MessengerUpdate(mInnerUpdates[FriendId], Info));
                    }

                    mInnerUpdates.Clear();
                }

                return MessengerUpdateListComposer.Compose(UpdateInfo);
            }
        }

        public void BroadcastToFriends(ServerMessage ServerMessage)
        {
            List<uint> Copy = new List<uint>();

            lock (mInner)
            {
                Copy.AddRange(mInner);
            }

            foreach (uint FriendId in Copy)
            {
                Session SessionObject = SessionManager.GetSessionByCharacterId(FriendId);

                if (SessionObject == null)
                {
                    continue;
                }

                SessionObject.SendData(ServerMessage);
            }
        }
    }
}
