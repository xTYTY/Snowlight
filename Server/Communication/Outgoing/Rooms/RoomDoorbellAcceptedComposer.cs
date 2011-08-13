using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomDoorbellAcceptedComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.ROOM_DOORBELL_ACCEPTED);
        }
    }
}
