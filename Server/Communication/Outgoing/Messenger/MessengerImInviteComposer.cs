using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerImInviteComposer
    {
        public static ServerMessage Compose(uint SenderId, string Text)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_IM_INVITE);
            Message.AppendUInt32(SenderId);
            Message.AppendStringWithBreak(Text);
            return Message;
        }
    }
}