using System;

using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Misc;

using Snowlight.Storage;
using Snowlight.Util;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class RandomizerHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.HabboWheel, new ItemEventHandler(HandleHabboWheel));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.SpinningBottle, new ItemEventHandler(HandleBottle));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Dice, new ItemEventHandler(HandleDice));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.HoloDice, new ItemEventHandler(HandleDice));
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.LoveShuffler, new ItemEventHandler(HandleLoveShuffler));
        }

        private static bool HandleHabboWheel(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Placed:

                    Item.Flags = "-1";
                    Item.DisplayFlags = "-1";

                    Item.RequestUpdate(10);
                    break;

                case ItemEventType.Removing:

                    Item.Flags = "0";
                    Item.DisplayFlags = "0";
                    break;

                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session))
                    {
                        break;
                    }

                    if (Item.Flags != "-1")
                    {
                        Item.Flags = "-1";
                        Item.DisplayFlags = "-1";

                        Item.RequestUpdate(10);
                        Item.BroadcastStateUpdate(Instance);
                    }

                    break;

                case ItemEventType.UpdateTick:

                    Item.Flags = RandomGenerator.GetNext(1, 10).ToString();
                    Item.DisplayFlags = Item.Flags;

                    Item.BroadcastStateUpdate(Instance);

                    RoomManager.MarkWriteback(Item, true);

                    break;
            }

            return true;
        }

        private static bool HandleBottle(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Placed:
                case ItemEventType.Removing:

                    if (Item.Flags != "0")
                    {
                        Item.Flags = "0";
                        Item.DisplayFlags = "0";

                        RoomManager.MarkWriteback(Item, true);
                    }

                    break;

                case ItemEventType.Interact:

                    if (Item.Flags != "-1")
                    {
                        Item.Flags = "-1";
                        Item.DisplayFlags = "-1";

                        Item.BroadcastStateUpdate(Instance);
                        Item.RequestUpdate(4);
                    }

                    break;

                case ItemEventType.UpdateTick:

                    Item.Flags = RandomGenerator.GetNext(0, 7).ToString();
                    Item.DisplayFlags = Item.Flags;

                    Item.BroadcastStateUpdate(Instance);

                    RoomManager.MarkWriteback(Item, true);

                    break;
            }

            return true;
        }

        private static bool HandleDice(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Placed:
                case ItemEventType.Removing:

                    if (Item.Flags != "0" && Item.Flags != "1")
                    {
                        Item.Flags = "0";
                        Item.DisplayFlags = "0";

                        RoomManager.MarkWriteback(Item, true);
                    }

                    break;

                case ItemEventType.Interact:

                    RoomActor TargetActor = Instance.GetActorByReferenceId(Session.CharacterId);

                    if (TargetActor == null)
                    {
                        break;
                    }

                    if (!Distance.TilesTouching(TargetActor.Position.GetVector2(), Item.RoomPosition.GetVector2())
                        && !Distance.IsDiagonal(TargetActor.Position.GetVector2(), Item.RoomPosition.GetVector2()))
                    {
                        TargetActor.MoveToItemAndInteract(Item, RequestData);
                        break;
                    }

                    if (Opcode == 76)
                    {
                        if (Item.Flags != "-1")
                        {
                            Item.Flags = "-1";
                            Item.DisplayFlags = "-1";

                            Item.BroadcastStateUpdate(Instance);
                            Item.RequestUpdate(3);
                        }
                    }
                    else
                    {
                        Item.Flags = "0";
                        Item.DisplayFlags = "0";

                        Item.BroadcastStateUpdate(Instance);
                        RoomManager.MarkWriteback(Item, true);
                    }

                    break;

                case ItemEventType.UpdateTick:

                    Item.Flags = RandomGenerator.GetNext(1, 6).ToString();
                    Item.DisplayFlags = Item.Flags;

                    Item.BroadcastStateUpdate(Instance);

                    RoomManager.MarkWriteback(Item, true);
                    break;
            }

            return true;
        }

        private static bool HandleLoveShuffler(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Placed:
                case ItemEventType.Removing:

                    Item.Flags = "-1";
                    Item.DisplayFlags = "-1";
                    break;

                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session))
                    {
                        break;
                    }

                    if (Item.Flags != "0")
                    {
                        Item.Flags = "0";
                        Item.DisplayFlags = "0";

                        Item.RequestUpdate(10);
                        Item.BroadcastStateUpdate(Instance);
                    }

                    break;

                case ItemEventType.UpdateTick:

                    if (Item.Flags == "0")
                    {
                        Item.Flags = RandomGenerator.GetNext(1, 4).ToString();
                        Item.DisplayFlags = Item.Flags;

                        Item.BroadcastStateUpdate(Instance);
                    }

                    RoomManager.MarkWriteback(Item, true);

                    break;
            }

            return true;
        }
    }
}
