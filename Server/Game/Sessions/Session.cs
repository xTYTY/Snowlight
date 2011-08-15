using System;
using System.Linq;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Reflection;


using Snowlight.Util;
using Snowlight.Communication;
using Snowlight.Game.Misc;
using Snowlight.Game.Characters;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Moderation;
using Snowlight.Storage;
using Snowlight.Game.Messenger;
using Snowlight.Game.Navigation;
using Snowlight.Game.Rooms;
using Snowlight.Game.Items;
using Snowlight.Game.AvatarEffects;
using Snowlight.Game.Achievements;
using Snowlight.Game.Rights;
using System.Data;
using Snowlight.Communication.Incoming;
using Snowlight.Config;

namespace Snowlight.Game.Sessions
{
    public class Session : IDisposable
    {
        private uint mId;
        private Socket mSocket;
        private byte[] mBuffer;

        private CharacterInfo mCharacterInfo;

        private bool mPongOk;
        private double mStoppedTimestamp;
        private bool mAuthProcessed;

        private SessionMessengerFriendCache mMessengerFriendCache;
        private FavoriteRoomsCache mFavoriteRoomsCache;
        private RatedRoomsCache mRatedRoomsCache;
        private InventoryCache mInventoryCache;
        private UserIgnoreCache mIgnoreCache;
        private NewItemsCache mNewItemsCache;
        private AvatarEffectCache mAvatarEffectCache;
        private AchievementCache mAchieventCache;
        private BadgeCache mBadgeCache;
        private ClubSubscription mSubscriptionManager;
        private QuestCache mQuestCache;
        private PetInventoryCache mPetCache;

        private uint mRoomId;
        private bool mRoomAuthed;
        private bool mRoomJoined;

        private string mUserAgent;

        private bool mIsTeleporting;
        private uint mTargetTeleporterId;

        private int mCurrentEffect;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public uint CharacterId
        {
            get
            {
                return (mCharacterInfo != null ? mCharacterInfo.Id : 0);
            }
        }

        public string RemoteAddress
        {
            get
            {
                return ((mSocket != null && mSocket.Connected ?
                    mSocket.RemoteEndPoint.ToString().Split(':')[0] : string.Empty));
            }
        }

        public double TimeStopped
        {
            get
            {
                return (UnixTimestamp.GetCurrent() - mStoppedTimestamp);
            }
        }

        public bool Stopped
        {
            get
            {
                return (mSocket == null);
            }
        }

        public bool Authenticated
        {
            get
            {
                return (mCharacterInfo != null && mAuthProcessed);
            }
        }

        public CharacterInfo CharacterInfo
        {
            get
            {
                return mCharacterInfo;
            }
        }

        public bool LatencyTestOk
        {
            get
            {
                return mPongOk;
            }

            set
            {
                mPongOk = value;
            }
        }

        public SessionMessengerFriendCache MessengerFriendCache
        {
            get
            {
                return mMessengerFriendCache;
            }
        }

        public FavoriteRoomsCache FavoriteRoomsCache
        {
            get
            {
                return mFavoriteRoomsCache;
            }
        }

        public RatedRoomsCache RatedRoomsCache
        {
            get
            {
                return mRatedRoomsCache;
            }
        }

        public InventoryCache InventoryCache
        {
            get
            {
                return mInventoryCache;
            }
        }

        public UserIgnoreCache IgnoreCache
        {
            get
            {
                return mIgnoreCache;
            }
        }

        public NewItemsCache NewItemsCache
        {
            get
            {
                return mNewItemsCache;
            }
        }

        public AvatarEffectCache AvatarEffectCache
        {
            get
            {
                return mAvatarEffectCache;
            }
        }

        public AchievementCache AchievementCache
        {
            get
            {
                return mAchieventCache;
            }
        }

        public BadgeCache BadgeCache
        {
            get
            {
                return mBadgeCache;
            }
        }

        public ClubSubscription SubscriptionManager
        {
            get
            {
                return mSubscriptionManager;
            }
        }

        public QuestCache QuestCache
        {
            get
            {
                return mQuestCache;
            }
        }

