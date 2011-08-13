using System;
using Snowlight.Game.Pets;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryPetAddedComposer
    {
        public static ServerMessage Compose(Pet Pet)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_PET_ADDED);
            Message.AppendUInt32(Pet.Id);
            Message.AppendStringWithBreak(Pet.Name);
            Message.AppendInt32(Pet.Type);
            Message.AppendInt32(Pet.Race);
            Message.AppendStringWithBreak(Pet.ColorCode);
            return Message;
        }
    }
}
