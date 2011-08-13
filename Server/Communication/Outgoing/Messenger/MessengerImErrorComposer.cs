using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerImErrorComposer
    {
        public static ServerMessage Compose(uint ErrorId, uint ConversationId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_IM_ERROR);
            Message.AppendUInt32(ErrorId);
            Message.AppendUInt32(ConversationId);
            return Message;
        }
    }
}
