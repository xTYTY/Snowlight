using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;
using Snowlight.Specialized;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class RollerHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Roller, new ItemEventHandler(HandleRoller));
        }

        private static bool HandleRoller(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.UpdateTick:

                    List<RoomActor> ActorsToMove = Instance.GetActorsOnPosition(Item.RoomPosition.GetVector2());
                    List<Item> ItemsToMove = new List<Item>();

                    if (ActorsToMove != null)
                    {
                        foreach (RoomActor Actor in ActorsToMove)
                        {
                            if (Actor.IsMoving)
                            {
                                continue;
                            }

                            if (Instance.IsValidStep(Actor.Position.GetVector2(), Item.SquareInFront, true))
                            {
                                Actor.PositionToSet = Item.SquareInFront;
                                Instance.BroadcastMessage(RollerEventComposer.Compose(Actor.Position, new Vector3(
                                    Actor.PositionToSet.X, Actor.PositionToSet.Y,
                                    Instance.GetUserStepHeight(Actor.PositionToSet)), Item.Id, Actor.Id, 0));
                            }
                        }
                    }

                    goto case ItemEventType.InstanceLoaded;

                case ItemEventType.InstanceLoaded:
                case ItemEventType.Placed:

                    Item.RequestUpdate(4);
                    break;
            }

            return true;
        }
    }
}
