using System;
using Snowlight.Game.Rights;

namespace Snowlight.Communication.Outgoing
{
    public static class SubscriptionStatusComposer
    {
        public static ServerMessage Compose(ClubSubscription SubscriptionManager, bool BoughtFromCatalog = false)
        {
            TimeSpan TimeSpan = SubscriptionManager.ExpireDateTime - DateTime.Now;
            int DisplayMonths = 0;
            int DisplayDays = 0;

            if (TimeSpan.TotalSeconds > 0)
            {
                DisplayMonths = (int)Math.Floor((double)(TimeSpan.Days / 31.0));
                DisplayDays = TimeSpan.Days - (31 * DisplayMonths);
            }

            // @Gclub_habboSGRBHJIH[MAHHHH

            ServerMessage Message = new ServerMessage(OpcodesOut.SUBSCRIPTION_STATUS);
            Message.AppendStringWithBreak("habbo_club");
            Message.AppendInt32(DisplayDays); // days left in the current month
            Message.AppendBoolean(SubscriptionManager.IsActive); // 1 if not expired
            Message.AppendInt32(DisplayMonths); // months left after the current month
            Message.AppendInt32(BoughtFromCatalog ? 2 : 1); // was true even w/o subscription
            Message.AppendInt32(1); // Unknown (Gift points?)
            Message.AppendBoolean(SubscriptionManager.IsActive && SubscriptionManager.SubscriptionLevel == ClubSubscriptionLevel.VipClub); // Is VIP (boolean)
            Message.AppendInt32((int)(SubscriptionManager.PastHcTime / 86400)); // Past HC Days
            Message.AppendInt32((int)(SubscriptionManager.PastVipTime / 86400)); // Past VIP Days
            Message.AppendInt32(0); // Discount message enable (boolean)
            Message.AppendInt32(30); // Discount message => "Regular price"
            Message.AppendInt32(25); // Discount message => "Your price"
            return Message;
        }
    }
}
