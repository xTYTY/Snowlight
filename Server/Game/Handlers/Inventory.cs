using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Characters;
using Snowlight.Game.Rooms;
using Snowlight.Util;
using Snowlight.Specialized;
using Snowlight.Game.Rights;
using Snowlight.Game.AvatarEffects;
using Snowlight.Game.Achievements;
using Snowlight.Storage;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Handlers
{
    public static class Inventory
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.USER_INVENTORY_OBJECTS, new ProcessRequestCallback(GetObjectInventory));
            DataRouter.RegisterHandler(OpcodesIn.USER_INVENTORY_PETS, new ProcessRequestCallback(GetPetInventory));
            DataRouter.RegisterHandler(OpcodesIn.USER_INVENTORY_BADGES, new ProcessRequestCallback(GetBadgeInventory));

            DataRouter.RegisterHandler(OpcodesIn.USER_SET_BADGES, new ProcessRequestCallback(SetBadgeOrder));
            DataRouter.RegisterHandler(OpcodesIn.USER_CHANGE_LOOK, new ProcessRequestCallback(SetFigure));
            DataRouter.RegisterHandler(OpcodesIn.USER_CHANGE_MOTTO, new ProcessRequestCallback(SetMotto));

            DataRouter.RegisterHandler(OpcodesIn.USER_WARDROBE_GET, new ProcessRequestCallback(GetWardrobe));
            DataRouter.RegisterHandler(OpcodesIn.USER_WARDROBE_SAVE, new ProcessRequestCallback(SetWardrobe));

            DataRouter.RegisterHandler(OpcodesIn.USER_INVENTORY_MARK_TAB_READ, new ProcessRequestCallback(MarkTabRead));

            DataRouter.RegisterHandler(OpcodesIn.USER_EFFECT_APPLY, new ProcessRequestCallback(ApplyEffect));
            DataRouter.RegisterHandler(OpcodesIn.USER_EFFECT_ACTIVATE, new ProcessRequestCallback(ActivateEffect));
        }

        private static void GetObjectInventory(Session Session, ClientMessage Message)
        {
            Session.SendData(InventoryComposer.Compose("S", Session.InventoryCache.GetFloorItems().Values.ToList()));
            Session.SendData(InventoryComposer.Compose("I", Session.InventoryCache.GetWallItems().Values.ToList()));
        }

        private static void GetPetInventory(Session Session, ClientMessage Message)
        {
            Session.SendData(PetInventoryComposer.Compose(Session.PetInventoryCache.Pets));
        }

        private static void GetBadgeInventory(Session Session, ClientMessage Message)
        {
            Session.SendData(UserBadgeInventoryComposer.Compose(Session.BadgeCache.Badges, Session.BadgeCache.EquippedBadges));
        }

        private static void SetBadgeOrder(Session Session, ClientMessage Message)
        {
            int i = 0;
            Dictionary<int, Badge> NewSettings = new Dictionary<int, Badge>();

            while (Message.RemainingLength > 0)
            {
                if (i > 5)
                {
                    continue;
                }

                int SlotId = Message.PopWiredInt32();
                string BadgeCode = Message.PopString();
                Badge BadgeRef = RightsManager.GetBadgeByCode(BadgeCode);

                if (BadgeRef == null || !Session.BadgeCache.ContainsCode(BadgeCode) || SlotId >= 6 ||
                    SlotId <= 0 || NewSettings.ContainsKey(SlotId))
                {
                    continue;
                }

                NewSettings.Add(SlotId, BadgeRef);

                i++;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.BadgeCache.UpdateBadgeOrder(MySqlClient, NewSettings);
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Instance.BroadcastMessage(RoomUserBadgesComposer.Compose(Session.CharacterId, Session.BadgeCache.EquippedBadges));
            QuestManager.ProgressUserQuest(Session, QuestType.PROFILE_BADGE);
        }

        private static void SetFigure(Session Session, ClientMessage Message)
        {
            // todo: verify data(!!!!)

            string NewGender = Message.PopString().ToLower();
            string NewFigure = UserInputFilter.FilterString(Message.PopString());

            if (NewGender != "m" && NewGender != "f")
            {
                NewGender = "m";
            }

            if (NewFigure.Length == 0 || (NewFigure == Session.CharacterInfo.Figure))
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.CharacterInfo.UpdateFigure(MySqlClient, NewGender, NewFigure);
                AchievementManager.ProgressUserAchievement(MySqlClient, Session, "ACH_AvatarLooks", 1);
            }

            QuestManager.ProgressUserQuest(Session, QuestType.PROFILE_CHANGE_LOOK);

            Session.SendInfoUpdate();
        }

        private static void SetMotto(Session Session, ClientMessage Message)
        {
            string NewMotto = UserInputFilter.FilterString(Message.PopString().Trim());

            if (NewMotto.Length > 38)
            {
                NewMotto = NewMotto.Substring(0, 38);
            }

            if (NewMotto == Session.CharacterInfo.Motto)
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.CharacterInfo.UpdateMotto(MySqlClient, NewMotto);
                AchievementManager.ProgressUserAchievement(MySqlClient, Session, "ACH_Motto", 1);
            }

            QuestManager.ProgressUserQuest(Session, QuestType.PROFILE_CHANGE_MOTTO);

            Session.SendInfoUpdate();
        }

        public static int GetWardrobeSlotAmountForSession(Session Session)
        {
            int WardrobeSlots = 0;

            if (Session.HasRight("club_regular"))
            {
                WardrobeSlots += 5;
            }

            if (Session.HasRight("club_vip"))
            {
                WardrobeSlots += 5;
            }

            return WardrobeSlots;
        }

        private static void GetWardrobe(Session Session, ClientMessage Message)
        {
            int SlotAmount = GetWardrobeSlotAmountForSession(Session);

            if (SlotAmount == 0)
            {
                return;
            }

            Dictionary<int, WardrobeItem> ValidItems = new Dictionary<int, WardrobeItem>();

            foreach (KeyValuePair<int, WardrobeItem> Item in Session.CharacterInfo.Wardrobe)
            {
                if (Item.Key > SlotAmount)
                {
                    continue;
                }

                ValidItems.Add(Item.Key, Item.Value);
            }

            Session.SendData(UserWardrobeComposer.Compose(new Dictionary<int, WardrobeItem>(ValidItems)));
        }

        private static void SetWardrobe(Session Session, ClientMessage Message)
        {
            int SlotAmount = GetWardrobeSlotAmountForSession(Session);
            int SlotId = Message.PopWiredInt32();
            string Figure = Message.PopString();
            CharacterGender Gender = (Message.PopString() == "M" ? CharacterGender.Male : CharacterGender.Female);

            if (SlotId <= 0 || SlotId > SlotAmount)
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.CharacterInfo.SetWardrobeSlot(MySqlClient, SlotId, Figure, Gender);
            }
        }

        private static void MarkTabRead(Session Session, ClientMessage Message)
        {
            Session.NewItemsCache.MarkTabRead(Message.PopWiredInt32());
        }

        private static void ApplyEffect(Session Session, ClientMessage Message)
        {
            int EffectSpriteId = Message.PopWiredInt32();

            if (EffectSpriteId < 0)
            {
                EffectSpriteId = 0;
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

            if (Actor == null || (EffectSpriteId != 0 && !Session.AvatarEffectCache.HasEffect(EffectSpriteId, true)))
            {
                return;
            }

            Actor.ApplyEffect(EffectSpriteId);
            Session.CurrentEffect = EffectSpriteId;
        }

        private static void ActivateEffect(Session Session, ClientMessage Message)
        {
            AvatarEffect Effect = Session.AvatarEffectCache.GetEffect(Message.PopWiredInt32(), false, true);

            // If we do not have an effect that needs activating OR if we already have an effect
            // of this sort which IS activated, stop.
            if (Effect == null || Session.AvatarEffectCache.HasEffect(Effect.SpriteId, true))
            {
                return;
            }

            Effect.Activate();
            Session.SendData(UserEffectActivatedComposer.Compose(Effect));
        }
    }
}
