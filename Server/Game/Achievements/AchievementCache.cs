using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Storage;
using System.Data;

namespace Snowlight.Game.Achievements
{
    public class AchievementCache
    {
        private uint mUserId;
        private Dictionary<string, UserAchievement> mInner;
        private object mSyncRoot;

        public AchievementCache(SqlDatabaseClient MySqlClient, uint UserId)
        {
            mUserId = UserId;
            mInner = new Dictionary<string, UserAchievement>();
            mSyncRoot = new object();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mInner.Clear();

                MySqlClient.SetParameter("userid", mUserId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT group_id,level,progress FROM user_achievements WHERE user_id = @userid");

                foreach (DataRow Row in Table.Rows)
                {
                    string Group = (string)Row["group_id"];

                    mInner.Add(Group, new UserAchievement(Group, (int)Row["level"], (int)Row["progress"]));
                }
            }
        }

        public UserAchievement GetAchievementData(string AchievementGroup)
        {
            lock (mSyncRoot)
            {
                return (mInner.ContainsKey(AchievementGroup) ? mInner[AchievementGroup] : null);
            }
        }

        public void AddOrUpdateData(SqlDatabaseClient MySqlClient, string Group, int Level, int Progress)
        {
            MySqlClient.SetParameter("userid", mUserId);
            MySqlClient.SetParameter("group", Group);
            MySqlClient.SetParameter("level", Level);
            MySqlClient.SetParameter("progress", Progress);

            lock (mSyncRoot)
            {
                if (mInner.ContainsKey(Group))
                {
                    mInner[Group].Level = Level;
                    mInner[Group].Progress = Progress;

                    MySqlClient.ExecuteNonQuery("UPDATE user_achievements SET level = @level, progress = @progress WHERE user_id = @userid AND group_id = @group LIMIT 1");
                }
                else
                {
                    mInner.Add(Group, new UserAchievement(Group, Level, Progress));

                    MySqlClient.ExecuteNonQuery("INSERT INTO user_achievements (user_id,group_id,level,progress) VALUES (@userid,@group,@level,@progress)");
                }
            }
        }
    }
}
