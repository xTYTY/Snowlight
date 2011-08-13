using System;

using Snowlight.Game.Achievements;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class QuestCompletedComposer
    {
        public static ServerMessage Compose(Session Session, Quest Quest)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.QUEST_COMPLETED);
            QuestListComposer.SerializeQuest(Message, Session, Quest, Quest.Category);
            return Message;
        }
    }
}
