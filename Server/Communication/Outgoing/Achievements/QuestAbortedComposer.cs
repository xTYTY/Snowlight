using System;

namespace Snowlight.Communication.Outgoing
{
    public static class QuestAbortedComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.QUEST_ABORTED);
        }
    }
}
