using System;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class InfobusQuestionStartComposer
    {
        public static ServerMessage Compose(string QuestionText, Dictionary<int, string> Answers)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INFOBUS_QUESTION_START);
            Message.AppendStringWithBreak(QuestionText);
            Message.AppendInt32(Answers.Count);

            foreach (KeyValuePair<int, string> Answer in Answers)
            {
                Message.AppendInt32(Answer.Key);
                Message.AppendStringWithBreak(Answer.Value);
            }

            return Message;
        }
    }
}
