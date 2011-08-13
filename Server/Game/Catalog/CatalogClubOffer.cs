using System;

using Snowlight.Game.Rights;

namespace Snowlight.Game.Catalog
{
    public enum CatalogClubOfferType
    {
        Basic = 0,
        Vip = 1,
        VipUpgrade = 2
    }

    public class CatalogClubOffer
    {
        private uint mId;
        private string mName;
        private int mPrice;
        private int mLength;
        private CatalogClubOfferType mType;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string DisplayName
        {
            get
            {
                return mName;
            }
        }

        public int Price
        {
            get
            {
                return mPrice;
            }
        }

        public int LengthDays
        {
            get
            {
                return mLength;
            }
        }

        public double LengthSeconds
        {
            get
            {
                return 86400 * mLength;
            }
        }

        public int LengthMonths
        {
            get
            {
                int CorrectedLength = mLength;

                if (IsUpgrade)
                {
                    CorrectedLength += 31;
                }

                return (int)(Math.Ceiling(((double)(CorrectedLength / 31))));
            }
        }

        public ClubSubscriptionLevel Level
        {
            get
            {
                return (mType == CatalogClubOfferType.Basic ? ClubSubscriptionLevel.BasicClub :
                    ClubSubscriptionLevel.VipClub);
            }
        }

        public bool IsUpgrade
        {
            get
            {
                return mType == CatalogClubOfferType.VipUpgrade;
            }
        }

        public CatalogClubOffer(uint Id, string Name, int Price, int LengthDays, CatalogClubOfferType Type)
        {
            mId = Id;
            mName = Name;
            mPrice = Price;
            mLength = LengthDays;
            mType = Type;
        }
    }
}
