using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserRemovedComposer
    {
        public static ServerMessage Compose(uint Id)
        {
            ServerMessage Message = new ServerMessage(29);
            Message.AppendRawUInt32(Id);
            return Message;
        }
    }
}
