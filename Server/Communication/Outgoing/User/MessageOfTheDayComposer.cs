using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MessageOfTheDayComposer
    {
        public static ServerMessage Compose(string MessageText)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSAGE_OF_THE_DAY);
            Message.AppendBoolean(true);
            Message.AppendStringWithBreak(MessageText);
            return Message;
        }
    }
}
