using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerErrorEvent
    {
        public static ServerMessage Compose(uint Code1, uint Code2)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_ERROR_EVENT);
            Message.AppendUInt32(Code1);
            Message.AppendUInt32(Code2);
            return Message;
        }
    }
}
