using System;

namespace Snowlight.Communication.Outgoing
{
    public static class HotelManagerNotificationComposer
    {
        public static ServerMessage Compose(string MessageText, string Url = "")
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NOTIFICATION_HOTEL_MANAGER);
            Message.AppendStringWithBreak(MessageText);

            if (Url.Length > 0)
            {
                Message.AppendStringWithBreak(Url);
            }

            return Message;
        }
    }
}
