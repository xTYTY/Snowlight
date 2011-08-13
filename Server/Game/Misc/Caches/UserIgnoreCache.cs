using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;

using Snowlight.Storage;

namespace Snowlight.Game.Misc
{
    public class UserIgnoreCache : IDisposable
    {
        private uint mUserId;
        private List<uint> mInner;
        private object mSyncRoot;

        public ReadOnlyCollection<uint> List
        {
            get
            {
                lock (mSyncRoot)
                {
                    List<uint> Copy = new List<uint>();
                    Copy.AddRange(mInner);
                    return Copy.AsReadOnly();
                }
            }
        }

        public UserIgnoreCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mInner = new List<uint>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("user_id", mUserId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT ignore_id FROM ignores WHERE user_id = @user_id");

                foreach (DataRow Row in Table.Rows)
                {
                    mInner.Add((uint)Row["ignore_id"]);
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

        public void MarkUserIgnored(uint UserId)
        {
            lock (mSyncRoot)
            {
                if (!mInner.Contains(UserId))
                {
                    mInner.Add(UserId);

                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        MySqlClient.SetParameter("user_id", mUserId);
                        MySqlClient.SetParameter("ignore_id", UserId);
                        MySqlClient.ExecuteNonQuery("INSERT INTO ignores (user_id,ignore_id) VALUES (@user_id,@ignore_id)");
                    }
                }
            }
        }

        public void MarkUserUnignored(uint UserId)
        {
            lock (mSyncRoot)
            {
                if (mInner.Contains(UserId))
                {
                    mInner.Remove(UserId);

                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        MySqlClient.SetParameter("user_id", mUserId);
                        MySqlClient.SetParameter("ignore_id", UserId);
                        MySqlClient.ExecuteNonQuery("DELETE FROM ignores WHERE user_id = @user_id AND ignore_id = @ignore_id LIMIT 1");
                    }
                }
            }
        }

        public bool UserIsIgnored(uint UserId)
        {
            lock (mSyncRoot)
            {
                return mInner.Contains(UserId);
            }
        }
    }
}
