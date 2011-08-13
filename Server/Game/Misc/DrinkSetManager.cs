using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;

namespace Snowlight.Game.Misc
{
    public static class DrinkSetManager
    {
        private static Dictionary<int, DrinkSet> mSets;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mSets = new Dictionary<int, DrinkSet>();

            DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM drink_sets");

            foreach (DataRow Row in Table.Rows)
            {
                int Id = (int)Row["id"];
                string[] DrinkData = Row["drinks"].ToString().Split(',');

                List<int> Drinks = new List<int>();

                foreach (string Drink in DrinkData)
                {
                    int i = 0;
                    int.TryParse(Drink, out i);

                    if (i > 0)
                    {
                        Drinks.Add(i);
                    }
                }

                if (Drinks.Count > 0)
                {
                    mSets.Add(Id, new DrinkSet(Id, Drinks));
                }
            }
        }

        public static int GetRandomDrinkForSet(int Set)
        {
            return (mSets.ContainsKey(Set) ? mSets[Set].GetRandomDrink() : 1);
        }
    }
}
