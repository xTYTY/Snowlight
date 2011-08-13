using System;
using System.Collections.ObjectModel;

using Snowlight.Game.Pets;
using Snowlight.Specialized;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class PetInventoryComposer
    {
        public static ServerMessage Compose(Dictionary<uint, Pet> Pets)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_PETS);
            Message.AppendInt32(Pets.Count);

            foreach (Pet Pet in Pets.Values)
            {
                Message.AppendUInt32(Pet.Id);
                Message.AppendStringWithBreak(Pet.Name);
                Message.AppendInt32(Pet.Type);
                Message.AppendInt32(Pet.Race);
                Message.AppendStringWithBreak(Pet.ColorCode);
            }

            return Message;
        }
    }
}