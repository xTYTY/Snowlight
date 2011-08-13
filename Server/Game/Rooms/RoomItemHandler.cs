using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;

using Snowlight.Communication;
using Snowlight.Game.Sessions;
using Snowlight.Game.Items;
using Snowlight.Specialized;
using Snowlight.Communication.Outgoing;
using Snowlight.Storage;
using Snowlight.Util;
using Snowlight.Game.Misc;
using Snowlight.Game.Pets;
using Snowlight.Game.Bots;
using Snowlight.Game.Achievements;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Rooms
{
    public static class RoomItemHandler
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.ROOM_ITEM_PLACE, new ProcessRequestCallback(PlaceItem));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_ITEM_PLACE_STICKY, new ProcessRequestCallback(PlaceItem));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_ITEM_TAKE, new ProcessRequestCallback(TakeItem));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_MOVE_FLOOR_ITEM, new ProcessRequestCallback(MoveFloorItem));
            DataRouter.RegisterHandler(OpcodesIn.ROOM_MOVE_WALL_ITEM, new ProcessRequestCallback(MoveWallItem));

            DataRouter.RegisterHandler(OpcodesIn.OPEN_STICKY, new ProcessRequestCallback(OpenSticky));
            DataRouter.RegisterHandler(OpcodesIn.SAVE_STICKY, new ProcessRequestCallback(SaveSticky));
            DataRouter.RegisterHandler(OpcodesIn.DELETE_STICKY, new ProcessRequestCallback(DeleteSticky));

            DataRouter.RegisterHandler(OpcodesIn.MOODLIGHT_INFO, new ProcessRequestCallback(GetMoodlightInfo));
            DataRouter.RegisterHandler(OpcodesIn.MOODLIGHT_SWITCH, new ProcessRequestCallback(SwitchMoodlight));
            DataRouter.RegisterHandler(OpcodesIn.MOODLIGHT_UPDATE, new ProcessRequestCallback(UpdateMoodlight));

            DataRouter.RegisterHandler(OpcodesIn.PLACE_PET, new ProcessRequestCallback(PlacePet));
            DataRouter.RegisterHandler(OpcodesIn.PETS_GET_INFO, new ProcessRequestCallback(GetPetInfo));
            DataRouter.RegisterHandler(OpcodesIn.PET_TAKE, new ProcessRequestCallback(TakePet));
            DataRouter.RegisterHandler(OpcodesIn.PET_RESPECT, new ProcessRequestCallback(RespectPet));
        }

        private static void PlaceItem(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            uint ItemId = 0;
            string[] Data = null;

            if (Message.Id == OpcodesIn.ROOM_ITEM_PLACE_STICKY)
            {
                ItemId = Message.PopWiredUInt32();

                string RawData = Message.PopString();
                string[] TmpData = RawData.Split(' ');

                Data = new string[TmpData.Length + 1];
                Data[0] = string.Empty;
                Data[1] = TmpData[0];
                Data[2] = TmpData[1];
                Data[3] = TmpData[2];
            }
            else
            {
                string RawData = Message.PopString();
                Data = RawData.Split(' ');

                uint.TryParse(Data[0], out ItemId);
            }

            Item Item = Session.InventoryCache.GetItem(ItemId);

            if (Item == null)
            {
                return;
            }

            bool HasPlacementRights = Instance.CheckUserRights(Session);
            bool IsPlacingGuestStickie = false;

            if (Item.Definition.Behavior == ItemBehavior.StickyNote && !HasPlacementRights &&
                Instance.GuestsCanPlaceStickies)
            {
                IsPlacingGuestStickie = true;
            }
            else if (!HasPlacementRights)
            {
                Session.SendData(RoomItemPlacementErrorComposer.Compose(RoomItemPlacementErrorCode.InsufficientRights));
                return;
            }

            if (Item.PendingExpiration && Item.ExpireTimeLeft <= 0)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    Item.RemovePermanently(MySqlClient);
                }

                Session.InventoryCache.RemoveItem(Item.Id);
                Session.SendData(InventoryItemRemovedComposer.Compose(Item.Id));
                return;
            }

            switch (Item.Definition.Type)
            {
                default:
                case ItemType.FloorItem:

                    if (Data.Length != 4)
                    {
                        return;
                    }

                    int X = 0;
                    int Y = 0;
                    int Rotation = 0;

                    int.TryParse(Data[1], out X);
                    int.TryParse(Data[2], out Y);
                    int.TryParse(Data[3], out Rotation);

                    Vector3 FinalizedPosition = Instance.SetFloorItem(Session, Item, new Vector2(X, Y), Rotation);

                    if (FinalizedPosition != null)
                    {
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            Item.MoveToRoom(MySqlClient, Instance.RoomId, FinalizedPosition, Rotation);                        
                        }

                        Instance.RegenerateRelativeHeightmap();

                        Session.InventoryCache.RemoveItem(Item.Id);
                        Session.SendData(InventoryItemRemovedComposer.Compose(Item.Id));

                        ItemEventDispatcher.InvokeItemEventHandler(Session, Item, Instance, ItemEventType.Placed);

                        Instance.BroadcastMessage(RoomFloorItemPlacedComposer.Compose(Item));

                        QuestManager.ProgressUserQuest(Session, QuestType.FURNI_PLACE);

                        if (FinalizedPosition.Z > Instance.Model.Heightmap.FloorHeight[FinalizedPosition.X, FinalizedPosition.Y])
                        {
                            QuestManager.ProgressUserQuest(Session, QuestType.FURNI_STACK);
                        }
                    }
                    
                    break;

                case ItemType.WallItem:

                    string[] CorrectedData = new string[Data.Length - 1];

                    for (int i = 1; i < Data.Length; i++)
                    {
                        CorrectedData[i - 1] = Data[i];
                    }

                    string WallPos = Instance.SetWallItem(Session, CorrectedData, Item);

                    if (WallPos.Length > 0)
                    {
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            Item.MoveToRoom(MySqlClient, Instance.RoomId, new Vector3(0, 0, 0), 0, WallPos);
                        }

                        Session.InventoryCache.RemoveItem(Item.Id);
                        Session.SendData(InventoryItemRemovedComposer.Compose(Item.Id));

                        ItemEventDispatcher.InvokeItemEventHandler(Session, Item, Instance, ItemEventType.Placed);

                        Instance.BroadcastMessage(RoomWallItemPlacedComposer.Compose(Item));

                        if (IsPlacingGuestStickie)
                        {
                            Instance.GiveTemporaryStickieRights(Item.Id, Session.CharacterId);
                            Session.SendData(StickyDataComposer.Compose(Item));
                        }
                    }

                    break;
            }
        }

        private static void TakeItem(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            int Unknown1 = Message.PopWiredInt32();
            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Behavior == ItemBehavior.StickyNote)
            {
                return;
            }
            
            if (Instance.TakeItem(Item.Id))
            {
                ItemEventDispatcher.InvokeItemEventHandler(Session, Item, Instance, ItemEventType.Removing);

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    Item.MoveToUserInventory(MySqlClient, Session.CharacterId);
                }

                Instance.RegenerateRelativeHeightmap();

                Session.InventoryCache.Add(Item);
                Session.SendData(InventoryItemAddedComposer.Compose(Item));

                QuestManager.ProgressUserQuest(Session, QuestType.FURNI_PICK);
            }
        }

        private static void MoveFloorItem(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session))
            {
                return;
            }

            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Type != ItemType.FloorItem)
            {
                return;
            }

            Vector2 NewPosition = new Vector2(Message.PopWiredInt32(), Message.PopWiredInt32());
            int NewRotation = Message.PopWiredInt32();

            bool IsRotationOnly = (Item.RoomId == Instance.RoomId && Item.RoomPosition.X == NewPosition.X &&
                    Item.RoomPosition.Y == NewPosition.Y && NewRotation != Item.RoomRotation);

            Vector3 FinalizedPosition = Instance.SetFloorItem(Session, Item, NewPosition, NewRotation);

            if (FinalizedPosition != null)
            {
                Item.MoveToRoom(null, Instance.RoomId, FinalizedPosition, NewRotation, string.Empty);
                RoomManager.MarkWriteback(Item, false);         

                Instance.RegenerateRelativeHeightmap();
                Instance.BroadcastMessage(RoomItemUpdatedComposer.Compose(Item));

                ItemEventDispatcher.InvokeItemEventHandler(Session, Item, Instance, ItemEventType.Moved,
                    IsRotationOnly ? 1 : 0);

                QuestManager.ProgressUserQuest(Session, IsRotationOnly ? QuestType.FURNI_ROTATE : QuestType.FURNI_MOVE);

                if (FinalizedPosition.Z > Instance.Model.Heightmap.FloorHeight[FinalizedPosition.X, FinalizedPosition.Y])
                {
                    QuestManager.ProgressUserQuest(Session, QuestType.FURNI_STACK);
                }
            }
        }

        private static void MoveWallItem(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session))
            {
                return;
            }

            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Type != ItemType.WallItem)
            {
                return;
            }

            string RawPlacementData = Message.PopString();
            string WallPos = Instance.SetWallItem(Session, RawPlacementData, Item);

            if (WallPos.Length > 0)
            {
                Item.MoveToRoom(null, Instance.RoomId, new Vector3(0, 0, 0), 0, WallPos);
                RoomManager.MarkWriteback(Item, false);    

                Instance.BroadcastMessage(RoomWallItemMovedComposer.Compose(Item));

                ItemEventDispatcher.InvokeItemEventHandler(Session, Item, Instance, ItemEventType.Moved);
            }
        }

        private static void OpenSticky(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Behavior != ItemBehavior.StickyNote)
            {
                return;
            }

            Session.SendData(StickyDataComposer.Compose(Item));
        }

        private static void SaveSticky(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Behavior != ItemBehavior.StickyNote)
            {
                return;
            }

            StickieEditingRights Rights = Instance.GetStickieEditingRights(Session, Item);

            if (Rights == StickieEditingRights.ReadOnly)
            {
                return;
            }

            string RawData = Message.PopString();
            string[] Bits = RawData.Split(' ');

            if (Bits.Length < 2)
            {
                return;
            }

            string Color = Bits[0].ToUpper().Trim();
            string Text = UserInputFilter.FilterString(RawData.Substring(Color.Length + 1, RawData.Length - (Color.Length + 1))).Trim();

            if (Color != "FFFF33" && Color != "FF9CFF" && Color != "9CCEFF" && Color != "9CFF9C" || Text.Length > 391)
            {
                return;
            }

            Item.Flags = RawData;
            Item.DisplayFlags = Color;

            if (Rights == StickieEditingRights.GuestEdit)
            {
                Item.Flags += "\n-----\n" + Session.CharacterInfo.Username + "\n" + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();
            }

            Instance.RevokeTemporaryStickieRights(Item.Id);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Item.SynchronizeDatabase(MySqlClient, true);
            }

            Instance.BroadcastMessage(RoomWallItemMovedComposer.Compose(Item));
        }

        private static void DeleteSticky(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Item Item = Instance.GetItem(Message.PopWiredUInt32());

            if (Item == null || Item.Definition.Behavior != ItemBehavior.StickyNote)
            {
                return;
            }

            if (Instance.TakeItem(Item.Id))
            {
                Instance.RegenerateRelativeHeightmap();

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    Item.RemovePermanently(MySqlClient);
                }
            }
        }

        private static void GetMoodlightInfo(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Item Item = Instance.MoodlightItem;

            if (Item == null)
            {
                return;
            }

            Session.SendData(MoodlightDataComposer.Compose(MoodlightData.GenerateFromFlags(Item.Flags)));
        }

        private static void SwitchMoodlight(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Item Item = Instance.MoodlightItem;

            if (Item == null)
            {
                return;
            }

            MoodlightData Data = MoodlightData.GenerateFromFlags(Item.Flags);
            Data.Enabled = !Data.Enabled;

            Item.Flags = Data.ToItemFlagData();
            Item.DisplayFlags = Data.ToDisplayData();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Item.SynchronizeDatabase(MySqlClient, true);
            }

            Item.BroadcastStateUpdate(Instance);
        }

        private static void UpdateMoodlight(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Item Item = Instance.MoodlightItem;

            if (Item == null)
            {
                return;
            }

            MoodlightData Data = MoodlightData.GenerateFromFlags(Item.Flags);
            int PresetId = Message.PopWiredInt32();
            MoodlightPreset Preset = null;

            if (Data.Presets.ContainsKey(PresetId))
            {
                Preset = Data.Presets[PresetId];
            }

            if (Preset == null)
            {
                return;
            }

            Preset.BackgroundOnly = !Message.PopWiredBoolean();
            Preset.ColorCode = UserInputFilter.FilterString(Message.PopString().Trim());
            Preset.ColorIntensity = Message.PopWiredInt32();

            if (!MoodlightData.IsValidColor(Preset.ColorCode))
            {
                return;
            }

            Item.Flags = Data.ToItemFlagData();
            Item.DisplayFlags = Data.ToDisplayData();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Item.SynchronizeDatabase(MySqlClient, true);
            }

            Item.BroadcastStateUpdate(Instance);
        }

        private static void PlacePet(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || (!Instance.CheckUserRights(Session, true) && !Instance.Info.AllowPets))
            {
                return;
            }

            Pet Pet = Session.PetInventoryCache.GetPet(Message.PopWiredUInt32());

            if (Pet == null)
            {
                return;
            }

            Vector2 DesiredPosition = new Vector2(Message.PopWiredInt32(), Message.PopWiredInt32());

            if (!Instance.IsValidPosition(DesiredPosition))
            {
                return;
            }

            Bot BotDefinition = BotManager.GetHandlerDefinitionForPetType(Pet.Type);

            if (BotDefinition == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("This pet cannot be placed right now. Please try again later."));
                return;
            }

            if (!Instance.CanPlacePet(Instance.CheckUserRights(Session, true)))
            {
                Session.SendData(RoomItemPlacementErrorComposer.Compose(RoomItemPlacementErrorCode.PetLimitReached));
                return;
            }

            Vector3 Position = new Vector3(DesiredPosition.X, DesiredPosition.Y, Instance.GetUserStepHeight(DesiredPosition));

            Pet.MoveToRoom(Instance.RoomId, Position);
            Instance.AddBotToRoom(BotManager.CreateNewInstance(BotDefinition, Instance.RoomId, Position, Pet));

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Pet.SynchronizeDatabase(MySqlClient);
            }

            Session.SendData(InventoryPetRemovedComposer.Compose(Pet.Id));
        }

        private static void GetPetInfo(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            uint ActorRefId = Message.PopWiredUInt32();
            RoomActor Actor = Instance.GetActorByReferenceId(ActorRefId, RoomActorType.AiBot);

            if (Actor == null)
            {
                return;
            }

            Pet PetData = ((Bot)Actor.ReferenceObject).PetData;

            if (PetData == null)
            {
                return;
            }

            Session.SendData(PetInfoComposer.Compose(Actor.ReferenceId, PetData));
        }

        private static void TakePet(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            RoomActor Actor = Instance.GetActorByReferenceId(Message.PopWiredUInt32(), RoomActorType.AiBot);

            if (Actor == null)
            {
                return;
            }

            Pet PetData = ((Bot)Actor.ReferenceObject).PetData;

            if (PetData == null || (PetData.OwnerId != Session.CharacterId && !Session.HasRight("hotel_admin")))
            {
                return;
            }

            Instance.RemoveActorFromRoom(Actor.Id);
            Session.PetInventoryCache.Add(PetData);
            Session.SendData(InventoryPetAddedComposer.Compose(PetData));
        }

        private static void RespectPet(Session Session, ClientMessage Message)
        {
            if (Session.CharacterInfo.RespectCreditPets <= 0)
            {
                return;
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            RoomActor Actor = Instance.GetActorByReferenceId(Message.PopWiredUInt32(), RoomActorType.AiBot);

            if (Actor == null)
            {
                return;
            }

            Pet PetData = ((Bot)Actor.ReferenceObject).PetData;

            if (PetData == null)
            {
                return;
            }

            Session.CharacterInfo.RespectCreditPets = 500;/*--;*/
            PetData.Score++;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.CharacterInfo.SynchronizeRespectData(MySqlClient);
                PetData.SynchronizeDatabase(MySqlClient);
            }

            Instance.BroadcastMessage(RoomPetUpdateComposer.Compose(Actor.ReferenceId, PetData));
        }
    }
}
