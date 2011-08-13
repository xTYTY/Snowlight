using System;
using Snowlight.Game.Pets;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomPetUpdateComposer
    {
        public static ServerMessage Compose(uint DisplayId, Pet Pet)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_PET_UPDATE);
            Message.AppendInt32(9);
            Message.AppendUInt32(DisplayId);
            Message.AppendUInt32(DisplayId);
            Message.AppendStringWithBreak(Pet.Name);
            Message.AppendInt32(Pet.Type);
            Message.AppendInt32(Pet.Race);
            Message.AppendStringWithBreak(Pet.ColorCode);
            return Message;
        }
    }
}
