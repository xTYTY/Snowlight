using System;
using System.Collections.Generic;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Items;
using Snowlight.Specialized;
using Snowlight.Game.Bots;
using Snowlight.Storage;
using System.Collections.ObjectModel;

using Snowlight.Game.Rooms.Trading;
using Snowlight.Config;

namespace Snowlight.Game.Rooms
{
    public partial class RoomInstance : IDisposable
    {
        private object mActorSyncRoot;
        private Dictionary<uint, RoomActor> mActors;
        private uint mActorIdGenerator;
        private object mActorIdGeneratorSyncLock;
        private bool mActorCountSyncNeeded;
        private int mCachedNavigatorUserCount;
        private List<uint> mUsersWithRights;
        private Dictionary<uint, double> mBannedUsers;
        private int mPetCount;

        public int ActorCount
        {
            get
            {
                return mActors.Count;
            }
        }

        public int HumanActorCount
        {
            get
            {
                int c = 0;

                lock (mActors)
                {
                    foreach (RoomActor Actor in mActors.Values)
                    {
                        if (Actor.IsBot)
                        {
                            continue;
                        }

                        c++;
                    }
                }

                return c;
            }
        }

        public ReadOnlyCollection<uint> UsersWithRights
        {
            get
            {
                lock (mUsersWithRights)
                {
                    List<uint> Copy = new List<uint>();
                    Copy.AddRange(mUsersWithRights);
                    return Copy.AsReadOnly();
                }
            }
        }

        public int CachedNavigatorUserCount
        {
            get
            {
                return mCachedNavigatorUserCount;
            }
        }

        public ReadOnlyCollection<RoomActor> Actors
        {
            get
            {
                lock (mActors)
                {
                    List<RoomActor> Copy = new List<RoomActor>();

                    foreach (RoomActor Actor in mActors.Values)
                    {
                        Copy.Add(Actor);
                    }

                    return Copy.AsReadOnly();
                }
            }
        }

        public bool ActorCountDatabaseWritebackNeeded
        {
            get
            {
                return mActorCountSyncNeeded;
            }

            set
            {
                mActorCountSyncNeeded = value;
            }
        }

        private uint GenerateActorId()
        {
            lock (mActorIdGeneratorSyncLock)
            {
                if (mActorIdGenerator >= uint.MaxValue)
                {
                    return 0;
                }

                return mActorIdGenerator++;
            }
        }

        public bool AddUserToRoom(Session Session)
        {
            if (Session.AbsoluteRoomId != RoomId || !Session.Authenticated)
            {
                return false;
            }

            uint ActorId = GenerateActorId();

            if (ActorId == 0)
            {
                return false;
            }

            Vector3 StartPosition = new Vector3(Model.DoorPosition.X, Model.DoorPosition.Y, Model.DoorPosition.Z);
            int StartRotation = Model.DoorRotation;

            RoomActor NewActor = RoomActor.TryCreateActor(ActorId, RoomActorType.UserCharacter, Session.CharacterId,
                Session.CharacterInfo, StartPosition, StartRotation, this);

            Item TargetTeleporter = null;

            if (Session.IsTeleporting)
            {
                TargetTeleporter = GetItem(Session.TargetTeleporterId);

                if (TargetTeleporter != null && !TargetTeleporter.TemporaryInteractionReferenceIds.ContainsKey(2))
                {
                    NewActor.Position = new Vector3(TargetTeleporter.RoomPosition.X, TargetTeleporter.RoomPosition.Y,
                        TargetTeleporter.RoomPosition.Z);
                    NewActor.HeadRotation = TargetTeleporter.RoomRotation;
                    NewActor.BodyRotation = TargetTeleporter.RoomRotation;
                    NewActor.UpdateNeeded = true;

                    TargetTeleporter.TemporaryInteractionReferenceIds.Add(2, NewActor.Id);
                    TargetTeleporter.DisplayFlags = "2";
                    TargetTeleporter.RequestUpdate(3);
                }

                Session.TargetTeleporterId = 0;
                Session.IsTeleporting = false;
            }

            if (NewActor == null)
            {
                return false;
            }

            AddActorToRoom(NewActor);

            if (TargetTeleporter != null)
            {
                TargetTeleporter.BroadcastStateUpdate(this);
            }

            if (CheckUserRights(Session, true))
            {
                NewActor.SetStatus("flatctrl", "useradmin");
                Session.SendData(RoomOwnerRightsComposer.Compose());
                Session.SendData(RoomRightsComposer.Compose());
            }
            else if (CheckUserRights(Session))
            {
                NewActor.SetStatus("flatctrl");
                Session.SendData(RoomRightsComposer.Compose());
            }

            if (Session.CurrentEffect > 0)
            {
                NewActor.ApplyEffect(Session.CurrentEffect);
            }

            NewActor.UpdateNeeded = true;
            return true;
        }

