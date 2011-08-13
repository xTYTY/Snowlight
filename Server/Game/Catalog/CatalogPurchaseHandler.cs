using System;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Items;
using System.Collections.Generic;
using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Game.AvatarEffects;
using Snowlight.Util;
using Snowlight.Game.Achievements;
using Snowlight.Game.Rights;
using Snowlight.Game.Pets;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Catalog
{
    public static class CatalogPurchaseHandler
    {
        private static object mPurchaseSyncRoot;

        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_CAN_GIFT, new ProcessRequestCallback(CheckCanGift));
            DataRouter.RegisterHandler(OpcodesIn.CATALOG_PURCHASE, new ProcessRequestCallback(OnPurchase));

            mPurchaseSyncRoot = new object();
        }

        #region Purchase handling and delivering
        public static void HandlePurchase(SqlDatabaseClient MySqlClient, Session Session, CatalogItem Item, string ItemFlags)
        {
            lock (mPurchaseSyncRoot)
            {
                int TotalCreditCost = Item.CostCredits;
                int TotalApCost = Item.CostActivityPoints;

                if (Session.CharacterInfo.CreditsBalance < TotalCreditCost || Session.CharacterInfo.ActivityPointsBalance
                    < TotalApCost)
                {
                    return;
                }

                string[] PetData = null;

                if (Item.PresetFlags.Length > 0)
                {
                    ItemFlags = Item.PresetFlags;
                }
                else
                {
                    switch (Item.Definition.Behavior)
                    {
                        case ItemBehavior.Pet:

                            PetData = ItemFlags.Split('\n');

                            if (PetData.Length != 3)
                            {
                                return;
                            }

                            string Name = PetData[0];
                            string Color = PetData[2];
                            
                            int Race = 0;
                            int.TryParse(PetData[1], out Race);

                            bool RaceOk = false;

                            List<PetRaceData> Races = PetDataManager.GetRaceDataForType(Item.Definition.BehaviorData);

                            foreach (PetRaceData RaceData in Races)
                            {
                                if (RaceData.Data1 == Race)
                                {
                                    RaceOk = true;
                                    break;
                                }
                            }

                            if (PetName.VerifyPetName(Name) != PetNameError.NameOk || Color.ToLower() != "ffffff" || !RaceOk)
                            {
                                return;
                            }

                            break;

                        case ItemBehavior.PrizeTrophy:

                            if (ItemFlags.Length > 255)
                            {
                                ItemFlags = ItemFlags.Substring(0, 255);
                            }

                            ItemFlags = Session.CharacterInfo.Username + Convert.ToChar(9) + DateTime.Now.Day + "-" +
                                DateTime.Now.Month + "-" + DateTime.Now.Year + Convert.ToChar(9) +
                                UserInputFilter.FilterString(ItemFlags.Trim(), true);
                            break;

                        default:

                            ItemFlags = string.Empty;
                            break;
                    }
                }

                if (TotalCreditCost > 0)
                {
                    Session.CharacterInfo.UpdateCreditsBalance(MySqlClient, -TotalCreditCost);
                    Session.SendData(CreditsBalanceComposer.Compose(Session.CharacterInfo.CreditsBalance));
                }

                if (TotalApCost > 0)
                {
                    Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, -TotalApCost);
                    Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance, -TotalApCost));
                }

                Dictionary<int, List<uint>> NewItems = new Dictionary<int, List<uint>>();

                for (int i = 0; i < Item.Amount; i++)
                {
                    switch (Item.Definition.Type)
                    {
                        default:

                            List<Item> GeneratedGenericItems = new List<Item>();
                            double ExpireTimestamp = 0;

                            if (Item.Definition.Behavior == ItemBehavior.Rental)
                            {
                                ExpireTimestamp = UnixTimestamp.GetCurrent() + 3600;
                            }

                            GeneratedGenericItems.Add(ItemFactory.CreateItem(MySqlClient, Item.DefinitionId,
                                Session.CharacterId, ItemFlags, ItemFlags, ExpireTimestamp));

                            switch (Item.Definition.Behavior)
                            {
                                case ItemBehavior.Teleporter:

                                    Item LinkedItem = ItemFactory.CreateItem(MySqlClient, Item.DefinitionId,
                                        Session.CharacterId, GeneratedGenericItems[0].Id.ToString(), string.Empty,
                                        ExpireTimestamp);

                                    GeneratedGenericItems[0].Flags = LinkedItem.Id.ToString();
                                    GeneratedGenericItems[0].SynchronizeDatabase(MySqlClient, true);

                                    GeneratedGenericItems.Add(LinkedItem);
                                    break;
                            }

                            foreach (Item GeneratedItem in GeneratedGenericItems)
                            {
                                Session.InventoryCache.Add(GeneratedItem);

                                int TabId = GeneratedItem.Definition.Type == ItemType.FloorItem ? 1 : 2;

                                if (!NewItems.ContainsKey(TabId))
                                {
                                    NewItems.Add(TabId, new List<uint>());
                                }

                                NewItems[TabId].Add(GeneratedItem.Id);
                            }

                            break;

                        case ItemType.AvatarEffect:

                            AvatarEffect Effect = null;

                            if (Session.AvatarEffectCache.HasEffect((int)Item.Definition.SpriteId))
                            {
                                Effect = Session.AvatarEffectCache.GetEffect((int)Item.Definition.SpriteId);

                                if (Effect != null)
                                {
                                    Effect.AddToQuantity();
                                }
                            }
                            else
                            {
                                Effect = AvatarEffectFactory.CreateEffect(MySqlClient, Session.CharacterId, (int)Item.Definition.SpriteId, 3600);
                                Session.AvatarEffectCache.Add(Effect);
                            }

                            if (Effect != null)
                            {
                                Session.SendData(UserEffectAddedComposer.Compose(Effect));
                            }

                            break;

                        case ItemType.Pet:

                            Pet Pet = PetFactory.CreatePet(MySqlClient, Session.CharacterId, Item.Definition.BehaviorData, PetData[0], int.Parse(PetData[1]));
                            Session.PetInventoryCache.Add(Pet);

                            Session.SendData(InventoryPetAddedComposer.Compose(Pet));

                            if (!NewItems.ContainsKey(3))
                            {
                                NewItems.Add(3, new List<uint>());
                            }

                            NewItems[3].Add(Pet.Id);

                            break;
                    }                   
                }

                Session.SendData(CatalogPurchaseResultComposer.Compose(Item));
                Session.SendData(InventoryRefreshComposer.Compose());

                foreach (KeyValuePair<int, List<uint>> NewItemData in NewItems)
                {
                    foreach (uint NewItem in NewItemData.Value)
                    {
                        Session.NewItemsCache.MarkNewItem(MySqlClient, NewItemData.Key, NewItem);
                    }
                }

                if (NewItems.Count > 0)
                {
                    Session.SendData(InventoryNewItemsComposer.Compose(new Dictionary<int, List<uint>>(NewItems)));
                }
            }
        }
        #endregion

        #region Request processors
        private static void CheckCanGift(Session Session, ClientMessage Message)
        {
            uint ItemId = Message.PopWiredUInt32();

            CatalogItem Item = CatalogManager.GetCatalogItemByAbsoluteId(ItemId);

            if (Item == null)
            {
                return;
            }

            Session.SendData(CatalogCanGiftComposer.Compose(Item.Id, Item.Definition.AllowGift));
        }

        private static void OnPurchase(Session Session, ClientMessage Message)
        {
            int PageId = Message.PopWiredInt32();
            uint ItemId = Message.PopWiredUInt32();
            string Data = Message.PopString();

            CatalogPage Page = CatalogManager.GetCatalogPage(PageId);

            if (Page == null || Page.DummyPage || !Page.Visible || (Page.RequiredRight.Length > 0 && 
                !Session.HasRight(Page.RequiredRight)))
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                switch (Page.Template)
                {
                    default:

                        CatalogItem Item = Page.GetItem(ItemId);

                        if (Item == null || (Item.ClubRestriction == 1 && !Session.HasRight("club_regular")) || 
                            (Item.ClubRestriction == 2 && !Session.HasRight("club_vip")))
                        {
                            return;
                        }

                        HandlePurchase(MySqlClient, Session, Item, Data);
                        break;

                    case "club_buy":

                        CatalogClubOffer Offer = CatalogManager.GetClubOffer(ItemId);

                        if (Offer == null || (Offer.Price > 0 && Session.CharacterInfo.CreditsBalance < Offer.Price)
                            || (int)Offer.Level < (int)Session.SubscriptionManager.SubscriptionLevel)
                        {
                            return; 
                        }

                        string BasicAchievement = "ACH_BasicClub";
                        string VipAchievement = "ACH_VipClub";

                        // Extend membership and take credits
                        Session.CharacterInfo.UpdateCreditsBalance(MySqlClient, -Offer.Price);
                        Session.SubscriptionManager.AddOrExtend((int)Offer.Level, Offer.LengthSeconds);

                        // Check if we need to manually award basic/vip badges
                        bool NeedsBasicUnlock = !Session.BadgeCache.ContainsCodeWith(BasicAchievement);
                        bool NeedsVipUnlock = !Session.BadgeCache.ContainsCodeWith(VipAchievement);

                        // Reload the badge cache (reactivating any disabled subscription badges)
                        Session.BadgeCache.ReloadCache(MySqlClient, Session.AchievementCache);

                        // Calculate progress
                        int Progress = (int)Math.Ceiling((double)(Offer.LengthDays / 31));

                        if (Progress <= 0)
                        {
                            Progress = 1;
                        }

                        // Progress VIP achievement
                        if (Offer.Level >= ClubSubscriptionLevel.VipClub)
                        {
                            NeedsVipUnlock = !AchievementManager.ProgressUserAchievement(MySqlClient,
                                Session, VipAchievement, Progress) && NeedsVipUnlock;
                        }
                        else
                        {
                            NeedsVipUnlock = false;
                        }

                        // Progress basic achievement
                        NeedsBasicUnlock = !AchievementManager.ProgressUserAchievement(MySqlClient,
                            Session, BasicAchievement, Progress) && NeedsBasicUnlock; 

                        // Virtually unlock the basic achievement without reward if needed
                        if (NeedsBasicUnlock)
                        {
                            Achievement Achievement = AchievementManager.GetAchievement(BasicAchievement);

                            if (Achievement != null)
                            {
                                UserAchievement UserAchievement = Session.AchievementCache.GetAchievementData(
                                    BasicAchievement);

                                if (UserAchievement != null)
                                {
                                    Session.SendData(AchievementUnlockedComposer.Compose(Achievement, UserAchievement.Level,
                                        0, 0));
                                }
                            }
                        }

                        // Virtually unlock the VIP achievement without reward if needed
                        if (NeedsVipUnlock)
                        {
                            Achievement Achievement = AchievementManager.GetAchievement(VipAchievement);

                            if (Achievement != null)
                            {
                                UserAchievement UserAchievement = Session.AchievementCache.GetAchievementData(
                                    VipAchievement);

                                if (UserAchievement != null)
                                {
                                    Session.SendData(AchievementUnlockedComposer.Compose(Achievement, UserAchievement.Level,
                                        0, 0));
                                }
                            }
                        }

                        // Disable any VIP badges if they still aren't valid
                        if (Session.SubscriptionManager.SubscriptionLevel < ClubSubscriptionLevel.VipClub)
                        {
                            Session.BadgeCache.DisableSubscriptionBadge(VipAchievement);
                        }

                        // Synchronize equipped badges if the user has unlocked anything
                        if (NeedsVipUnlock || NeedsBasicUnlock)
                        {
                            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

                            if (Instance != null)
                            {
                                Instance.BroadcastMessage(RoomUserBadgesComposer.Compose(Session.CharacterId,
                                    Session.BadgeCache.EquippedBadges));
                            }
                        }

                        // Clear catalog cache for user (in case of changes)
                        CatalogManager.ClearCacheGroup(Session.CharacterId);

                        // Send new data to client
                        Session.SendData(CatalogPurchaseResultComposer.Compose(Offer));
                        Session.SendData(CreditsBalanceComposer.Compose(Session.CharacterInfo.CreditsBalance));
                        Session.SendData(FuseRightsListComposer.Compose(Session));
                        Session.SendData(SubscriptionStatusComposer.Compose(Session.SubscriptionManager, true));
                        //Session.SendData(ClubGiftReadyComposer.Compose(1));
                        break;
                }
            }
        }
        #endregion
    }
}
