using System;
using System.Collections.Generic;

using Snowlight.Game.Catalog;
using Snowlight.Game.Rights;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogClubOffersComposer
    {
        // IqPAZHSHABBO_CLUB_VIP_1_MONTHQFHIISG[vGKQGXHSHABBO_CLUB_BASIC_1_MONTHSCHHISG[vGKQG[HSHABBO_CLUB_VIP_3_MONTHSPOHIKQW[vGQARGYHSHABBO_CLUB_BASIC_3_MONTHSQKHHKQW[vGQARG
        public static ServerMessage Compose(List<CatalogClubOffer> Offers, double BaseTimestamp)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_CLUB_OFFERS);

            Message.AppendInt32(Offers.Count);

            foreach (CatalogClubOffer Offer in Offers)
            {
                DateTime ExpireTime = UnixTimestamp.GetDateTimeFromUnixTimestamp(BaseTimestamp + Offer.LengthSeconds);

                Message.AppendUInt32(Offer.Id);
                Message.AppendStringWithBreak(Offer.DisplayName);
                Message.AppendInt32(Offer.Price); // Cost in credits
                Message.AppendBoolean(Offer.IsUpgrade); // [??] Always 0?
                Message.AppendBoolean(Offer.Level == ClubSubscriptionLevel.VipClub); // Boolean 0 for basic, 1 for vip
                Message.AppendInt32(Offer.LengthMonths); // Months of membership
                Message.AppendInt32(Offer.LengthDays); // Actual days of membership (i.e. 31 per month)
                Message.AppendInt32(ExpireTime.Year); // Expire date/year
                Message.AppendInt32(ExpireTime.Month); // Expire date/month
                Message.AppendInt32(ExpireTime.Day); // Expire date/day
            }

            return Message;
        }
    }
}
