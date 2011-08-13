using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Misc
{
    public class NewItemsCache : IDisposable
    {
        private uint mUserId;
        private Dictionary<int, List<uint>> mInner;
        private object mSyncRoot;

        public Dictionary<int, List<uint>> NewItems
        {
            get
            {
                lock (mSyncRoot)
                {
                    Dictionary<int, List<uint>> Copy = new Dictionary<int, List<uint>>();

                    foreach (KeyValuePair<int, List<uint>> Data in mInner)
                    {
                        Copy.Add(Data.Key, Data.Value);
                    }

                    return new Dictionary<int, List<uint>>(Copy);
                }
            }
        }

        public NewItemsCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mInner = new Dictionary<int, List<uint>>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("userid", mUserId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT tab_id,item_id FROM new_items WHERE user_id = @userid");

                foreach (DataRow Row in Table.Rows)
                {
                    MarkNewItem(null, (int)Row["tab_id"], (uint)Row["item_id"], false);
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

        public void MarkNewItem(SqlDatabaseClient MySqlClient, int TabId, uint ItemId, bool SynchronizeDatabase = true)
        {
            lock (mSyncRoot)
            {
                if (!mInner.ContainsKey(TabId))
                {
                    mInner[TabId] = new List<uint>();
                }

                mInner[TabId].Add(ItemId);

                if (SynchronizeDatabase)
                {
                    MySqlClient.SetParameter("userid", mUserId);
                    MySqlClient.SetParameter("tabid", TabId);
                    MySqlClient.SetParameter("itemid", ItemId);
                    MySqlClient.ExecuteNonQuery("INSERT INTO new_items (user_id,tab_id,item_id) VALUES (@userid,@tabid,@itemid)");
                }
            }
        }

        public void MarkTabRead(int TabId)
        {
            lock (mSyncRoot)
            {
                if (!mInner.ContainsKey(TabId))
                {
                    return;
                }

                mInner[TabId].Clear();

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("userid", mUserId);
                    MySqlClient.SetParameter("tabid", TabId);
                    MySqlClient.ExecuteNonQuery("DELETE FROM new_items WHERE tab_id = @tabid AND user_id = @userid");
                }
            }
        }

        public void SendNewItems(Session Session)
        {
            lock (mSyncRoot)
            {
                Session.SendData(InventoryNewItemsComposer.Compose(NewItems));
            }
        }
    }
}