        private bool AddActorToRoom(RoomActor Actor)
        {
            lock (mActorSyncRoot)
            {
                if (mActors.ContainsKey(Actor.Id))
                {
                    return false;
                }

                mActors.Add(Actor.Id, Actor);
                BroadcastMessage(RoomUserObjectListComposer.Compose(new List<RoomActor>() { Actor }));
                MarkActorCountSyncNeeded();

                foreach (RoomActor _Actor in mActors.Values)
                {
                    if (_Actor.Type == RoomActorType.AiBot)
                    {
                        if (_Actor.Id == Actor.Id)
                        {
                            ((Bot)_Actor.ReferenceObject).Brain.OnSelfEnterRoom(this);
                        }
                        else
                        {
                            ((Bot)_Actor.ReferenceObject).Brain.OnUserEnter(this, Actor);
                        }
                    }
                }

                return true;
            }
        }

        public void DoActorCountSync()
        {
            int NewActorCount = HumanActorCount;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("id", RoomId);
                MySqlClient.SetParameter("usercount", NewActorCount);
                MySqlClient.ExecuteNonQuery("UPDATE rooms SET current_users = @usercount WHERE id = @id LIMIT 1");
            }

            mCachedNavigatorUserCount = NewActorCount;
            mActorCountSyncNeeded = false;
        }

        public void MarkActorCountSyncNeeded()
        {
            mActorCountSyncNeeded = true;
        }

        public void BanUser(uint UserId)
        {
            lock (mActorSyncRoot)
            {
                RoomActor Actor = GetActorByReferenceId(UserId);

                if (Actor == null || Actor.Type != RoomActorType.UserCharacter)
                {
                    return;
                }

                Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                if (ActorSession != null)
                {
                    if (CheckUserRights(ActorSession, true))
                    {
                        return; // this is the room owner or a moderator, no banning allowed on this guy!
                    }
                }

                double Timestamp = UnixTimestamp.GetCurrent();

                if (mBannedUsers.ContainsKey(UserId))
                {
                    mBannedUsers[UserId] = Timestamp;
                    return;
                }

                mBannedUsers.Add(UserId, Timestamp);
            }

            SoftKickUser(UserId, true);
        }

        public void SoftKickUser(uint UserId, bool Forced = false, bool NotifyUser = false, bool OverrideOwner = false)
        {
            RoomActor Actor = GetActorByReferenceId(UserId);

            if (Actor == null || Actor.Type != RoomActorType.UserCharacter)
            {
                return;
            }

            Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

            if (ActorSession != null)
            {
                if (!OverrideOwner && CheckUserRights(ActorSession, true))
                {
                    return; // this is the room owner or a moderator, no kicking allowed!
                }

                if (NotifyUser)
                {
                    ActorSession.SendData(GenericErrorComposer.Compose(4008));
                }
            }

            Actor.LeaveRoom(Forced);
        }

        public void HardKickUser(uint UserId)
        {
            RoomActor Actor = GetActorByReferenceId(UserId);

            if (Actor == null || Actor.Type != RoomActorType.UserCharacter)
            {
                return;
            }

            Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

            RoomManager.RemoveUserFromRoom(ActorSession, true);
            RemoveCharacterFromRoom(UserId);
        }

