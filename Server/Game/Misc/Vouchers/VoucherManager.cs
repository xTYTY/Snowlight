using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Items;
using Snowlight.Specialized;

namespace Snowlight.Game.Misc
{
    public static class VoucherManager
    {
        private static object mSyncRoot = new object();

        public static bool TryRedeemVoucher(SqlDatabaseClient MySqlClient, Session Session, string Code)
        {
            lock (mSyncRoot)
            {
                VoucherValueData ValueData = GetVoucherValue(Code);

                if (ValueData == null)
                {
                    return false;
                }

                if (ValueData.ValueCredits > 0)
                {
                    Session.CharacterInfo.UpdateCreditsBalance(MySqlClient, ValueData.ValueCredits);
                    Session.SendData(CreditsBalanceComposer.Compose(Session.CharacterInfo.CreditsBalance));
                }

                if (ValueData.ValuePixels > 0)
                {
                    Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, ValueData.ValuePixels);
                    Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance, ValueData.ValuePixels));
                }

                if (ValueData.ValueFurni.Count > 0)
                {
                    Dictionary<int, List<uint>> NotifyItems = new Dictionary<int, List<uint>>();

                    foreach (uint ItemId in ValueData.ValueFurni)
                    {
                        Item Item = ItemFactory.CreateItem(MySqlClient, ItemId, Session.CharacterId, string.Empty,
                            string.Empty, 0, false);

                        if (Item != null)
                        {
                            int NotifyTabId = Item.Definition.Type == ItemType.WallItem ? 2 : 1;

                            Session.InventoryCache.Add(Item);
                            Session.NewItemsCache.MarkNewItem(MySqlClient, NotifyTabId, Item.Id);

                            if (!NotifyItems.ContainsKey(NotifyTabId))
                            {
                                NotifyItems.Add(NotifyTabId, new List<uint>());
                            }

                            NotifyItems[NotifyTabId].Add(Item.Id);
                        }
                    }                   

                    if (NotifyItems.Count > 0)
                    {
                        Session.SendData(InventoryRefreshComposer.Compose());
                        Session.SendData(InventoryNewItemsComposer.Compose(new Dictionary<int, List<uint>>(NotifyItems)));
                    }
                }

                MarkVoucherUsed(Code);
                return true;
            }
        }

        public static VoucherValueData GetVoucherValue(string Code)
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("code", Code);
                DataRow Row = MySqlClient.ExecuteQueryRow("SELECT value_credits,value_pixels,value_furni FROM vouchers WHERE code = @code AND enabled = '1' AND uses > 0 LIMIT 1");

                if (Row == null)
                {
                    return null;
                }

                List<uint> FurniValue = new List<uint>();

                foreach (string FurniValueBit in Row["value_furni"].ToString().Split(','))
                {
                    uint NewValue = 0;
                    uint.TryParse(FurniValueBit, out NewValue);

                    if (NewValue > 0)
                    {
                        FurniValue.Add(NewValue);
                    }
                }

                return new VoucherValueData((int)Row["value_credits"], (int)Row["value_pixels"], FurniValue);
            }
        }

        public static void MarkVoucherUsed(string Code)
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("code", Code);
                MySqlClient.ExecuteNonQuery("UPDATE vouchers SET uses = uses - 1 WHERE code = @code LIMIT 1; DELETE FROM vouchers WHERE uses < 1;");
            }
        }
    }
}
