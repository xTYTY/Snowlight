using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Bots;

namespace Snowlight.Game.Rooms
{
    public partial class RoomInstance : IDisposable
    {
        public void BroadcastChatMessage(RoomActor Actor, string MessageText, bool Shout, int EmotionId)
        {
            lock (mActorSyncRoot)
            {
                foreach (RoomActor _Actor in mActors.Values)
                {
                    ServerMessage Message = RoomChatComposer.Compose(Actor.Id, MessageText, EmotionId, Shout ? ChatType.Shout
                        : ChatType.Say);

                    if (_Actor.Type == RoomActorType.UserCharacter)
                    {
                        Session ActorSession = SessionManager.GetSessionByCharacterId(_Actor.ReferenceId);

                        if (ActorSession == null || (Actor.Type == RoomActorType.UserCharacter && ActorSession.IgnoreCache.UserIsIgnored(Actor.ReferenceId)))
                        {
                            continue;
                        }

                        ActorSession.SendData(Message);
                    }
                }

                foreach (RoomActor _Actor in mActors.Values)
                {
                    if (_Actor.Type == RoomActorType.AiBot)
                    {
                        if (Actor.Id == _Actor.Id)
                        {
                            continue;
                        }

                        ((Bot)_Actor.ReferenceObject).Brain.OnUserChat(this, Actor, MessageText, Shout);
                    }
                }
            }
        }

        public void BroadcastMessage(ServerMessage Message, bool UsersWithRightsOnly = false)
        {
            lock (mActors)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    if (Actor.Type == RoomActorType.UserCharacter)
                    {
                        Session Session = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                        if (Session == null || (UsersWithRightsOnly && !CheckUserRights(Session)))
                        {
                            continue;
                        }

                        Session.SendData(Message);
                    }
                }
            }
        }

        public void BroadcastEventData()
        {
            BroadcastMessage(RoomEventInfoComposer.Compose(mEvent));
        }

        public void SendObjects(Session Session)
        {
            Session.SendData(RoomItemHeightmapComposer.Compose(Model.Heightmap.ToString()));
            Session.SendData(RoomRelativeHeightmapComposer.Compose(RelativeHeightmap));

            List<RoomActor> ActorObjects = new List<RoomActor>();

            Dictionary<uint, int> DancingActors = new Dictionary<uint, int>();
            Dictionary<uint, int> CarryingActors = new Dictionary<uint, int>();
            Dictionary<uint, int> EffectActors = new Dictionary<uint, int>();
            List<uint> SleepingActors = new List<uint>();

            lock (mActorSyncRoot)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    ActorObjects.Add(Actor);

                    if (Actor.DanceId > 0)
                    {
                        DancingActors.Add(Actor.Id, Actor.DanceId);
                    }

                    if (Actor.CarryItemId > 0)
                    {
                        CarryingActors.Add(Actor.Id, Actor.CarryItemId);
                    }

                    if (Actor.AvatarEffectId > 0)
                    {
                        EffectActors.Add(Actor.Id, Actor.AvatarEffectId);
                    }

                    if (Actor.IsSleeping)
                    {
                        SleepingActors.Add(Actor.Id);
                    }
                }
            }

            Session.SendData(RoomUserObjectListComposer.Compose(ActorObjects));
            Session.SendData(RoomStaticObjectsComposer.Compose(mStaticObjects));
            Session.SendData(RoomFloorObjectsComposer.Compose(GetFloorItems()));
            Session.SendData(RoomWallObjectsComposer.Compose(GetWallItems()));
            Session.SendData(RoomUserStatusListComposer.Compose(ActorObjects));

            foreach (KeyValuePair<uint, int> DancingActor in DancingActors)
            {
                Session.SendData(RoomUserDanceComposer.Compose(DancingActor.Key, DancingActor.Value));
            }

            foreach (KeyValuePair<uint, int> CarryingActor in CarryingActors)
            {
                Session.SendData(RoomUserCarryComposer.Compose(CarryingActor.Key, CarryingActor.Value));
            }

            foreach (KeyValuePair<uint, int> EffectActor in EffectActors)
            {
                Session.SendData(RoomUserEffectComposer.Compose(EffectActor.Key, EffectActor.Value));
            }

            foreach (uint SleepingActor in SleepingActors)
            {
                Session.SendData(RoomUserSleepComposer.Compose(SleepingActor, true));
            }
        }
    }
}
