using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Game.Items.DefaultBehaviorHandlers;
using Snowlight.Game.Achievements;

namespace Snowlight.Game.Items
{
    public enum ItemEventType
    {
        Placed = 0,
        Moved = 1,
        Removing = 2,
        Interact = 3,
        UpdateTick = 4,
        InstanceLoaded = 5
    }

    public delegate bool ItemEventHandler(Session Session, Item Item, RoomInstance Instance, ItemEventType Type, int RequestData, uint Opcode);

    public static class ItemEventDispatcher
    {
        private static Dictionary<ItemBehavior, List<ItemEventHandler>> mEventHandlers;

        public static void Initialize()
        {
            mEventHandlers = new Dictionary<ItemBehavior, List<ItemEventHandler>>();

            RegisterDefaultEventHandlers();

            // todo: register plugin handlers
        }

        public static void RegisterDefaultEventHandlers()
        {
            GenericHandler.Register();
            GateHandler.Register();
            ExchangeHandler.Register();
            TimedFurnitureHandler.Register();
            RandomizerHandler.Register();
            TeleporterHandler.Register();
            DispenserItemHandler.Register();
            FireworksHandler.Register();
            JukeboxHandler.Register();
            RollerHandler.Register();
        }

        public static void InvokeItemEventHandler(Session Session, Item Item, RoomInstance Instance, ItemEventType Type, int RequestData = 0, uint Opcode = 0)
        {
            if (mEventHandlers.ContainsKey(Item.Definition.Behavior))
            {
                foreach (ItemEventHandler EventHandler in mEventHandlers[Item.Definition.Behavior])
                {
                    if (!EventHandler.Invoke(Session, Item, Instance, Type, RequestData, Opcode))
                    {
                        return;
                    }
                }
            }
        }

        public static void RegisterEventHandler(ItemBehavior BehaviorType, ItemEventHandler EventHandler)
        {
            if (!mEventHandlers.ContainsKey(BehaviorType))
            {
                mEventHandlers.Add(BehaviorType, new List<ItemEventHandler>());
            }

            mEventHandlers[BehaviorType].Add(EventHandler);        
        }
    }
}
