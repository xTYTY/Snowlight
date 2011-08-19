using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Game.Misc;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class GateHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Gate, new ItemEventHandler(HandleFixedGateSwitch));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.OneWayGate, new ItemEventHandler(HandleOneWayGate));
        }

        private static bool HandleFixedGateSwitch(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session))
                    {
                        return true;
                    }

                    List<Vector2> GateTiles = Instance.CalculateAffectedTiles(Item, Item.RoomPosition.GetVector2(), Item.RoomRotation);

                    foreach (Vector2 Tile in GateTiles)
                    {
                        if (Instance.GetActorsOnPosition(Tile).Count > 0)
                        {
                            return true;
                        }
                    }

                    int CurrentState = 0;
                    int.TryParse(Item.Flags, out CurrentState);

                    Item.Flags = (CurrentState == 0 ? 1 : 0).ToString();
                    Item.DisplayFlags = Item.Flags;

                    RoomManager.MarkWriteback(Item, true);

                    Item.BroadcastStateUpdate(Instance);
                    Instance.RegenerateRelativeHeightmap();
                    break;
            }

            return true;
        }

        private static bool HandleOneWayGate(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.InstanceLoaded:
                case ItemEventType.Moved:
                case ItemEventType.Placed:

                    if (Item.DisplayFlags != "0")
                    {
                        Item.DisplayFlags = "0";
                        Item.BroadcastStateUpdate(Instance);
                    }

                    foreach (uint ActorId in Item.TemporaryInteractionReferenceIds.Values)
                    {
                        RoomActor ActorToUnlock = Instance.GetActor(ActorId);

                        if (ActorToUnlock != null)
                        {
                            ActorToUnlock.UnblockWalking();
                        }
                    }

                    Item.TemporaryInteractionReferenceIds.Clear();
                    break;

                case ItemEventType.Interact:

                    RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

                    if (Actor == null)
                    {
                        break;
                    }

                    if (Actor.Position.X != Item.SquareInFront.X || Actor.Position.Y != Item.SquareInFront.Y)
                    {
                        Actor.MoveToItemAndInteract(Item, RequestData, Opcode);
                        break;
                    }

                    if (Item.TemporaryInteractionReferenceIds.Count == 0 && Instance.IsValidStep(Item.RoomPosition.GetVector2(),
                        Item.SquareBehind, true) && Item.DisplayFlags == "0")
                    {
                        Actor.BlockWalking();
                        Actor.MoveTo(Item.RoomPosition.GetVector2(), true, true, true);
                        Item.TemporaryInteractionReferenceIds.Add(1, Actor.Id);
                        Item.RequestUpdate(1);
                    }

                    break;

                case ItemEventType.UpdateTick:

                    RoomActor UpdateActor = null;

                    if (Item.TemporaryInteractionReferenceIds.ContainsKey(1))
                    {
                        UpdateActor = Instance.GetActor(Item.TemporaryInteractionReferenceIds[1]);
                    }

                    if (UpdateActor == null || !Instance.IsValidStep(Item.RoomPosition.GetVector2(), Item.SquareBehind, true)
                        || ((UpdateActor.Position.X != Item.RoomPosition.X || UpdateActor.Position.Y !=
                        Item.RoomPosition.Y) && (UpdateActor.Position.X != Item.SquareInFront.X ||
                        UpdateActor.Position.Y != Item.SquareInFront.Y)))
                    {
                        if (Item.DisplayFlags != "0")
                        {
                            Item.DisplayFlags = "0";
                            Item.BroadcastStateUpdate(Instance);
                        }

                        if (Item.TemporaryInteractionReferenceIds.Count > 0)
                        {
                            Item.TemporaryInteractionReferenceIds.Clear();
                        }

                        if (UpdateActor != null)
                        {
                            UpdateActor.UnblockWalking();
                        }

                        break;
                    }

                    Item.DisplayFlags = "1";
                    Item.BroadcastStateUpdate(Instance);

                    UpdateActor.MoveTo(Item.SquareBehind, true, true, true);

                    Item.RequestUpdate(2);
                    break;
            }

            return true;
        }
    }
}
