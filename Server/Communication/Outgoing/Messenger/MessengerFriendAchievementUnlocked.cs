using System;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public enum MessengerFriendEventType
    {
        EventStarted = 0,
        AchievementUnlocked = 1,
        QuestCompleted = 2
    }

    public static class MessengerFriendEventComposer
    {
        public static ServerMessage Compose(uint UserId, MessengerFriendEventType EventType, string EventData)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_FRIEND_EVENT);
            Message.AppendStringWithBreak(UserId.ToString());
            Message.AppendInt32((int)EventType);
            Message.AppendStringWithBreak(EventData);
            return Message;
        }
    }
}
