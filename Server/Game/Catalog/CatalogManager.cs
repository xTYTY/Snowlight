using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Sessions;
using Snowlight.Storage;

using Snowlight.Game.Misc;
using Snowlight.Game.Items;
using Snowlight.Communication.ResponseCache;
using Snowlight.Game.Rights;
using Snowlight.Game.Pets;
using Snowlight.Communication.Incoming;
using Snowlight.Config;

namespace Snowlight.Game.Catalog
{
    public static class CatalogManager
    {
        private static Dictionary<int, CatalogPage> mPages;

        private static Dictionary<int, List<CatalogItem>> mCatalogItems;
        private static Dictionary<uint, CatalogItem> mCatalogItemsIdIndex;
        private static Dictionary<string, CatalogItem> mCatalogItemsNameIndex;

        private static Dictionary<uint, CatalogClubOffer> mClubOffers;

        private static ResponseCacheController mCacheController;

        public static bool CacheEnabled
        {
            get
            {
                return (mCacheController != null);
            }
        }

        public static ResponseCacheController CacheController
        {
            get
            {
                return mCacheController;
            }
        }

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mPages = new Dictionary<int, CatalogPage>();
            mCatalogItems = new Dictionary<int, List<CatalogItem>>();
            mCatalogItemsIdIndex = new Dictionary<uint, CatalogItem>();
            mCatalogItemsNameIndex = new Dictionary<string, CatalogItem>();
            mClubOffers = new Dictionary<uint, CatalogClubOffer>();

            if ((bool)ConfigManager.GetValue("cache.catalog.enabled"))
            {
                mCacheController = new ResponseCacheController((int)ConfigManager.GetValue("cache.catalog.lifetime"));
            }

            RefreshCatalogData(MySqlClient, false);

