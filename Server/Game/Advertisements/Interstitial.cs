using System;
using Snowlight.Storage;

namespace Snowlight.Game.Advertisements
{
    /*public enum AdvertisementType
    {
        Interstitial = 0,
        InnerAdvertisement = 1
    }*/

    public class Interstitial
    {
        private uint mId;
        private string mUrl;
        private string mImage;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Url
        {
            get
            {
                return mUrl;
            }
        }

        public string Image
        {
            get
            {
                return mImage;
            }
        }

        public Interstitial(uint Id, string Url, string Image)
        {
            mId = Id;
            mUrl = Url;
            mImage = Image;
        }

        public void IncrecementViews()
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("id", mId);
                MySqlClient.ExecuteNonQuery("UPDATE interstitials SET views = views + 1 WHERE id = @id LIMIT 1");
            }
        }
    }
}
