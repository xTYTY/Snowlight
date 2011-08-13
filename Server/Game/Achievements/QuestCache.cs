using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;

namespace Snowlight.Game.Achievements
{
    public class QuestCache
    {
        private uint mUserId;
        private Dictionary<uint, int> mInner;
        private uint mCurrentQuest;
        private object mSyncRoot;

        public uint CurrentQuestId
        {
            get
            {
                return mCurrentQuest;
            }
        }

        public QuestCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mInner = new Dictionary<uint, int>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("userid", mUserId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT quest_id,progress,is_current FROM user_quests WHERE user_id = @userid");

                foreach (DataRow Row in Table.Rows)
                {
                    uint Id = (uint)Row["quest_id"];

                    mInner.Add(Id, (int)Row["progress"]);

                    if (Row["is_current"].ToString() == "1")
                    {
                        mCurrentQuest = Id;
                    }
                }
            }
        }

        public int GetQuestProgress(uint QuestId)
        {
            lock (mSyncRoot)
            {
                return (mInner.ContainsKey(QuestId) ? mInner[QuestId] : 0);
            }
        }

        public void AddOrUpdateData(SqlDatabaseClient MySqlClient, uint QuestId, int Progress, bool ActiveQuest)
        {
            if (ActiveQuest)
            {
                if (mCurrentQuest > 0)
                {
                    MySqlClient.SetParameter("userid", mUserId);
                    MySqlClient.SetParameter("questid", mCurrentQuest);
                    MySqlClient.ExecuteNonQuery("UPDATE user_quests SET is_current = '0' WHERE user_id = @userid AND quest_id = @questid LIMIT 1");
                }

                mCurrentQuest = QuestId;
            }
            else if (mCurrentQuest == QuestId)
            {
                mCurrentQuest = 0;
            }

            MySqlClient.SetParameter("userid", mUserId);
            MySqlClient.SetParameter("questid", QuestId);
            MySqlClient.SetParameter("progress", Progress);
            MySqlClient.SetParameter("iscurrent", ActiveQuest ? "1" : "0");

            lock (mSyncRoot)
            {
                if (mInner.ContainsKey(QuestId))
                {
                    mInner[QuestId] = Progress;
                    MySqlClient.ExecuteNonQuery("UPDATE user_quests SET progress = @progress, is_current = @iscurrent WHERE user_id = @userid AND quest_id = @questid LIMIT 1");
                }
                else
                {
                    mInner.Add(QuestId, Progress);
                    MySqlClient.ExecuteNonQuery("INSERT INTO user_quests (user_id,quest_id,progress,is_current) VALUES (@userid,@questid,@progress,@iscurrent)");
                }
            }
        }
    }
}