            DataRouter.RegisterHandler(OpcodesIn.CATALOG_GET_INDEX, new ProcessRequestCallback(GetCatalogIndex));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_GET_PAGE, new ProcessRequestCallback(GetCatalogPage));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_GET_CLUB_OFFERS, new ProcessRequestCallback(GetClubOffers));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_REDEEM_VOUCHER, new ProcessRequestCallback(RedeemVoucher));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_GET_PET_DATA, new ProcessRequestCallback(GetPetData));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_VERIFY_PET_NAME, new ProcessRequestCallback(CheckPetName));
        }

        private static ServerMessage TryGetResponseFromCache(uint GroupId, ClientMessage Request)
        {
            return (CacheEnabled ? mCacheController.TryGetResponse(GroupId, Request) : null);
        }

        private static void AddToCacheIfNeeded(uint GroupId, ClientMessage Request, ServerMessage Response)
        {
            if (!CacheEnabled)
            {
                return;
            }

            mCacheController.AddIfNeeded(GroupId, Request, Response);
        }

        public static void ClearCacheGroup(uint GroupId)
        {
            if (!CacheEnabled)
            {
                return;
            }

            mCacheController.ClearCacheGroup(GroupId);
        }

        public static void RefreshCatalogData(SqlDatabaseClient MySqlClient, bool NotifyUsers = true)
        {
            int CountLoaded = 0;

            lock (mPages)
            {
                mCatalogItems.Clear();
                mCatalogItemsIdIndex.Clear();
                mCatalogItemsNameIndex.Clear();
                mPages.Clear();
                mClubOffers.Clear();

                mPages.Add(-1, new CatalogPage(-1, 0, string.Empty, 0, 0, string.Empty, true, true, string.Empty, null, null, new List<CatalogItem>())); // root category

                MySqlClient.SetParameter("enabled", "1");
                DataTable ItemTable = MySqlClient.ExecuteQueryTable("SELECT * FROM catalog_items WHERE enabled = @enabled ORDER BY name ASC");

                foreach (DataRow Row in ItemTable.Rows)
                {
                    int PageId = (int)Row["page_id"];

                    if (!mCatalogItems.ContainsKey(PageId))
                    {
                        mCatalogItems[PageId] = new List<CatalogItem>();
                    }

                    CatalogItem Item = new CatalogItem((uint)Row["id"], (uint)Row["base_id"], (string)Row["name"],
                        (int)Row["cost_credits"], (int)Row["cost_pixels"], (int)Row["amount"], (string)Row["preset_flags"],
                        (int)Row["club_restriction"]);

                    if (Item.Definition == null)
                    {
                        Output.WriteLine("Warning: Catalog item " + (uint)Row["id"] + " has an invalid base_id reference.", OutputLevel.Warning);
                        continue;
                    }

                    mCatalogItems[PageId].Add(Item);
                    mCatalogItemsIdIndex[Item.Id] = Item;
                    mCatalogItemsNameIndex[Item.DisplayName] = Item;
                }

                MySqlClient.SetParameter("enabled", "1");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM catalog WHERE enabled = @enabled ORDER BY order_num ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    List<string> PageStrings1 = new List<string>();
                    List<string> PageStrings2 = new List<string>();

                    foreach (string String in Row["page_strings_1"].ToString().Split('|')) PageStrings1.Add(String);
                    foreach (string String in Row["page_strings_2"].ToString().Split('|')) PageStrings2.Add(String);

                    int Id = (int)Row["id"];

                    mPages.Add(Id, new CatalogPage((int)Row["id"], (int)Row["parent_id"], (string)Row["title"],
                        (int)Row["icon"], (int)Row["color"], (string)Row["required_right"], (Row["visible"].ToString() == "1"),
                        (Row["dummy_page"].ToString() == "1"), (string)Row["template"], PageStrings1, PageStrings2,
                        mCatalogItems.ContainsKey(Id) ? mCatalogItems[Id] : new List<CatalogItem>()));

                    CountLoaded++;
                }

                DataTable ClubTable = MySqlClient.ExecuteQueryTable("SELECT * FROM catalog_subscriptions");

                foreach (DataRow Row in ClubTable.Rows)
                {
                    CatalogClubOfferType OfferType = CatalogClubOfferType.Basic;

                    switch ((string)Row["type"])
                    {
                        case "vip":

                            OfferType = CatalogClubOfferType.Vip;
                            break;

                        case "upgrade":

                            OfferType = CatalogClubOfferType.VipUpgrade;
                            break;
                    }

                    mClubOffers.Add((uint)Row["id"], new CatalogClubOffer((uint)Row["id"], (string)Row["name"],
                        (int)Row["cost_credits"], (int)Row["length_days"], OfferType));
                }
            }

            Output.WriteLine("Loaded " + CountLoaded + " catalog page(s).", OutputLevel.DebugInformation);

            if (NotifyUsers)
            {
                SessionManager.BroadcastPacket(CatalogUpdatedNotificationComposer.Compose());
            }
        }

        public static CatalogClubOffer GetClubOffer(uint ItemId)
        {
            return mClubOffers.ContainsKey(ItemId) ? mClubOffers[ItemId] : null;
        }

        public static CatalogPage GetCatalogPage(int PageId)
        {
            lock (mPages)
            {
                if (mPages.ContainsKey(PageId))
                {
                    return mPages[PageId];
                }
            }

            return null;
        }

        public static CatalogItem GetCatalogItemByAbsoluteId(uint ItemId)
        {
            lock (mCatalogItemsIdIndex)
            {
                if (mCatalogItemsIdIndex.ContainsKey(ItemId))
                {
                    return mCatalogItemsIdIndex[ItemId];
                }
            }

            return null;
        }

        public static CatalogItem GetCatalogItemByPage(int PageId, uint ItemId)
        {
            lock (mCatalogItems)
            {
                if (mCatalogItems.ContainsKey(PageId))
                {
                    foreach (CatalogItem Item in mCatalogItems[PageId])
                    {
                        if (Item.Id == ItemId)
                        {
                            return Item;
                        }
                    }
                }
            }

            return null;
        }

        private static void GetCatalogIndex(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            lock (mPages)
            {
                Response = CatalogIndexComposer.Compose(Session, mPages);
                //Response = CatalogIndexComposer.ComposeTextIndex();
            }

            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void GetCatalogPage(Session Session, ClientMessage Message)
        {
            int Id = Message.PopWiredInt32();

            if (!mPages.ContainsKey(Id))
            {
                return;
            }

            CatalogPage Page = mPages[Id];

            if (Page.DummyPage)
            {
                return;
            }

            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            Response = CatalogPageComposer.Compose(Page);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetClubOffers(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            ClubSubscription Subscription = Session.SubscriptionManager;
            List<CatalogClubOffer> CorrectedOffers = new List<CatalogClubOffer>();

            foreach (CatalogClubOffer Offer in mClubOffers.Values)
            {
                if ((Offer.IsUpgrade && Subscription.SubscriptionLevel != ClubSubscriptionLevel.BasicClub) ||
                    (Offer.Level == ClubSubscriptionLevel.BasicClub && Subscription.SubscriptionLevel ==
                    ClubSubscriptionLevel.VipClub) || (Offer.Level == ClubSubscriptionLevel.VipClub
                    && !Offer.IsUpgrade && Subscription.SubscriptionLevel == ClubSubscriptionLevel.BasicClub))
                {
                    continue;
                }

                CorrectedOffers.Add(Offer);
            }      

            Response = CatalogClubOffersComposer.Compose(CorrectedOffers,
                Session.SubscriptionManager.IsActive ?
                Session.SubscriptionManager.TimestampExpire : UnixTimestamp.GetCurrent());
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void RedeemVoucher(Session Session, ClientMessage Message)
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.SendData(VoucherManager.TryRedeemVoucher(MySqlClient, Session, Message.PopString()) ? 
                    CatalogRedeemOkComposer.Compose() : CatalogRedeemErrorComposer.Compose(0));
            }
        }

        private static void GetPetData(Session Session, ClientMessage Message)
        {
            CatalogItem PetItem = null;
            string ItemName = Message.PopString();

            if (mCatalogItemsNameIndex.ContainsKey(ItemName))
            {
                PetItem = mCatalogItemsNameIndex[ItemName];
            }

            if (PetItem == null || PetItem.Definition.Behavior != ItemBehavior.Pet)
            {
                return;
            }

            int PetType = PetItem.Definition.BehaviorData;

            Session.SendData(CatalogPetDataComposer.Compose(PetItem, PetDataManager.GetRaceDataForType(PetType), PetType));
        }

        private static void CheckPetName(Session Session, ClientMessage Message)
        {
            Session.SendData(CatalogVerifyPetNameResultComposer.Compose((int)PetName.VerifyPetName(Message.PopString())));
        }
    }
}
