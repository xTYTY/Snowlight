using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;


using Snowlight.Specialized;
using Snowlight.Game.Rooms;
using Snowlight.Game.Pathfinding;
using Snowlight.Game.Misc;
using Snowlight.Game.Pets;
using Snowlight.Util;

namespace Snowlight.Game.Bots.Behavior
{
    public enum PetBotAction
    {
        Idle = 0,
        Roaming = 1,
        Sleeping = 2,
        Drinking = 3,
        Eating = 4,
        PerformingTrick = 5
    }

    public class PetBot : IBotBehavior
    {
        private Bot mSelfBot;
        private RoomActor mSelfActor;
        private PetBotAction mCurrentAction;
        private double mActionStartedTimestamp;
        private int mActionData;
        private double mGstTimestamp;
        private List<string> mPossibleTricks;
        private double mChatDelayer;

        public override void Initialize(Bot Bot)
        {
            mSelfBot = Bot;
            mCurrentAction = PetBotAction.Idle;
            mActionStartedTimestamp = UnixTimestamp.GetCurrent();
            mPossibleTricks = PetDataManager.GetTricksForType(Bot.PetData.Type);
        }

        private void RespondToEvent(string Event)
        {
            BotResponse Response = mSelfBot.GetResponseForMessage(Event);

            if (Response != null)
            {
                mSelfActor.Chat(Response.GetResponse());
            }

            mChatDelayer = UnixTimestamp.GetCurrent();
        }

        public override void OnSelfEnterRoom(RoomInstance Instance)
        {
            mSelfActor = Instance.GetActorByReferenceId(mSelfBot.Id, RoomActorType.AiBot);

            if (mSelfActor == null)
            {
                return;
            }

            mCurrentAction = PetBotAction.Idle;
            mActionStartedTimestamp = UnixTimestamp.GetCurrent();
            mGstTimestamp = UnixTimestamp.GetCurrent();

            RespondToEvent("SEE_OWNER");
        }

        public override void OnSelfLeaveRoom(RoomInstance Instance)
        {
            if (mSelfActor == null)
            {
                return;
            }

            //mSelfActor.Chat("*leaves*", false);
            mSelfActor = null;
        }

        public override void OnUserChat(RoomInstance Instance, RoomActor Actor, string MessageText, bool Shout)
        {
            string Message = MessageText.ToLower().Trim();
            string PetName = mSelfBot.PetData.Name.ToLower();

            if (mSelfActor == null || mSelfBot.PetData.OwnerId != Actor.ReferenceId || Actor.Type !=
                RoomActorType.UserCharacter || !Message.StartsWith(PetName + " ") || Message.Length <= PetName.Length)
            {
                return;
            }

            if (mSelfBot.PetData.Energy < 20)
            {
                mSelfActor.SetStatus("gst", "hng");
                RespondToEvent("TIRED");
                return;
            }

            if (mSelfBot.PetData.Happiness < 20)
            {
                mSelfActor.SetStatus("gst", "sad");
                RespondToEvent("UNHAPPY");
                return;
            }

            int SkipLength = PetName.Length + 1;
            string Command = MessageText.Substring(SkipLength, MessageText.Length - SkipLength).ToLower().Trim();

            switch (Command)
            {
                case "free":

                    mSelfActor.ClearStatusses();
                    mSelfActor.Chat("All statusses cleared");
                    break;

                default:

                    mSelfActor.SetStatus(Command.ToLower());
                    mSelfActor.Chat("Effect applied: " + Command.ToLower());
                    mSelfActor.UpdateNeeded = true;
                    break;
            }
        }

        public override void OnUserEnter(RoomInstance Instance, RoomActor Actor)
        {
            if (mSelfActor == null || Actor.ReferenceId != mSelfBot.PetData.OwnerId || Actor.Type != RoomActorType.UserCharacter
                || (mCurrentAction != PetBotAction.Idle && mCurrentAction != PetBotAction.Roaming))
            {
                return;
            }

            if (RandomGenerator.GetNext(0, 1) == 1)
            {
                RespondToEvent("SEE_OWNER");
            }
        }

        public override void OnUserLeave(RoomInstance Instance, RoomActor Actor)
        {

        }

        private void ChangeAction(PetBotAction Action)
        {
            mCurrentAction = Action;
            mActionStartedTimestamp = UnixTimestamp.GetCurrent();
            mActionData = 0;
        }

        public override void PerformUpdate(RoomInstance Instance)
        {
            switch (mCurrentAction)
            {
                default:
                case PetBotAction.Idle:

                    double TimeSinceIdle = UnixTimestamp.GetCurrent() - mActionStartedTimestamp;

                    if (RandomGenerator.GetNext(0, 6) == 0)
                    {
                        if (TimeSinceIdle >= 1.5)
                        {
                            switch (RandomGenerator.GetNext(0, 6))
                            {
                                case 0:
                                case 1:

                                    ChangeAction(PetBotAction.Idle);
                                    break;

                                case 2:
                                case 3:
                                case 4:

                                    if (mSelfBot.PetData.Energy < 30 && RandomGenerator.GetNext(0, 5) == 0)
                                    {
                                        ChangeAction(PetBotAction.Sleeping);
                                    }
                                    else
                                    {
                                        ChangeAction(PetBotAction.Roaming);
                                    }

                                    break;

                                case 5:

                                    ChangeAction(mSelfBot.PetData.Energy > 50 && mSelfBot.PetData.Happiness > 65 ?
                                        PetBotAction.PerformingTrick : PetBotAction.Idle);
                                    break;

                                case 6:

                                    mSelfActor.BodyRotation = RandomGenerator.GetNext(0, 8);
                                    mSelfActor.HeadRotation = mSelfActor.BodyRotation;
                                    mSelfActor.UpdateNeeded = true;
                                    break;
                            }
                        }

                        if (RandomGenerator.GetNext(0, 10) == 0)
                        {
                            double TimeSinceLastMessage = (UnixTimestamp.GetCurrent() - mChatDelayer);

                            if (TimeSinceLastMessage >= 60)
                            {
                                string RandomMsg = BotManager.GetRandomSpeechForBotDefinition(mSelfBot.DefinitionId);

                                if (RandomMsg.Length > 0)
                                {
                                    mSelfActor.Chat(RandomMsg);
                                }
                            }

                            mChatDelayer = UnixTimestamp.GetCurrent();
                        }
                    }

                    break;

                case PetBotAction.Roaming:

                    if (mActionData == 0)
                    {
                        Vector2 Target = new Vector2(RandomGenerator.GetNext(0, Instance.Model.Heightmap.SizeX),
                            RandomGenerator.GetNext(0, Instance.Model.Heightmap.SizeY));

                        if (Target.X != Instance.Model.DoorPosition.X || Target.Y != Instance.Model.DoorPosition.Y)
                        {
                            mSelfActor.MoveTo(Target);
                        }

                        mActionData = 1;
                    }
                    else if (!mSelfActor.IsMoving)
                    {
                        ChangeAction(PetBotAction.Idle);
                    }

                    break;

                case PetBotAction.PerformingTrick:

                    if (mActionData == 0)
                    {
                        mSelfActor.SetStatus(mPossibleTricks[RandomGenerator.GetNext(0, mPossibleTricks.Count - 1)]);
                        mSelfActor.UpdateNeeded = true;

                        mActionData = RandomGenerator.GetNext(4, 20);
                    }
                    else
                    {
                        mActionData--;

                        if (mActionData == 0)
                        {
                            mSelfActor.ClearStatusses();
                            ChangeAction(PetBotAction.Idle);
                        }
                    }

                    break;
            }
        }
    }
}
