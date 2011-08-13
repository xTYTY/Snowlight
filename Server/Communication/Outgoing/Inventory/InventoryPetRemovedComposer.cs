using System;

namespace Snowlight.Communication.Outgoing
{
    public static class InventoryPetRemovedComposer
    {
        public static ServerMessage Compose(uint PetId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INVENTORY_PET_REMOVED);
            Message.AppendUInt32(PetId);
            return Message;
        }
    }
}
