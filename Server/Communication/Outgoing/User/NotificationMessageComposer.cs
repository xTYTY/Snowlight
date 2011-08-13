using System;

namespace Snowlight.Communication.Outgoing
{
    public static class NotificationMessageComposer
    {
        public static ServerMessage Compose(string MessageText, string Url = "")
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NOTIFICATION);
            Message.AppendStringWithBreak(MessageText);

            if (Url.Length > 0)
            {
                Message.AppendStringWithBreak(Url);
            }

            return Message;
        }
    }
}