        public PetInventoryCache PetInventoryCache
        {
            get
            {
                return mPetCache;
            }
        }

        public bool InRoom
        {
            get
            {
                return (CurrentRoomId > 0);
            }
        }

        public uint CurrentRoomId
        {
            get
            {
                return ((mRoomJoined && mRoomAuthed) ? mRoomId : 0);
            }
        }

        public uint AbsoluteRoomId
        {
            get
            {
                return mRoomId;
            }

            set
            {
                mRoomId = value;
            }
        }

        public bool RoomAuthed
        {
            get
            {
                return mRoomAuthed;
            }

            set
            {
                mRoomAuthed = value;
            }
        }

        public bool RoomJoined
        {
            get
            {
                return mRoomJoined;
            }

            set
            {
                mRoomJoined = value;
            }
        }

        public string UserAgent
        {
            get
            {
                return mUserAgent;
            }

            set
            {
                mUserAgent = value;
            }
        }

        public bool IsTeleporting
        {
            get
            {
                return mIsTeleporting;
            }

            set
            {
                mIsTeleporting = value;
            }
        }

        public uint TargetTeleporterId
        {
            get
            {
                return mTargetTeleporterId;
            }

            set
            {
                mTargetTeleporterId = value;
            }
        }

        public int CurrentEffect
        {
            get
            {
                return mCurrentEffect;
            }

            set
            {
                mCurrentEffect = value;
            }
        }

        public Session(uint Id, Socket Socket)
        {
            mId = Id;
            mSocket = Socket;
            mBuffer = new byte[512];
            mPongOk = true;

            Output.WriteLine("Started client " + Id + ".", OutputLevel.DebugInformation);

            BeginReceive();
        }

        public bool HasRight(string Right)
        {
            return mBadgeCache != null && mBadgeCache.HasRight(Right);
        }

        public void TryAuthenticate(string Ticket, string RemoteAddress)
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                uint AuthedUid = SingleSignOnAuthenticator.TryAuthenticate(MySqlClient, Ticket, RemoteAddress);

                if (AuthedUid <= 0)
                {
                    SessionManager.StopSession(mId);
                    return;
                }

                CharacterInfo Info = CharacterInfoLoader.GetCharacterInfo(MySqlClient, AuthedUid, mId, true);

                if (Info == null || !Info.HasLinkedSession) // not marked online = CharacterInfoLoader failed somehow
                {
                    SessionManager.StopSession(mId);
                    return;
                }

                mCharacterInfo = Info;

                mAchieventCache = new AchievementCache(MySqlClient, CharacterId);
                mBadgeCache = new BadgeCache(MySqlClient, CharacterId, mAchieventCache);

                if (!HasRight("login"))
                {
                    SessionManager.StopSession(mId);
                    return;
                }

                mCharacterInfo.TimestampLastOnline = UnixTimestamp.GetCurrent();

                CharacterResolverCache.AddToCache(mCharacterInfo.Id, mCharacterInfo.Username, true);

                mMessengerFriendCache = new SessionMessengerFriendCache(MySqlClient, CharacterId);
                mFavoriteRoomsCache = new FavoriteRoomsCache(MySqlClient, CharacterId);
                mRatedRoomsCache = new RatedRoomsCache();
                mInventoryCache = new InventoryCache(MySqlClient, CharacterId);
                mIgnoreCache = new UserIgnoreCache(MySqlClient, CharacterId);
                mNewItemsCache = new NewItemsCache(MySqlClient, CharacterId);
                mAvatarEffectCache = new AvatarEffectCache(MySqlClient, CharacterId);
                mQuestCache = new QuestCache(MySqlClient, CharacterId);
                mPetCache = new PetInventoryCache(MySqlClient, CharacterId);

                // Subscription manager
                MySqlClient.SetParameter("userid", CharacterId);
                DataRow Row = MySqlClient.ExecuteQueryRow("SELECT * FROM user_subscriptions WHERE user_id = @userid");

                mSubscriptionManager = (Row != null ? new ClubSubscription(CharacterId,
                    (ClubSubscriptionLevel)int.Parse((Row["subscription_level"].ToString())), (double)Row["timestamp_created"],
                    (double)Row["timestamp_expire"], (double)Row["past_time_hc"], (double)Row["past_time_vip"]) :
                    new ClubSubscription(CharacterId, ClubSubscriptionLevel.None, 0, 0, 0, 0));

