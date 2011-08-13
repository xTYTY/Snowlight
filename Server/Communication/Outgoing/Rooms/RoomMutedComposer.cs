using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomMutedComposer
    {
        public static ServerMessage Compose(int TimeToMute)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_MUTED);
            Message.AppendInt32(TimeToMute);
            return Message;
        }
    }
}
