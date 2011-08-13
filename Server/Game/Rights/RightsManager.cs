using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;

namespace Snowlight.Game.Rights
{
    public static class RightsManager
    {
        private static Dictionary<uint, Badge> mBadges;
        private static Dictionary<uint, List<string>> mRightSets;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mBadges = new Dictionary<uint, Badge>();
            mRightSets = new Dictionary<uint,List<string>>();

            RebuildCache(MySqlClient);
        }

        public static void RebuildCache(SqlDatabaseClient MySqlClient)
        {
            lock (mBadges)
            {
                mBadges.Clear();
                mRightSets.Clear();

                DataTable BadgeTable = MySqlClient.ExecuteQueryTable("SELECT id,code,rights_sets FROM badge_definitions");
                DataTable RightsTable = MySqlClient.ExecuteQueryTable("SELECT set_id,right_id FROM rights");

                foreach (DataRow Row in BadgeTable.Rows)
                {
                    List<uint> Sets = new List<uint>();
                    string[] SetBits = ((string)Row["rights_sets"]).Split(',');

                    foreach (string SetBit in SetBits)
                    {
                        uint Set = 0;

                        uint.TryParse(SetBit, out Set);

                        if (Set > 0)
                        {
                            Sets.Add(Set);
                        }
                    }

                    mBadges.Add((uint)Row["id"], new Badge((uint)Row["id"], (string)Row["code"], Sets));
                }

                foreach (DataRow Row in RightsTable.Rows)
                {
                    uint SetId = (uint)Row["set_id"];

                    if (!mRightSets.ContainsKey(SetId))
                    {
                        mRightSets.Add(SetId, new List<string>());
                    }

                    mRightSets[SetId].Add((string)Row["right_id"]);
                }
            }
        }

        public static List<string> GetDefaultRights()
        {
            List<string> Rights = new List<string>();

            if (mRightSets.ContainsKey(0))
            {
                foreach (string Right in mRightSets[0])
                {
                    if (Rights.Contains(Right))
                    {
                        continue;
                    }

                    Rights.Add(Right);
                }
            }

            return Rights;
        }

        public static Badge GetBadgeById(uint Id)
        {
            return (mBadges.ContainsKey(Id) ? mBadges[Id] : null);
        }

        public static Badge GetBadgeByCode(string BadgeCode)
        {
            foreach (Badge Badge in mBadges.Values)
            {
                if (Badge.Code == BadgeCode)
                {
                    return Badge;
                }
            }

            return null;
        }

        public static List<string> GetRightsForBadge(Badge Badge)
        {
            List<string> Rights = new List<string>();

            foreach (uint SetId in Badge.RightsSets)
            {
                if (SetId > 0 && mRightSets.ContainsKey(SetId))
                {
                    foreach (string Right in mRightSets[SetId])
                    {
                        if (Rights.Contains(Right))
                        {
                            continue;
                        }

                        Rights.Add(Right);
                    }
                }
            }

            return Rights;
        }
    }
}
