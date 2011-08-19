using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Game.Misc;
using Snowlight.Storage;
using Snowlight.Specialized;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class TeleporterHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Teleporter, new ItemEventHandler(HandleTeleporter));
        }

        private static bool HandleTeleporter(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            RoomActor Actor = null;
                    
            uint LinkedRef = 0;
            uint.TryParse(Item.Flags, out LinkedRef);

            switch (Event)
            {
                case ItemEventType.InstanceLoaded:

                    Item.DisplayFlags = "0";
                    break;

                case ItemEventType.Moved:

                    if (RequestData != 1)
                    {
                        goto case ItemEventType.Removing;
                    }

                    break;

                case ItemEventType.Removing:
                case ItemEventType.Placed:

                    if (Item.DisplayFlags != "0")
                    {
                        Item.DisplayFlags = "0";

                        if (Event == ItemEventType.Moved)
                        {
                            Item.BroadcastStateUpdate(Instance);
                        }
                    }

                    foreach (uint RefId in Item.TemporaryInteractionReferenceIds.Values)
                    {
                        RoomActor InteractingActor = Instance.GetActor(RefId);

                        if (InteractingActor != null)
                        {
                            InteractingActor.UnblockWalking();
                        }
                    }

                    Item.TemporaryInteractionReferenceIds.Clear();
                    break;

                case ItemEventType.Interact:

                    if (Session != null)
                    {
                        Actor = Instance.GetActorByReferenceId(Session.CharacterId);
                    }

                    if (Actor == null)
                    {
                        break;
                    }

                    bool IsInFront = (Actor.Position.X == Item.SquareInFront.X && Actor.Position.Y == Item.SquareInFront.Y);
                    bool IsInTele = !IsInFront && (Actor.Position.X == Item.RoomPosition.X &&
                        Actor.Position.Y == Item.RoomPosition.Y);

                    if (!IsInFront && !IsInTele)
                    {
                        Actor.MoveToItemAndInteract(Item, RequestData, Opcode);
                        break;
                    }

                    if (Item.DisplayFlags == "0" && Item.TemporaryInteractionReferenceIds.Count == 0)
                    {
                        Item.TemporaryInteractionReferenceIds.Add(1, Actor.Id);
                        Actor.BlockWalking();

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            TeleporterLinkFinder.FillCache(MySqlClient, LinkedRef);
                        }

                        if (IsInTele)
                        {
                            Item.RequestUpdate(1);
                        }
                        else
                        {
                            Item.DisplayFlags = "1";
                            Actor.MoveTo(Item.RoomPosition.GetVector2(), true, true, true);

                            Item.BroadcastStateUpdate(Instance);
                            Item.RequestUpdate(3);
                        }
                    }

                    break;

                case ItemEventType.UpdateTick:

                    RoomActor OutgoingUser = null;
                    RoomActor IncomingUser = null;

                    if (Item.TemporaryInteractionReferenceIds.ContainsKey(1))
                    {
                        OutgoingUser = Instance.GetActor(Item.TemporaryInteractionReferenceIds[1]);

                        if (OutgoingUser == null)
                        {
                            Item.TemporaryInteractionReferenceIds.Remove(1);
                        }
                    }

                    if (Item.TemporaryInteractionReferenceIds.ContainsKey(2))
                    {
                        IncomingUser = Instance.GetActor(Item.TemporaryInteractionReferenceIds[2]);

                        if (IncomingUser == null)
                        {
                            Item.TemporaryInteractionReferenceIds.Remove(2);
                        }
                    }

                    string EffectToApply = "0";
                    uint LinkedRoomRefId = TeleporterLinkFinder.GetValue(LinkedRef);
                    RoomInstance LinkedRoomRef = RoomManager.GetInstanceByRoomId(LinkedRoomRefId);

                    if (OutgoingUser != null)
                    {
                        Item TargetItem = null;
                        Session OutgoingSession = SessionManager.GetSessionByCharacterId(OutgoingUser.ReferenceId);

                        if (LinkedRoomRef == null && LinkedRoomRefId > 0)
                        {
                            RoomManager.TryLoadRoomInstance(LinkedRoomRefId);
                            LinkedRoomRef = RoomManager.GetInstanceByRoomId(LinkedRoomRefId);
                        }

                        if (LinkedRoomRef != null)
                        {
                            TargetItem = LinkedRoomRef.GetItem(LinkedRef);
                        }

                        if (OutgoingSession == null || OutgoingUser.Position.X != Item.RoomPosition.X ||
                            OutgoingUser.Position.Y != Item.RoomPosition.Y || (TargetItem != null &&
                            TargetItem.TemporaryInteractionReferenceIds.ContainsKey(2)))
                        {
                            OutgoingUser.UnblockWalking();
                            Item.TemporaryInteractionReferenceIds.Remove(1);
                        }
                        else if (TargetItem != null)
                        {
                            EffectToApply = "2";

                            RoomActor TeleActor = OutgoingUser;

                            if (Instance != LinkedRoomRef)
                            {
                                OutgoingSession.IsTeleporting = true;
                                OutgoingSession.TargetTeleporterId = LinkedRef;

                                RoomHandler.PrepareRoom(OutgoingSession, LinkedRoomRefId, string.Empty, true);

                                TeleActor = null;
                            }

                            if (TeleActor != null)
                            {
                                TeleActor.BlockWalking();

                                TeleActor.Position = new Vector3(TargetItem.RoomPosition.X, TargetItem.RoomPosition.Y, TargetItem.RoomPosition.Z);
                                TeleActor.BodyRotation = TargetItem.RoomRotation;
                                TeleActor.HeadRotation = TeleActor.BodyRotation;
                                TeleActor.UpdateNeeded = true;

                                if (TargetItem.DisplayFlags != "2")
                                {
                                    TargetItem.DisplayFlags = "2";
                                    TargetItem.BroadcastStateUpdate(LinkedRoomRef);
                                    TargetItem.RequestUpdate(3);
                                }

                                TargetItem.TemporaryInteractionReferenceIds.Add(2, TeleActor.Id);
                            }
                           
                            Item.TemporaryInteractionReferenceIds.Remove(1);
                            Item.RequestUpdate(2);
                        }
                        else if (TargetItem == null)
                        {
                            EffectToApply = "1";
                            OutgoingUser.UnblockWalking();

                            if (Instance.IsValidStep(OutgoingUser.Position.GetVector2(), Item.SquareInFront, true))
                            {
                                OutgoingUser.MoveTo(Item.SquareInFront);
                            }

                            Item.TemporaryInteractionReferenceIds.Remove(1);
                            Item.RequestUpdate(2);
                        }
                    }

                    if (IncomingUser != null)
                    {
                        if (IncomingUser.Position.X != Item.RoomPosition.X || IncomingUser.Position.Y != IncomingUser.Position.Y)
                        {
                            IncomingUser.UnblockWalking();
                            Item.TemporaryInteractionReferenceIds.Remove(2);
                        }
                        else
                        {
                            EffectToApply = "1";

                            IncomingUser.UnblockWalking();
                            Item.TemporaryInteractionReferenceIds.Remove(2);

                            if (Instance.CanInitiateMoveToPosition(Item.SquareInFront))
                            {
                                IncomingUser.MoveTo(Item.SquareInFront);
                            }

                            Item.RequestUpdate(3);
                        }
                    }

                    if (Item.DisplayFlags != EffectToApply)
                    {
                        Item.DisplayFlags = EffectToApply;
                        Item.BroadcastStateUpdate(Instance);
                    }

                    break;
            }

            return true;
        }
    }
}
