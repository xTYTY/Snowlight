using System;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class HelpSearchResultsComposer
    {
        public static ServerMessage Compose(Dictionary<uint, string> Results)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_SEARCH_RESULTS);
            Message.AppendInt32(Results.Count);

            foreach (KeyValuePair<uint, string> Result in Results)
            {
                Message.AppendUInt32(Result.Key);
                Message.AppendStringWithBreak(Result.Value);
            }

            return Message;
        }
    }
}
