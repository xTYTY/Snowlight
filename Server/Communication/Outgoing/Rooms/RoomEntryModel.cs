using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomEntryModelComposer
    {
        public static ServerMessage Compose(string Model, uint RoomId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_ENTRY_MODEL);
            Message.AppendStringWithBreak(Model);
            Message.AppendUInt32(RoomId);
            return Message;
        }
    }
}
