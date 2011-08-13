using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Snowlight.Game.Rooms;
using Snowlight.Communication;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Infobus
{
    public static class InfobusManager
    {
        private static Dictionary<uint, InfobusQuestion> mInfobusQuestions;

        public static void Initialize()
        {
            mInfobusQuestions = new Dictionary<uint, InfobusQuestion>();

            DataRouter.RegisterHandler(OpcodesIn.INFOBUS_SUBMIT_ANSWER, new ProcessRequestCallback(SubmitAnswer));
        }

        public static void StartPoll(uint RoomId, string Question, List<string> Answers)
        {
            lock (mInfobusQuestions)
            {
                if (mInfobusQuestions.ContainsKey(RoomId))
                {
                    if (!mInfobusQuestions[RoomId].Completed)
                    {
                        mInfobusQuestions[RoomId].EndQuestion();
                    }

                    mInfobusQuestions.Remove(RoomId);
                }

                RoomInstance Instance = RoomManager.GetInstanceByRoomId(RoomId);

                if (Instance == null)
                {
                    return;
                }

                mInfobusQuestions.Add(RoomId, new InfobusQuestion(Instance, Question, Answers));
            }
        }

        private static void SubmitAnswer(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                return;
            }

            RoomActor Actor = Instance.GetActorByReferenceId(Session.CharacterId);

            if (Actor == null)
            {
                return;
            }

            int AnswerId = Message.PopWiredInt32();

            lock (mInfobusQuestions)
            {
                if (mInfobusQuestions.ContainsKey(Instance.RoomId))
                {
                    mInfobusQuestions[Instance.RoomId].SubmitAnswer(Actor.Id, AnswerId);
                }
            }
        }
    }
}
