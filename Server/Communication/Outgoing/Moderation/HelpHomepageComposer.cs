using System;
using System.Collections.Generic;

using Snowlight.Game.Moderation;

namespace Snowlight.Communication.Outgoing
{
    public static class HelpHomepageComposer
    {
        public static ServerMessage Compose(List<HelpTopic> ImportantTopics, List<HelpTopic> FaqTopics)
        {
            // HFHPA[VCHow do I get help with an account problem?XWCHow do I get help with playing Habbo?[HAThe  Habbo Way (community guidelines)Z[CWhere can I find Credits Information?
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_HOMEPAGE);
            Message.AppendInt32(ImportantTopics.Count);

            foreach (HelpTopic Topic in ImportantTopics)
            {
                Message.AppendUInt32(Topic.Id);
                Message.AppendStringWithBreak(Topic.Title);
            }

            Message.AppendInt32(FaqTopics.Count);

            foreach (HelpTopic Topic in FaqTopics)
            {
                Message.AppendUInt32(Topic.Id);
                Message.AppendStringWithBreak(Topic.Title);
            }

            return Message;
        }
    }
}
