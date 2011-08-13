using System;

using Snowlight.Game.Rooms;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerFollowResultComposer
    {
        public static ServerMessage Compose(RoomInfo Info)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_FOLLOW_RESULT);
            Message.AppendBoolean(Info.Type == RoomType.Public);
            Message.AppendUInt32(Info.Id);
            return Message;
        }
    }
}
