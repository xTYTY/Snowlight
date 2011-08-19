using System;

using Snowlight.Game.Rooms;
using Snowlight.Game.Sessions;
using Snowlight.Game.Misc;
using Snowlight.Communication.Outgoing;
using Snowlight.Storage;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class FireworksHandler
    {
        private static readonly int CHARGE_COSTS_CREDITS = 0;
        private static readonly int CHARGE_COSTS_PIXELS = 20;
        private static readonly int CHARGE_AMOUNT = 10;

        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.Fireworks, new ItemEventHandler(HandleFireworks));
        }

        private static bool HandleFireworks(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            int CurrentCharges = 0;
            int.TryParse(Item.Flags, out CurrentCharges);

            switch (Event)
            {
                case ItemEventType.InstanceLoaded:
                case ItemEventType.Placed:
                case ItemEventType.Moved:
                case ItemEventType.UpdateTick:

                    string DesiredDisplayFlags = "0";

                    if (CurrentCharges > 0)
                    {
                        DesiredDisplayFlags = "1";
                    }

                    if (Item.DisplayFlags != DesiredDisplayFlags)
                    {
                        Item.DisplayFlags = DesiredDisplayFlags;
                        Item.BroadcastStateUpdate(Instance);
                    }

                    break;

                case ItemEventType.Interact:

                    RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

                    if (Actor == null)
                    {
                        return true;
                    }

                    if (Distance.Calculate(Actor.Position.GetVector2(), Item.RoomPosition.GetVector2()) > 1)
                    {
                        Actor.MoveToItemAndInteract(Item, RequestData, Opcode, Item.SquareBehind);
                        return true;
                    }

                    switch (RequestData)
                    {
                        // Purchase charges
                        case 2:

                            if (Session.CharacterInfo.CreditsBalance < CHARGE_COSTS_CREDITS)
                            {
                                return true;
                            }

                            if (Session.CharacterInfo.ActivityPointsBalance < CHARGE_COSTS_PIXELS)
                            {
                                return true;
                            }

                            bool Update = (CurrentCharges <= 0);
                            CurrentCharges += CHARGE_AMOUNT;

                            Item.Flags = CurrentCharges.ToString();

                            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                            {
                                if (CHARGE_COSTS_CREDITS > 0)
                                {
                                    Session.CharacterInfo.UpdateCreditsBalance(MySqlClient, -CHARGE_COSTS_CREDITS);
                                    Session.SendData(CreditsBalanceComposer.Compose(Session.CharacterInfo.CreditsBalance));
                                }

                                if (CHARGE_COSTS_PIXELS > 0)
                                {
                                    Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, -CHARGE_COSTS_PIXELS);
                                    Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance,
                                        -CHARGE_COSTS_PIXELS));
                                }

                                Item.SynchronizeDatabase(MySqlClient, true);
                            }

                            Session.SendData(FireworksChargeInfoComposer.Compose(Item.Id, CurrentCharges, CHARGE_COSTS_CREDITS,
                                CHARGE_COSTS_PIXELS, CHARGE_AMOUNT));

                            if (Update)
                            {
                                Item.DisplayFlags = "1";
                                Item.BroadcastStateUpdate(Instance);
                            }

                            break;

                        case 1:

                            Session.SendData(FireworksChargeInfoComposer.Compose(Item.Id, CurrentCharges, CHARGE_COSTS_CREDITS,
                                CHARGE_COSTS_PIXELS, CHARGE_AMOUNT));
                            break;

                        default:
                        case 0:

                            if (Item.DisplayFlags == "2")
                            {
                                return true;
                            }

                            if (CurrentCharges > 0)
                            {
                                Item.DisplayFlags = "2";
                                Item.BroadcastStateUpdate(Instance);

                                Item.Flags = (--CurrentCharges).ToString();
                                RoomManager.MarkWriteback(Item, true);

                                Item.RequestUpdate(Item.Definition.BehaviorData);
                            }
                            else
                            {
                                goto case 1;
                            }

                            break;
                    }

                    break;
            }

            return true;
        }
    }
}
