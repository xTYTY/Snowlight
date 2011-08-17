using System;

using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;
using Snowlight.Communication.Outgoing;
using Snowlight.Storage;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class ExchangeHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.ExchangeItem, new ItemEventHandler(HandleExchangeRedemption));
        }

        private static bool HandleExchangeRedemption(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Interact:

                    int ItemValue = 0;
                    int.TryParse(Item.Flags, out ItemValue);

                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        if (ItemValue != 0)
                        {
                            Session.CharacterInfo.UpdateCreditsBalance(MySqlClient, ItemValue);
                            Session.SendData(CreditsBalanceComposer.Compose(Session.CharacterInfo.CreditsBalance));
                        }

                        Item.RemovePermanently(MySqlClient);
                    }

                    Instance.TakeItem(Item.Id);
                    Instance.RegenerateRelativeHeightmap();
                    break;
            }

            return true;
        }
    }
}
