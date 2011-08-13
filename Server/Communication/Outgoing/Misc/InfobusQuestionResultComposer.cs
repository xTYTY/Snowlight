using System;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class InfobusQuestionResultComposer
    {
        public static ServerMessage Compose(string QuestionText, Dictionary<int, string> Answers, Dictionary<int, int> Responses, int TotalParticipants)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.INFOBUS_QUESTION_RESULT);
            Message.AppendStringWithBreak(QuestionText);
            Message.AppendInt32(Answers.Count);

            foreach (KeyValuePair<int, string> Answer in Answers)
            {
                Message.AppendInt32(Answer.Key);
                Message.AppendStringWithBreak(Answer.Value);
                Message.AppendInt32(Responses[Answer.Key]);
            }

            Message.AppendInt32(TotalParticipants);
            return Message;
        }
    }
}
