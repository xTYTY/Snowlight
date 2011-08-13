using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;

namespace Snowlight.Game.Pets
{
    public static class PetDataManager
    {
        private static Dictionary<int, List<PetRaceData>> mRaces;
        private static Dictionary<int, List<string>> mTricks;
        private static object mSyncRoot;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mRaces = new Dictionary<int, List<PetRaceData>>();
            mTricks = new Dictionary<int, List<string>>();
            mSyncRoot = new object();

            ReloadData(MySqlClient);
        }

        public static void ReloadData(SqlDatabaseClient MySqlClient)
        {
            Dictionary<int, List<PetRaceData>> NewRaceData = new Dictionary<int, List<PetRaceData>>();
            Dictionary<int, List<string>> NewTrickData = new Dictionary<int, List<string>>();

            DataTable RaceTable = MySqlClient.ExecuteQueryTable("SELECT * FROM pet_races");

            foreach (DataRow Row in RaceTable.Rows)
            {
                int PetType = (int)Row["pet_type"];

                if (!NewRaceData.ContainsKey(PetType))
                {
                    NewRaceData.Add(PetType, new List<PetRaceData>());
                }

                NewRaceData[PetType].Add(new PetRaceData((int)Row["data1"], (int)Row["data2"], (int)Row["data3"]));
            }

            DataTable TrickTable = MySqlClient.ExecuteQueryTable("SELECT * FROM pet_tricks");

            foreach (DataRow Row in TrickTable.Rows)
            {
                int PetType = (int)Row["type"];

                if (!NewTrickData.ContainsKey(PetType))
                {
                    NewTrickData.Add(PetType, new List<string>());
                }

                NewTrickData[PetType].Add((string)Row["trick"]);
            }

            lock (mSyncRoot)
            {
                mRaces = NewRaceData;
                mTricks = NewTrickData;
            }
        }

        public static List<PetRaceData> GetRaceDataForType(int PetType)
        {
            lock (mSyncRoot)
            {
                if (mRaces.ContainsKey(PetType))
                {
                    return mRaces[PetType];
                }
            }

            return new List<PetRaceData>();
        }

        public static List<string> GetTricksForType(int PetType)
        {
            List<string> Tricks = new List<string>();

            lock (mSyncRoot)
            {
                if (mTricks.ContainsKey(0))
                {
                    Tricks.AddRange(mTricks[0]);
                }

                if (mTricks.ContainsKey(PetType))
                {
                    Tricks.AddRange(mTricks[PetType]);
                }
            }   

            return Tricks;
        }
    }
}
