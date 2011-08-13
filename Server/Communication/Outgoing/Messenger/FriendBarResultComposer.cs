using System;

namespace Snowlight.Communication.Outgoing
{
    public static class FriendBarResultComposer
    {
        public static ServerMessage Compose(bool Success)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.FRIEND_BAR_RESULT);
            Message.AppendBoolean(Success);
            return Message;
        }
    }
}
