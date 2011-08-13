using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Moderation;

namespace Snowlight.Communication.Outgoing
{
    /*
     * HH[VCPlease go to <a href="https://help.habbo.com/home">https://help.habbo.com/home</a> or click the 'Customer Support' link at the bottom of the Habbo website. The Help Tool is for account help, payment problems and ban queries. If you need general help with playing the game, please read the FAQs.*/
    public static class HelpTopicComposer
    {
        public static ServerMessage Compose(HelpTopic Topic)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_TOPIC);
            Message.AppendUInt32(Topic.Id);
            Message.AppendStringWithBreak(Topic.Body);
            return Message;
        }
    }
}
