using System;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class IgnoredUserListComposer
    {
        public static ServerMessage Compose(List<string> Names)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.IGNORED_USERS_LIST);
            Message.AppendInt32(Names.Count);

            foreach (string Name in Names)
            {
                Message.AppendStringWithBreak(Name);
            }

            return Message;
        }
    }
}
