using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Threading;
using System.Linq;

using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Sessions;
using Snowlight.Game.Rooms;

namespace Snowlight.Game.Infobus
{
    public class InfobusQuestion
    {
        private RoomInstance mInstance;
        private string mQuestionText;
        private Dictionary<int, string> mAnswers;
        private Dictionary<uint, int> mResponses;
        private double mTimestampStarted;
        private Thread mWorkerThread;
        private bool mCompleted;
        private object mSyncRoot;

        public string QuestionText
        {
            get
            {
                return mQuestionText;
            }
        }

        public ReadOnlyCollection<string> Answers
        {
            get
            {
                List<string> Copy = mAnswers.Values.ToList();
                return Copy.AsReadOnly();
            }
        }

        public bool Completed
        {
            get
            {
                return (mWorkerThread == null && mCompleted);
            }
        }

        public InfobusQuestion(RoomInstance Instance, string Question, List<string> Answers)
        {
            mInstance = Instance;
            mQuestionText = Question;
            mAnswers = new Dictionary<int, string>();
            mResponses = new Dictionary<uint, int>();
            mTimestampStarted = UnixTimestamp.GetCurrent();
            mCompleted = false;
            mSyncRoot = new object();

            int i = 1;

            foreach (string Answer in Answers)
            {
                mAnswers.Add(i++, Answer);
            }

            foreach (RoomActor Actor in Instance.Actors)
            {
                if (Actor.Type != RoomActorType.UserCharacter)
                {
                    continue;
                }

                mResponses.Add(Actor.Id, -1);
            }

            mWorkerThread = new Thread(new ThreadStart(ExecuteWorkerThread));
            mWorkerThread.Name = "TempInfobusWorker" + Instance.RoomId;
            mWorkerThread.Priority = ThreadPriority.Lowest;
            mWorkerThread.Start();

            BroadcastDataToParticipants(InfobusQuestionStartComposer.Compose(mQuestionText, mAnswers));
        }

        public void BroadcastDataToParticipants(ServerMessage Message)
        {
            lock (mSyncRoot)
            {
                ReadOnlyCollection<RoomActor> Actors = mInstance.Actors;

                foreach (RoomActor Actor in Actors)
                {
                    if (!mResponses.ContainsKey(Actor.Id))
                    {
                        continue;
                    }

                    Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                    if (ActorSession == null)
                    {
                        continue;
                    }

                    ActorSession.SendData(Message);
                }
            }
        }

        public void SubmitAnswer(uint ActorId, int AnswerId)
        {
            lock (mSyncRoot)
            {
                if (!mResponses.ContainsKey(ActorId) || mResponses[ActorId] > -1)
                {
                    return;
                }

                mResponses[ActorId] = AnswerId;
            }
        }

        public void EndQuestion()
        {
            lock (mSyncRoot)
            {
                Dictionary<int, int> ResponseCount = new Dictionary<int,int>();

                for (int i = 1; i <= mAnswers.Count; i++)
                {
                    ResponseCount.Add(i, 0);
                }

                int ValidVoters = 0;

                foreach (int AnswerId in mResponses.Values)
                {
                    if (ResponseCount.ContainsKey(AnswerId))
                    {
                        ResponseCount[AnswerId]++;
                        ValidVoters++;
                    }
                }

                BroadcastDataToParticipants(InfobusQuestionResultComposer.Compose(mQuestionText, mAnswers, ResponseCount,
                    ValidVoters));

                mCompleted = true;
            }
        }

        private void ExecuteWorkerThread()
        {
            try
            {
                while (!mCompleted)
                {
                    lock (mSyncRoot)
                    {
                        ReadOnlyCollection<RoomActor> Actors = mInstance.Actors;
                        List<uint> AliveActors = new List<uint>();

                        foreach (RoomActor Actor in Actors)
                        {
                            if (Actor.Type != RoomActorType.UserCharacter)
                            {
                                continue;
                            }

                            if (mResponses.ContainsKey(Actor.Id))
                            {
                                AliveActors.Add(Actor.Id);
                            }
                        }

                        List<uint> ToRemove = new List<uint>();
                        int TotalAnswers = 0;

                        foreach (KeyValuePair<uint, int> Actor in mResponses)
                        {
                            if (!AliveActors.Contains(Actor.Key))
                            {
                                ToRemove.Add(Actor.Key);
                                continue;
                            }

                            if (Actor.Value > -1)
                            {
                                TotalAnswers++;
                            }
                        }

                        foreach (uint ActorToRemove in ToRemove)
                        {
                            mResponses.Remove(ActorToRemove);
                        }

                        // if everyone, minus the poll starter, has submitted their answer OR the 15 seconds have been reached, end it
                        if (TotalAnswers >= AliveActors.Count || (UnixTimestamp.GetCurrent() - mTimestampStarted) >= 30)
                        {
                            EndQuestion();
                        }
                    }

                    Thread.Sleep(1000);
                }
            }
            catch (ThreadAbortException) { }
        }
    }
}