        public bool IsUserBanned(uint UserId)
        {
            lock (mActorSyncRoot)
            {
                if (!mBannedUsers.ContainsKey(UserId))
                {
                    return false;
                }

                double TimeBanned = UnixTimestamp.GetCurrent() - mBannedUsers[UserId];

                if (TimeBanned >= 900)
                {
                    mBannedUsers.Remove(UserId);
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Removes a human character from the room instance. DO NOT CALL DIRECTLY (only from RoomManager).
        /// </summary>
        /// <param name="CharacterId">Id of the character to remove.</param>
        /// <returns>Boolean based on success of removal.</returns>
        public bool RemoveCharacterFromRoom(uint CharacterId)
        {
            uint ActorId = 0;

            lock (mActorSyncRoot)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    if (Actor.Type == RoomActorType.UserCharacter && Actor.ReferenceId == CharacterId)
                    {
                        ActorId = Actor.Id;
                        break;
                    }
                }
            }

            if (ActorId > 0)
            {
                return RemoveActorFromRoom(ActorId);
            }

            return false;
        }

        /// <summary>
        /// Removes an actor from the room instance. DO NOT CALL DIRECTLY FOR HUMAN CHARACTERS.
        /// </summary>
        /// <param name="ActorId">Id of the actor to remove.</param>
        /// <returns>Boolean based on success of removal.</returns>
        public bool RemoveActorFromRoom(uint ActorId)
        {
            bool Success = false;

            lock (mActorSyncRoot)
            {
                RoomActor Actor = GetActor(ActorId);

                if (Actor == null)
                {
                    return false;
                }

                if (Actor.Type == RoomActorType.UserCharacter)
                {
                    if (Actor.ReferenceId == Info.OwnerId && HasOngoingEvent)
                    {
                        StopEvent();
                    }

                    Trade Trade = TradeManager.GetTradeForUser(Actor.ReferenceId);

                    if (Trade != null)
                    {
                        TradeManager.StopTradeForUser(Trade.UserOne);
                        TradeManager.StopTradeForUser(Trade.UserTwo);

                        Session TargetSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId ==
                            Trade.UserOne ? Trade.UserTwo : Trade.UserOne);

                        if (TargetSession != null)
                        {
                            TargetSession.SendData(TradeAbortedComposer.Compose(Actor.ReferenceId));

                            RoomActor TargetActor = GetActorByReferenceId(TargetSession.CharacterId);

                            if (TargetActor != null)
                            {
                                TargetActor.RemoveStatus("trd");
                                TargetActor.UpdateNeeded = true;
                            }
                        }
                    }
                }

                foreach (RoomActor _Actor in mActors.Values)
                {
                    if (_Actor.Type == RoomActorType.AiBot)
                    {
                        if (_Actor.Id == Actor.Id)
                        {
                            Bot SelfBot = ((Bot)_Actor.ReferenceObject);
                            SelfBot.Brain.OnSelfLeaveRoom(this);

                            if (SelfBot.IsPet)
                            {
                                mPetCount--;
                            }
                        }
                        else
                        {
                            ((Bot)_Actor.ReferenceObject).Brain.OnUserLeave(this, Actor);
                        }
                    }
                }

                Success = mActors.Remove(ActorId);

                if (Success)
                {
                    BroadcastMessage(RoomUserRemovedComposer.Compose(ActorId));
                    MarkActorCountSyncNeeded();
                }
            }

            return Success;
        }

        public RoomActor GetActor(uint ActorId)
        {
            lock (mActors)
            {
                if (mActors.ContainsKey(ActorId))
                {
                    return mActors[ActorId];
                }
            }

            return null;
        }

        public RoomActor GetActorByReferenceId(uint ReferenceId, RoomActorType ReferenceType = RoomActorType.UserCharacter)
        {
            lock (mActors)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    if (Actor.Type == ReferenceType && Actor.ReferenceId == ReferenceId)
                    {
                        return Actor;
                    }
                }
            }

            return null;
        }

        public bool AddBotToRoom(Bot Bot)
        {
            uint ActorId = GenerateActorId();

            RoomActor BotActor = RoomActor.TryCreateActor(ActorId, RoomActorType.AiBot, Bot.Id, Bot,
                new Vector3(Bot.InitialPosition.X, Bot.InitialPosition.Y, Bot.InitialPosition.Z), 2, this);
            Bot.Brain.Initialize(Bot);

            if (BotActor != null)
            {
                AddActorToRoom(BotActor);

                if (Bot.IsPet)
                {
                    mPetCount++;
                }

                return true;
            }

            return false;
        }

        public void KickBot(uint ActorId)
        {
            RoomActor Actor = GetActor(ActorId);

            if (Actor == null || Actor.Type != RoomActorType.AiBot)
            {
                return;
            }

            Bot Bot = (Bot)Actor.ReferenceObject;

            if (Bot == null || !Bot.Kickable)
            {
                return;
            }

            RemoveActorFromRoom(ActorId);
        }

        public bool CanPlacePet(bool IsOwner)
        {
            if (mPetCount >= (int)ConfigManager.GetValue("rooms.limit.pets"))
            {
                return false;
            }

            return mInfo.AllowPets || IsOwner;
        }
    }
}
