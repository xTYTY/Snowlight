using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerImMessageComposer
    {
        public static ServerMessage Compose(uint SenderId, string Text)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_IM_MESSAGE);
            Message.AppendUInt32(SenderId);
            Message.AppendStringWithBreak(Text);
            return Message;
        }
    }
}
