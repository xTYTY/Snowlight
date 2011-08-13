using System;
using System.Collections.Generic;

using Snowlight.Game.Items;
using Snowlight.Game.Pets;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogPetDataComposer
    {
        public static ServerMessage Compose(CatalogItem Item, List<PetRaceData> RaceData, int PetType)
        {
            // L{a0 pet12RAPCHIHPCIIHPCJIHPCKIHPCPAIHPCQAIH
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_PET_DATA);
            Message.AppendStringWithBreak(Item.DisplayName);
            Message.AppendInt32(RaceData.Count);

            foreach (PetRaceData Race in RaceData)
            {
                Message.AppendInt32(PetType); // Pet type
                Message.AppendInt32(Race.Data1); // Color??
                Message.AppendInt32(Race.Data2);
                Message.AppendInt32(Race.Data3);
            }

            return Message;
        }
    }
}
