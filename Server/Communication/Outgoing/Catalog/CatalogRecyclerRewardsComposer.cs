using System;
using System.Collections.Generic;

using Snowlight.Game.Items;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogRecyclerRewardsComposer
    {
        public static ServerMessage Compose(Dictionary<int, List<uint>> Rewards)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_RECYCLER_REWARDS);
            Message.AppendInt32(Rewards.Count);

            foreach (KeyValuePair<int, List<uint>> Level in Rewards)
            {
                int ChanceDisplay = 0;

                switch (Level.Key)
                {
                    case 5:

                        ChanceDisplay = 2000;
                        break;

                    case 4:

                        ChanceDisplay = 200;
                        break;

                    case 3:

                        ChanceDisplay = 40;
                        break;

                    case 2:

                        ChanceDisplay = 4;
                        break;
                }


                Message.AppendInt32(Level.Key);
                Message.AppendInt32(ChanceDisplay);
                Message.AppendInt32(Level.Value.Count);

                foreach (uint ItemId in Level.Value)
                {
                    ItemDefinition Definition = ItemDefinitionManager.GetDefinition(ItemId);

                    Message.AppendStringWithBreak(Definition.TypeLetter);
                    Message.AppendUInt32(Definition.SpriteId);
                }
            }

            return Message;
        }
    }
}
