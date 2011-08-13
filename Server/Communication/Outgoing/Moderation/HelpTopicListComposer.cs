using System;
using System.Collections.Generic;

using Snowlight.Game.Moderation;

namespace Snowlight.Communication.Outgoing
{
    public static class HelpTopicListComposer
    {
        public static ServerMessage Compose(uint CategoryId, List<HelpTopic> Topics)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_TOPIC_LIST);
            Message.AppendUInt32(CategoryId);
            Message.AppendStringWithBreak(string.Empty);
            Message.AppendInt32(Topics.Count);

            foreach (HelpTopic Topic in Topics)
            {
                Message.AppendUInt32(Topic.Id);
                Message.AppendStringWithBreak(Topic.Title);
            }

            return Message;
        }
    }
}
