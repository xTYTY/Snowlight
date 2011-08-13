using System;
using System.Linq;
using System.Data;
using System.Collections.Generic;

using Snowlight.Storage;

namespace Snowlight.Game.Advertisements
{
    public static class InterstitialManager
    {
        private static Dictionary<uint, Interstitial> mInterstitials;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mInterstitials = new Dictionary<uint, Interstitial>();

            ReloadInterstitials(MySqlClient);
        }

        public static void ReloadInterstitials(SqlDatabaseClient MySqlClient)
        {
            lock (mInterstitials)
            {
                mInterstitials.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM interstitials WHERE enabled = '1'");

                foreach (DataRow Row in Table.Rows)
                {
                    mInterstitials.Add((uint)Row["id"], new Interstitial((uint)Row["id"], (string)Row["url"],
                        (string)Row["image"]));
                }
            }
        }

        public static Interstitial GetRandomInterstitial(bool IncrecementViews)
        {
            if (mInterstitials.Count == 0)
            {
                return null;
            }

            Interstitial Interstitial = mInterstitials.ElementAt(new Random().Next(0, mInterstitials.Count)).Value;

            if (IncrecementViews)
            {
                Interstitial.IncrecementViews();
            }

            return Interstitial;
        }
    }
}
