using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Game.Misc;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class GenericHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Switchable, new ItemEventHandler(HandleGenericSwitch));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Bed, new ItemEventHandler(HandleGenericSwitch));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Seat, new ItemEventHandler(HandleGenericSwitch));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.StepSwitch, new ItemEventHandler(HandleStepSwitch));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Scoreboard, new ItemEventHandler(HandleScoreboard));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Rental, new ItemEventHandler(HandleRental));
        }

        private static bool HandleGenericSwitch(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData)
        {
            switch (Event)
            {
                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session))
                    {
                        return true;
                    }

                    int CurrentState = 0;
                    int.TryParse(Item.Flags, out CurrentState);

                    int NewState = CurrentState + 1;

                    if (CurrentState < 0 || CurrentState >= (Item.Definition.BehaviorData - 1))
                    {
                        NewState = 0;
                    }

                    if (CurrentState != NewState)
                    {
                        Item.Flags = NewState.ToString();
                        Item.DisplayFlags = Item.Flags;

                        RoomManager.MarkWriteback(Item, true);

                        Item.BroadcastStateUpdate(Instance);
                    }

                    break;
            }

            return true;
        }

        private static bool HandleStepSwitch(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData)
        {
            switch (Event)
            {
                case ItemEventType.InstanceLoaded:
                case ItemEventType.Moved:
                case ItemEventType.Placed:

                    Item.RequestUpdate(1);
                    break;

                case ItemEventType.UpdateTick:

                    string Flags = "0";

                    if (Instance.GetActorsOnPosition(Item.RoomPosition.GetVector2()).Count > 0)
                    {
                        Flags = "1";
                    }

                    if (Item.DisplayFlags != Flags)
                    {
                        Item.DisplayFlags = Flags;
                        Item.BroadcastStateUpdate(Instance);
                    }

                    Item.RequestUpdate(1);
                    break;
            }

            return true;
        }

        private static bool HandleScoreboard(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData)
        {
            switch (Event)
            {
                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session))
                    {
                        break;
                    }

                    RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

                    if (Actor == null)
                    {
                        break;
                    }

                    if (!Distance.TilesTouching(Actor.Position.GetVector2(), Item.RoomPosition.GetVector2()))
                    {
                        Actor.MoveToItemAndInteract(Item, RequestData);
                        break;
                    }

                    int Val = 0;
                    int.TryParse(Item.DisplayFlags, out Val);

                    if (RequestData == 1)
                    {
                        Val--;

                        if (Val < 0)
                        {
                            Val = 99;
                        }
                    }
                    else if (RequestData == 2)
                    {
                        Val++;

                        if (Val > 99)
                        {
                            Val = 0;
                        }
                    }
                    else
                    {
                        Val = (Val == -1 ? 0 : -1);
                    }

                    Item.DisplayFlags = Val.ToString();
                    Item.BroadcastStateUpdate(Instance);
                    break;
            }

            return true;
        }

        private static bool HandleRental(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData)
        {
            switch (Event)
            {
                case ItemEventType.Placed:
                case ItemEventType.InstanceLoaded:

                    if (Item.PendingExpiration)
                    {
                        int DesiredTicks = (int)((double)(Math.Ceiling(Item.ExpireTimeLeft * 2)));

                        if (DesiredTicks <= 0)
                        {
                            goto case ItemEventType.UpdateTick;
                        }

                        Item.RequestUpdate(DesiredTicks);
                        return true;
                    }

                    break;

                case ItemEventType.UpdateTick:

                    if (Item.PendingExpiration)
                    {
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            Item.RemovePermanently(MySqlClient);
                            Instance.TakeItem(Item.Id);
                            Instance.RegenerateRelativeHeightmap();
                        }

                        return true;
                    }

                    break;
            }

            return HandleGenericSwitch(Session, Item, Instance, Event, RequestData);
        }
    }
}