                if (mSubscriptionManager.SubscriptionLevel < ClubSubscriptionLevel.VipClub)
                {
                    mBadgeCache.DisableSubscriptionBadge("ACH_VipClub");
                }

                if (mSubscriptionManager.SubscriptionLevel < ClubSubscriptionLevel.BasicClub)
                {
                    mBadgeCache.DisableSubscriptionBadge("ACH_BasicClub");
                }

                mAvatarEffectCache.CheckEffectExpiry(this);

                mAuthProcessed = true;

                SendData(AuthenticationOkComposer.Compose());
                SendData(FuseRightsListComposer.Compose(this));
                SendData(UserHomeRoomComposer.Compose(mCharacterInfo.HomeRoom));
                SendData(UserEffectListComposer.Compose(AvatarEffectCache.Effects));
                SendData(NavigatorFavoriteRoomsComposer.Compose(FavoriteRoomsCache.FavoriteRooms));
                SendData(InventoryNewItemsComposer.Compose(NewItemsCache.NewItems));
                SendData(MessageOfTheDayComposer.Compose("Welcome to uberHotel.org BETA.\n\n\nThank you for participating in the uberHotel.org BETA test. We hope to gather relevant feedback and ideas to help make this hotel into a success.\n\nPlease submit any bugs, feedback, or ideas via:\nhttp://snowlight.uservoice.com\n\n\nHave fun, and thank you for joining us!"));
                SendData(AchievementDataListComposer.Compose(AchievementManager.Achievements.Values.ToList()));

                SendData(AvailabilityStatusMessageComposer.Compose());
                SendData(InfoFeedEnableMessageComposer.Compose(1));
                SendData(ActivityPointsMessageComposer.Compose());

                SendData(ClientConfigComposer.Compose(CharacterInfo.ConfigVolume, false));

                if (HasRight("moderation_tool"))
                {
                    SendData(ModerationToolComposer.Compose(this, ModerationPresets.UserMessagePresets,
                        ModerationPresets.UserActionPresets, ModerationPresets.RoomMessagePresets));

                    foreach (ModerationTicket ModTicket in ModerationTicketManager.ActiveTickets)
                    {
                        SendData(ModerationTicketComposer.Compose(ModTicket));
                    }
                }

