using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorPopularTagListComposer
    {
        public static ServerMessage Compose(List<KeyValuePair<string, int>> Tags)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_POPULAR_TAGS);
            Message.AppendInt32(Tags.Count);

            foreach (KeyValuePair<string, int> Tag in Tags)
            {
                Message.AppendStringWithBreak(Tag.Key);
                Message.AppendInt32(Tag.Value);
            }

            return Message;
        }
    }
}
