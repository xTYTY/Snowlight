using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Text;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Storage;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Characters;
using Snowlight.Util;
using Snowlight.Game.Rooms;
using Snowlight.Game.Achievements;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Messenger
{
    public static class MessengerHandler
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_INIT, new ProcessRequestCallback(OnMessengerInit));
            // com.sulake.habbo.communication.messages.outgoing.friendlist.GetBuddyRequestsMessageComposer;
            // get buddy requests packet this is used for the messenger so it needs to be implemented properly
            DataRouter.RegisterHandler(233, new ProcessRequestCallback(OnGetPendingBuddyRequests));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_SEARCH, new ProcessRequestCallback(OnMessengerSearch));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_SEND_IM, new ProcessRequestCallback(OnSendIm));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_FRIEND_REQUEST, new ProcessRequestCallback(OnFriendRequest));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_FRIEND_ACCEPT, new ProcessRequestCallback(OnFriendRequestAccept));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_FRIEND_DECLINE, new ProcessRequestCallback(OnFriendRequestDecline));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_REMOVE_BUDDY, new ProcessRequestCallback(OnFriendRemove));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_UPDATE, new ProcessRequestCallback(OnMessengerUpdate));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_FOLLOW_BUDDY, new ProcessRequestCallback(OnFollowBuddy));
            DataRouter.RegisterHandler(OpcodesIn.MESSENGER_SEND_IM_INVITE, new ProcessRequestCallback(OnInvite));

            // new friends stream, needs to be coded & added to Opcodes
            DataRouter.RegisterHandler(500, new ProcessRequestCallback(GetEventStream));
            DataRouter.RegisterHandler(501, new ProcessRequestCallback(GetEventStreamAllowed));
        }

        public static void ForceMessengerUpdateForSession(Session SessionToUpdate)
        {
            SessionToUpdate.SendData(SessionToUpdate.MessengerFriendCache.ComposeUpdateList());
        }

        public static void MarkUpdateNeeded(Session UpdatedSession, int Mode, bool ForceInstant)
        {
            ReadOnlyCollection<uint> Friends = UpdatedSession.MessengerFriendCache.Friends;

            if (Friends == null)
            {
                return;
            }

            foreach (uint FriendId in Friends)
            {
                Session TargetSession = SessionManager.GetSessionByCharacterId(FriendId);

                if (TargetSession == null)
                {
                    continue;
                }

                TargetSession.MessengerFriendCache.MarkUpdateNeeded(UpdatedSession.CharacterId, Mode);
                ForceMessengerUpdateForSession(TargetSession);
            }        
        }

        public static bool DestroyFriendship(SqlDatabaseClient MySqlClient, uint UserId1, uint UserId2)
        {
            int aff = 0;

            for (int i = 0; i < 2; i++)
            {
                MySqlClient.SetParameter("user1", (i == 1 ? UserId1 : UserId2));
                MySqlClient.SetParameter("user2", (i == 1 ? UserId2 : UserId1));
                aff += MySqlClient.ExecuteNonQuery("DELETE FROM messenger_friendships WHERE user_1_id = @user1 AND user_2_id = @user2 LIMIT 1");
            }           

            return (aff > 0);
        }

        public static bool FriendshipExists(SqlDatabaseClient MySqlClient, uint UserId1, uint UserId2, bool ConfirmedOnly)
        {
            MySqlClient.SetParameter("user1", UserId1);
            MySqlClient.SetParameter("user2", UserId2);
            MySqlClient.SetParameter("confirmed", (ConfirmedOnly ? 0 : 2));

            return (MySqlClient.ExecuteQueryRow("SELECT null FROM messenger_friendships WHERE user_1_id = @user1 AND user_2_id = @user2 AND confirmed != @confirmed OR user_2_id = @user1 AND user_1_id = @user2 AND confirmed != @confirmed LIMIT 1") != null);
        }

        public static void CreateFriendship(SqlDatabaseClient MySqlClient, uint UserId1, uint UserId2, bool Confirmed)
        {
            for (int i = 0; i < (Confirmed ? 2 : 1); i++)
            {
                MySqlClient.SetParameter("user1", (i == 1 ? UserId1 : UserId2));
                MySqlClient.SetParameter("user2", (i == 1 ? UserId2 : UserId1));
                MySqlClient.SetParameter("accepted", (int)(Confirmed ? 1 : 0));
                MySqlClient.ExecuteNonQuery("INSERT INTO messenger_friendships (user_1_id,user_2_id,confirmed) VALUES (@user1,@user2,@accepted)");
            }
        }

        public static List<uint> GetFriendsForUser(SqlDatabaseClient MySqlClient, uint UserId, int Confirmed)
        {
            List<uint> Friends = new List<uint>();

            MySqlClient.SetParameter("id", UserId);
            MySqlClient.SetParameter("confirmed", Confirmed);
            DataTable Table = MySqlClient.ExecuteQueryTable("SELECT user_2_id FROM messenger_friendships WHERE user_1_id = @id AND confirmed = @confirmed");

            foreach (DataRow Row in Table.Rows)
            {
                Friends.Add((uint)Row[0]);
            }

            return Friends;
        }

        #region Handlers
        private static void OnMessengerInit(Session Session, ClientMessage Message)
        {
            ReadOnlyCollection<uint> Friends = Session.MessengerFriendCache.Friends;
            Session.SendData(MessengerFriendListComposer.Compose(Friends));
        }

        private static void OnGetPendingBuddyRequests(Session Session, ClientMessage Message)
        {
            List<uint> Requests = new List<uint>(); // todo: move requests to cache as well?

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Requests = GetFriendsForUser(MySqlClient, Session.CharacterId, 0);
            }

            if (Requests.Count > 0)
            {
                Session.SendData(MessengerRequestListComposer.Compose(Requests));
            }
        }

        private static void OnMessengerSearch(Session Session, ClientMessage Message)
        {
            string SearchQuery = UserInputFilter.FilterString(Message.PopString().Replace('%', ' '));

            if (SearchQuery.Length < 1)
            {
                return;
            }

            List<CharacterInfo> Results = new List<CharacterInfo>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("query", SearchQuery + "%");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT id FROM characters WHERE username LIKE @query LIMIT 50");

                foreach (DataRow Row in Table.Rows)
                {
                    Results.Add(CharacterInfoLoader.GetCharacterInfo(MySqlClient, (uint)Row["id"]));
                }
            }

            ReadOnlyCollection<uint> CurrentFriends = Session.MessengerFriendCache.Friends;
            List<CharacterInfo> Friends = new List<CharacterInfo>();
            List<CharacterInfo> NonFriends = new List<CharacterInfo>();

            foreach (CharacterInfo Info in Results)
            {
                if (CurrentFriends.Contains(Info.Id))
                {
                    Friends.Add(Info);
                    continue;
                }

                NonFriends.Add(Info);
            }         

            Session.SendData(MessengerSearchResultsComposer.Compose(Friends, NonFriends));
        }

        private static void OnSendIm(Session Session, ClientMessage Message)
        {
            uint UserId = Message.PopWiredUInt32();
            string Text = UserInputFilter.FilterString(Message.PopString()).Trim();

            if (UserId <= 0 || Text.Length < 1)
            {
                return;
            }

            if (Session.CharacterInfo.IsMuted)
            {
                Session.SendData(MessengerImErrorComposer.Compose(4, UserId));
                return;
            }

            if (!Session.MessengerFriendCache.Friends.Contains(UserId))
            {
                Session.SendData(MessengerImErrorComposer.Compose(6, UserId));
                return;
            }

            Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

            if (TargetSession == null)
            {
                Session.SendData(MessengerImErrorComposer.Compose(5, UserId));
                return;
            }

            if (TargetSession.CharacterInfo.IsMuted)
            {
                Session.SendData(MessengerImErrorComposer.Compose(3, UserId));
                return;
            }

            TargetSession.SendData(MessengerImMessageComposer.Compose(Session.CharacterId, Text));
        }

        private static void OnFriendRequest(Session Session, ClientMessage Message)
        {
            string RequestName = UserInputFilter.FilterString(Message.PopString());
            uint TargetId = CharacterResolverCache.GetUidFromName(RequestName);

            if (TargetId < 1 || TargetId == Session.CharacterId)
            {
                return;
            }

            CharacterInfo TargetUserInfo = null;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                TargetUserInfo = CharacterInfoLoader.GetCharacterInfo(MySqlClient, TargetId);

                if (!TargetUserInfo.PrivacyAcceptFriends)
                {
                    Session.SendData(MessengerErrorEvent.Compose(39, 3));
                    return;
                }

                if (FriendshipExists(MySqlClient, Session.CharacterId, TargetUserInfo.Id, false))
                {
                    return;
                }

                CreateFriendship(MySqlClient, Session.CharacterId, TargetUserInfo.Id, false);
            }

            Session NotifySession = SessionManager.GetSessionByCharacterId(TargetUserInfo.Id);

            if (NotifySession != null)
            {
                NotifySession.SendData(MessengerRequestNoficiationComposer.Compose(Session.CharacterId, Session.CharacterInfo.Username));
            }

            QuestManager.ProgressUserQuest(Session, QuestType.SOCIAL_FRIEND);
        }

        private static void OnFriendRequestAccept(Session Session, ClientMessage Message)
        {
            int Amount = Message.PopWiredInt32();

            // Precaution: limit queries to 50.
            if (Amount > 50)
            {
                Amount = 50;
            }

            List<Session> SessionsToUpdate = new List<Session>() { Session };

            for (int i = 0; i < Amount; i++)
            {
                uint RequestId = Message.PopWiredUInt32();

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("user1", Session.CharacterId);
                    MySqlClient.SetParameter("user2", RequestId);
                    MySqlClient.SetParameter("confirmed", 1);
                    int Affected = MySqlClient.ExecuteNonQuery("UPDATE messenger_friendships SET confirmed = @confirmed WHERE user_1_id = @user1 AND user_2_id = @user2 LIMIT 1");

                    if (Affected > 0)
                    {
                        MySqlClient.SetParameter("user1", RequestId);
                        MySqlClient.SetParameter("user2", Session.CharacterId);
                        MySqlClient.SetParameter("confirmed", 1);
                        MySqlClient.ExecuteNonQuery("INSERT INTO messenger_friendships (user_1_id,user_2_id,confirmed) VALUES (@user1,@user2,@confirmed)");

                        Session.MessengerFriendCache.AddToCache(RequestId);

                        Session TargetSession = SessionManager.GetSessionByCharacterId(RequestId);

                        if (TargetSession != null)
                        {
                            TargetSession.MessengerFriendCache.AddToCache(Session.CharacterId);
                            SessionsToUpdate.Add(TargetSession);
                        }
                    }
                }
            }

            for (int i = 0; i < 2; i++)
            {
                foreach (Session SessionToUpdate in SessionsToUpdate)
                {
                    ForceMessengerUpdateForSession(SessionToUpdate);
                }
            }
        }

        private static void OnFriendRequestDecline(Session Session, ClientMessage Message)
        {
            bool HandleAll = Message.PopWiredBoolean();
            int Amount = Message.PopWiredInt32();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                if (HandleAll)
                {
                    MySqlClient.SetParameter("userid", Session.CharacterId);
                    MySqlClient.SetParameter("confirmed", 0);
                    MySqlClient.SetParameter("amount", Amount);
                    MySqlClient.ExecuteNonQuery("DELETE FROM messenger_friendships WHERE user_1_id = @userid AND confirmed = @confirmed");
                }
                else
                {
                    // Precaution: limit queries to 50
                    if (Amount > 50)
                    {
                        Amount = 50;
                    }

                    for (int i = 0; i < Amount; i++)
                    {
                        uint RequestId = Message.PopWiredUInt32();
                        DestroyFriendship(MySqlClient, Session.CharacterId, RequestId);
                    }
                }
            }
        }

        private static void OnFriendRemove(Session Session, ClientMessage Message)
        {
            int Amount = Message.PopWiredInt32();

            // Precaution: limit queries to 50
            if (Amount > 50)
            {
                Amount = 50;
            }

            List<MessengerUpdate> LocalUpdates = new List<MessengerUpdate>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                for (int i = 0; i < Amount; i++)
                {
                    uint FriendId = Message.PopWiredUInt32();

                    if (DestroyFriendship(MySqlClient, Session.CharacterId, FriendId))
                    {
                        Session.MessengerFriendCache.RemoveFromCache(FriendId);
                        LocalUpdates.Add(new MessengerUpdate(-1, CharacterInfoLoader.GenerateNullCharacter(FriendId)));

                        Session TargetSession = SessionManager.GetSessionByCharacterId(FriendId); ;

                        if (TargetSession != null)
                        {
                            TargetSession.MessengerFriendCache.RemoveFromCache(Session.CharacterId);
                            TargetSession.SendData(MessengerUpdateListComposer.Compose(new List<MessengerUpdate>() { new MessengerUpdate(-1, CharacterInfoLoader.GenerateNullCharacter(Session.CharacterId)) }));
                        }
                    }
                }
            }

            Session.SendData(MessengerUpdateListComposer.Compose(LocalUpdates));
        }

        private static void OnMessengerUpdate(Session Session, ClientMessage Message)
        {
            ForceMessengerUpdateForSession(Session);
        }

        private static void OnFollowBuddy(Session Session, ClientMessage Message)
        {
            uint BuddyId = Message.PopWiredUInt32();

            if (!Session.MessengerFriendCache.Friends.Contains(BuddyId))
            {
                return;
            }

            Session BuddySession = SessionManager.GetSessionByCharacterId(BuddyId);

            if (BuddySession == null || !BuddySession.InRoom)
            {
                return;
            }

            RoomInfo Info = RoomInfoLoader.GetRoomInfo(BuddySession.CurrentRoomId);

            if (Info != null)
            {
                Session.SendData(MessengerFollowResultComposer.Compose(Info));
            }
        }

        private static void OnInvite(Session Session, ClientMessage Message)
        {
            int Count = Message.PopWiredInt32();
            List<uint> Targets = new List<uint>();

            for (int i = 0; (i < Count && i < 50); i++)
            {
                Targets.Add(Message.PopWiredUInt32());
            }

            string MessageText = UserInputFilter.FilterString(Message.PopString());

            if (MessageText.Length > 121)
            {
                MessageText = MessageText.Substring(0, 121);
            }

            foreach (uint UserId in Targets)
            {
                if (!Session.MessengerFriendCache.Friends.Contains(UserId))
                {
                    continue;
                }

                Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

                if (TargetSession == null)
                {
                    continue;
                }

                TargetSession.SendData(MessengerImInviteComposer.Compose(Session.CharacterId, MessageText));
            }
        }

        private static void GetEventStream(Session Session, ClientMessage Message)
        {
            // TODO: Code this here..
        }

        private static void GetEventStreamAllowed(Session Session, ClientMessage Message)
        {
            // TODO: Code this here...
        }
        #endregion
    }
}