                MessengerHandler.MarkUpdateNeeded(this, 0, true);
            }
        }

        private void BeginReceive()
        {
            try
            {
                if (mSocket != null)
                {
                    mSocket.BeginReceive(mBuffer, 0, mBuffer.Length, SocketFlags.None, new AsyncCallback(OnReceiveData), null);
                }
            }
            catch (Exception)
            {
                SessionManager.StopSession(mId);
            }
        }

        private void OnReceiveData(IAsyncResult Result)
        {
            int ByteCount = 0;

            try
            {
                if (mSocket != null)
                {
                    ByteCount = mSocket.EndReceive(Result);
                }
            }
            catch (Exception) { }

            if (ByteCount < 1 || ByteCount >= mBuffer.Length)
            {
                SessionManager.StopSession(mId);
                return;
            }

            ProcessData(ByteUtil.Subbyte(mBuffer, 0, ByteCount));
            BeginReceive();
        }

        public void SendData(ServerMessage Message)
        {
            SendData(Message.GetBytes());
        }

        public void SendData(byte[] Data)
        {
            try
            {
                if (mSocket != null)
                {
                    Output.WriteLine("[SND][" + mId + "]: " + Constants.DefaultEncoding.GetString(Data),
                        OutputLevel.DebugInformation);
                    mSocket.BeginSend(Data, 0, Data.Length, SocketFlags.None, new AsyncCallback(OnDataSent), null);
                }
            }
            catch (Exception e)
            {
                Output.WriteLine("[SND] Socket is null!\n\n" + e.StackTrace, OutputLevel.CriticalError);
            }
            /*
             * TODO: catch all exceptions => Stop()
             */
        }

        private void OnDataSent(IAsyncResult Result)
        {
            try
            {
                if (mSocket != null)
                {
                    mSocket.EndSend(Result);
                }
            }
            catch (Exception)
            {
                SessionManager.StopSession(mId);
            }
        }

        private void ProcessData(byte[] Data)
        {
            if (Data.Length == 0)
            {
                return;
            }

            if (Data[0] == 64)
            {
                int Pos = 0;

                while (Pos < Data.Length)
                {
                    ClientMessage Message = null;

                    try
                    {
                        int MessageLength = Base64Encoding.DecodeInt32(new byte[] { Data[Pos++], Data[Pos++], Data[Pos++] });
                        uint MessageId = Base64Encoding.DecodeUInt32(new byte[] { Data[Pos++], Data[Pos++] });

                        byte[] Content = new byte[MessageLength - 2];

                        for (int i = 0; i < Content.Length; i++)
                        {
                            Content[i] = Data[Pos++];
                        }

                        Message = new ClientMessage(MessageId, Content);
                    }
                    catch (Exception)
                    {
                        SessionManager.StopSession(mId); // packet formatting exception
                        return;
                    }

                    if (Message != null)
                    {
                        Output.WriteLine("[RCV][" + mId + "]: " + Message.ToString(), OutputLevel.DebugInformation);

                        try
                        {
                            DataRouter.HandleData(this, Message);
                        }
                        catch (Exception e)
                        {
                            Output.WriteLine("Critical error in HandleData stack: " + e.Message + "\n\n" + e.StackTrace,
                                OutputLevel.CriticalError);
                            SessionManager.StopSession(mId);
                            return;
                        }
                    }
                }
            }
            else if (Data[0] == 60)
            {
                Output.WriteLine("Sent crossdomain policy to client " + mId + ".", OutputLevel.DebugInformation);
                SendData(CrossdomainPolicy.GetBytes());
                SessionManager.StopSession(mId);
            }
            else
            {
                SessionManager.StopSession(mId);
            }
        }

        public void Stop(SqlDatabaseClient MySqlClient)
        {
            if (Stopped)
            {
                return;
            }

            mSocket.Close();
            mSocket = null;

            if (Authenticated)
            {
                mCharacterInfo.SynchronizeStatistics(MySqlClient);

                if (CurrentRoomId > 0)
                {
                    RoomManager.RemoveUserFromRoom(this, false);
                }

                MessengerHandler.MarkUpdateNeeded(this, 0, true);
            }

            Output.WriteLine("Stopped and disconnected client " + Id + ".", OutputLevel.DebugInformation);

            mStoppedTimestamp = UnixTimestamp.GetCurrent();
        }

        public void Dispose()
        {
            if (!Stopped)
            {
                throw new InvalidOperationException("Cannot dispose of a session that has not been stopped");
            }

            if (mMessengerFriendCache != null)
            {
                mMessengerFriendCache.Dispose();
            }

            if (mFavoriteRoomsCache != null)
            {
                mFavoriteRoomsCache.Dispose();
            }

            if (mRatedRoomsCache != null)
            {
                mRatedRoomsCache.Dispose();
            }

            Output.WriteLine("Disposed and released client " + Id + " and associated resources.", OutputLevel.DebugInformation);
        }

        public void SendInfoUpdate()
        {
            if (!Authenticated)
            {
                return;
            }

            SendData(UserInfoUpdateComposer.Compose(0, mCharacterInfo.Figure, mCharacterInfo.Gender, mCharacterInfo.Motto,
                mCharacterInfo.Score));

            if (InRoom)
            {
                RoomInstance Instance = RoomManager.GetInstanceByRoomId(CurrentRoomId);

                if (Instance == null)
                {
                    return;
                }

                RoomActor Actor = Instance.GetActorByReferenceId(CharacterId);

                if (Actor == null)
                {
                    return;
                }

                Instance.BroadcastMessage(UserInfoUpdateComposer.Compose(Actor.Id, mCharacterInfo.Figure, mCharacterInfo.Gender,
                    mCharacterInfo.Motto, mCharacterInfo.Score));
            }
        }
    }
}
