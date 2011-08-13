using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Linq;
using System.Threading;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Storage;

using Snowlight.Communication.Outgoing;
using Snowlight.Game.Rooms;
using Snowlight.Util;
using Snowlight.Communication.ResponseCache;
using System.Collections.ObjectModel;
using Snowlight.Communication.Incoming;
using Snowlight.Config;

namespace Snowlight.Game.Navigation
{
    public static class Navigator 
    {
        private static ResponseCacheController mCacheController;
        private static List<FlatCategory> mFlatCategories;
        private static List<NavigatorOfficialItem> mOfficialItems;
        private static Dictionary<string, int> mEventSearchQueries;

        public static int MaxRoomsPerUser
        {
            get
            {
                return (int)ConfigManager.GetValue("navigator.maxroomsperuser");
            }
        }

        public static int MaxFavoritesPerUser
        {
            get
            {
                return (int)ConfigManager.GetValue("navigator.maxfavoritesperuser");
            }
        }

        public static bool CacheEnabled
        {
            get
            {
                return (mCacheController != null);
            }
        }

        public static ResponseCacheController CacheController
        {
            get
            {
                return mCacheController;
            }
        }

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mFlatCategories = new List<FlatCategory>();
            mOfficialItems = new List<NavigatorOfficialItem>();
            mEventSearchQueries = new Dictionary<string, int>();

            if ((bool)ConfigManager.GetValue("cache.navigator.enabled"))
            {
                mCacheController = new ResponseCacheController((int)ConfigManager.GetValue("cache.navigator.lifetime"));
            }

            ReloadFlatCategories(MySqlClient);
            ReloadOfficialItems(MySqlClient);

            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_CATEGORIES, new ProcessRequestCallback(GetCategories));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_OFFICIAL_ROOMS, new ProcessRequestCallback(GetOfficialRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_EVENTS, new ProcessRequestCallback(GetEventRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_FAVORITE_ROOMS, new ProcessRequestCallback(GetFavoriteRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_FRIENDS_ROOMS, new ProcessRequestCallback(GetFriendsRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_POPULAR_ROOMS, new ProcessRequestCallback(GetPopularRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_RATED_ROOMS, new ProcessRequestCallback(GetRatedRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_RECENT_ROOMS, new ProcessRequestCallback(GetRecentRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_ROOMS_WITH_FRIENDS, new ProcessRequestCallback(GetRoomsWithFriends));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_USER_ROOMS, new ProcessRequestCallback(GetUserRooms));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_GET_POPULAR_TAGS, new ProcessRequestCallback(GetPopularTags));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_ADD_FAVORITE, new ProcessRequestCallback(AddFavorite));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_REMOVE_FAVORITE, new ProcessRequestCallback(RemoveFavorite));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_SEARCH, new ProcessRequestCallback(PerformSearch));
            DataRouter.RegisterHandler(OpcodesIn.NAVIGATOR_SEARCH_TAGS, new ProcessRequestCallback(PerformSearch));
            DataRouter.RegisterHandler(OpcodesIn.FRIEND_BAR_FIND_NEW_FRIENDS, new ProcessRequestCallback(FindNewFriends));
        }

        public static void ReloadFlatCategories(SqlDatabaseClient MySqlClient)
        {
            int NumberLoaded = 0;

            lock (mFlatCategories)
            {
                mFlatCategories.Clear();
                mEventSearchQueries.Clear();

                MySqlClient.SetParameter("enabled", "1");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM flat_categories WHERE enabled = @enabled ORDER BY order_num ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    mFlatCategories.Add(new FlatCategory((int)Row["id"], (Row["visible"].ToString() == "1"),
                        (string)Row["title"], (Row["allow_trading"].ToString() == "1")));
                    NumberLoaded++;
                }

                DataTable EventQueries = MySqlClient.ExecuteQueryTable("SELECT * FROM navigator_event_search_categories");

                foreach (DataRow Row in EventQueries.Rows)
                {
                    mEventSearchQueries.Add(Row["query"].ToString().ToLower(), (int)Row["category_id"]);
                }              
            }

            Output.WriteLine("Loaded " + NumberLoaded + " flat " + ((NumberLoaded != 1) ? "categories" : "category") + ".", OutputLevel.DebugInformation);
        }

        public static void ReloadOfficialItems(SqlDatabaseClient MySqlClient)
        {
            int NumberLoaded = 0;

            lock (mOfficialItems)
            {
                mOfficialItems.Clear();

                MySqlClient.SetParameter("enabled", "1");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM navigator_frontpage WHERE enabled = @enabled ORDER BY order_num ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    mOfficialItems.Add(new NavigatorOfficialItem((uint)Row["id"], (uint)Row["parent_id"], (uint)Row["room_id"],
                        (Row["is_category"].ToString() == "1"), (Row["display_type"].ToString() == "details" ?
                        NavigatorOfficialItemDisplayType.Detailed : NavigatorOfficialItemDisplayType.Banner),
                        (string)Row["name"], (string)Row["descr"], (Row["image_type"].ToString() == "internal" ?
                        NavigatorOfficialItemImageType.Internal : NavigatorOfficialItemImageType.External),
                        (string)Row["image_src"], (string)Row["banner_label"], (Row["category_autoexpand"].ToString() == "1")));
                    NumberLoaded++;
                }
            }

            Output.WriteLine("Loaded " + NumberLoaded + " navigator frontpage item(s).", OutputLevel.DebugInformation);
        }

        private static ServerMessage TryGetResponseFromCache(uint GroupId, ClientMessage Request)
        {
            return (CacheEnabled ? mCacheController.TryGetResponse(GroupId, Request) : null);
        }

        private static void AddToCacheIfNeeded(uint GroupId, ClientMessage Request, ServerMessage Response)
        {
            if (!CacheEnabled)
            {
                return;
            }

            mCacheController.AddIfNeeded(GroupId, Request, Response);
        }

        private static void ClearCacheGroup(uint GroupId)
        {
            if (!CacheEnabled)
            {
                return;
            }

            mCacheController.ClearCacheGroup(GroupId);
        }

        public static bool CanTradeInCategory(int CategoryId)
        {
            if (CategoryId < 1)
            {
                return false;
            }

            lock (mFlatCategories)
            {
                foreach (FlatCategory Category in mFlatCategories)
                {
                    if (Category.Id == CategoryId)
                    {
                        return Category.AllowTrading;
                    }
                }
            }

            return false;
        }

        private static void GetCategories(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            Response = NavigatorFlatCategoriesComposer.Compose(mFlatCategories);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetOfficialRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            Response = NavigatorOfficialRoomsComposer.Message(mOfficialItems);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetEventRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            int Category = -1;
            int.TryParse(Message.PopString(), out Category);

            IEnumerable<RoomInstance> Rooms =
                (from RoomInstance in RoomManager.RoomInstances
                 where (RoomInstance.Value.HasOngoingEvent &&
                     (Category == -1 || RoomInstance.Value.Event.CategoryId == Category))
                 orderby RoomInstance.Value.Event.TimestampStarted descending
                 select RoomInstance.Value).Take(50);

            Response = NavigatorRoomListComposer.Compose(Category, 12, string.Empty, Rooms.ToList(), true);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetFavoriteRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<RoomInfo> Rooms = new List<RoomInfo>();

            if (Session.FavoriteRoomsCache.FavoriteRooms.Count > 0)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    StringBuilder QueryBuilder = new StringBuilder("SELECT * FROM rooms WHERE ");

                    int i = 0;

                    foreach (uint RoomId in Session.FavoriteRoomsCache.FavoriteRooms)
                    {
                        if (i >= 1)
                        {
                            QueryBuilder.Append("OR ");
                        }

                        QueryBuilder.Append("id = " + RoomId + " ");
                        i++;
                    }

                    QueryBuilder.Append("ORDER BY current_users DESC LIMIT @limit");

                    MySqlClient.SetParameter("limit", Session.FavoriteRoomsCache.FavoriteRooms.Count);
                    DataTable Table = MySqlClient.ExecuteQueryTable(QueryBuilder.ToString());

                    foreach (DataRow Row in Table.Rows)
                    {
                        Rooms.Add(RoomInfoLoader.GenerateRoomInfoFromRow(Row));
                    }
                }
            }

            Response = NavigatorRoomListComposer.Compose(0, 6, string.Empty, Rooms);
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void GetFriendsRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<RoomInfo> Rooms = new List<RoomInfo>();
            ReadOnlyCollection<uint> Friends = Session.MessengerFriendCache.Friends;

            if (Friends.Count > 0)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    StringBuilder QueryBuilder = new StringBuilder("SELECT * FROM rooms WHERE ");

                    int i = 0;

                    foreach (uint FriendId in Friends)
                    {
                        if (i >= 1)
                        {
                            QueryBuilder.Append("OR ");
                        }

                        QueryBuilder.Append("owner_id = " + FriendId + " ");
                        i++;
                    }

                    QueryBuilder.Append("ORDER BY current_users DESC LIMIT 50");

                    DataTable Table = MySqlClient.ExecuteQueryTable(QueryBuilder.ToString());

                    foreach (DataRow Row in Table.Rows)
                    {
                        Rooms.Add(RoomInfoLoader.GenerateRoomInfoFromRow(Row));
                    }
                }
            }

            Response = NavigatorRoomListComposer.Compose(0, 3, string.Empty, Rooms);
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void GetPopularRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            int Category = -1;
            int.TryParse(Message.PopString(), out Category);

            IEnumerable<RoomInstance> Rooms =
                (from RoomInstance in RoomManager.RoomInstances
                 where RoomInstance.Value.Info.Type == RoomType.Flat && 
                    RoomInstance.Value.CachedNavigatorUserCount > 0 &&
                    (Category == -1 || RoomInstance.Value.Info.CategoryId == Category)                   
                 orderby RoomInstance.Value.CachedNavigatorUserCount descending
                 select RoomInstance.Value).Take(50);

            Response = NavigatorRoomListComposer.Compose(Category, 1, string.Empty, Rooms.ToList());
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetRatedRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<RoomInfo> Rooms = new List<RoomInfo>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM rooms WHERE type = 'flat' AND score > 0 ORDER BY score DESC LIMIT 50");

                foreach (DataRow Row in Table.Rows)
                {
                    Rooms.Add(RoomInfoLoader.GenerateRoomInfoFromRow(Row));
                }
            }

            Response = NavigatorRoomListComposer.Compose(0, 2, string.Empty, Rooms);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetRecentRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<uint> VisitedUids = new List<uint>();
            List<RoomInfo> Rooms = new List<RoomInfo>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("userid", Session.CharacterId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT room_id FROM room_visits WHERE user_id = @userid ORDER BY timestamp_entered DESC LIMIT 50");

                foreach (DataRow Row in Table.Rows)
                {
                    uint Id = (uint)Row["room_id"];

                    if (VisitedUids.Contains(Id))
                    {
                        continue;
                    }

                    RoomInfo Info = RoomInfoLoader.GetRoomInfo(Id);

                    if (Info == null || Info.Type == RoomType.Public)
                    {
                        continue;
                    }

                    Rooms.Add(Info);
                    VisitedUids.Add(Info.Id);
                }
            }

            Response = NavigatorRoomListComposer.Compose(0, 7, string.Empty, Rooms);
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void GetRoomsWithFriends(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<uint> RoomUids = new List<uint>();
            ReadOnlyCollection<uint> Friends = Session.MessengerFriendCache.Friends;

            foreach (uint FriendId in Friends)
            {
                Session FriendSession = SessionManager.GetSessionByCharacterId(FriendId);

                if (FriendSession != null && FriendSession.CurrentRoomId > 0)
                {
                    RoomUids.Add(FriendSession.CurrentRoomId);
                }
            }

            IEnumerable<RoomInstance> Rooms =
                (from RoomInstance in RoomManager.RoomInstances
                 where RoomUids.Contains(RoomInstance.Value.RoomId)
                 select RoomInstance.Value).Take(50);

            Response = NavigatorRoomListComposer.Compose(0, 4, string.Empty, Rooms.ToList());
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        public static void GetUserRooms(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(Session.CharacterId, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            List<RoomInfo> Rooms = new List<RoomInfo>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("ownerid", Session.CharacterId);
                MySqlClient.SetParameter("limit", MaxRoomsPerUser);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM rooms WHERE owner_id = @ownerid ORDER BY name ASC LIMIT @limit");

                foreach (DataRow Row in Table.Rows)
                {
                    Rooms.Add(RoomInfoLoader.GenerateRoomInfoFromRow(Row));
                }
            }

            Response = NavigatorRoomListComposer.Compose(0, 5, string.Empty, Rooms);
            AddToCacheIfNeeded(Session.CharacterId, Message, Response);
            Session.SendData(Response);
        }

        private static void AddFavorite(Session Session, ClientMessage Message)
        {
            uint RoomId = Message.PopWiredUInt32();

            if (Session.FavoriteRoomsCache.AddRoomToFavorites(RoomId))
            {
                Session.SendData(NavigatorFavoriteRoomsChanged.Compose(RoomId, true));
            }

            ClearCacheGroup(Session.CharacterId);
        }

        private static void RemoveFavorite(Session Session, ClientMessage Message)
        {
            uint RoomId = Message.PopWiredUInt32();

            if (Session.FavoriteRoomsCache.RemoveRoomFromFavorites(RoomId))
            {
                Session.SendData(NavigatorFavoriteRoomsChanged.Compose(RoomId, false));
            }

            ClearCacheGroup(Session.CharacterId);
        }

        private static void PerformSearch(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            Dictionary<uint, RoomInfo> Rooms = new Dictionary<uint, RoomInfo>();
            string Query = UserInputFilter.FilterString(Message.PopString()).ToLower().Trim();
            int SearchEventCatId = 0;

            if (mEventSearchQueries.ContainsKey(Query.ToLower()))
            {
                SearchEventCatId = mEventSearchQueries[Query.ToLower()];
            }

            // Limit query length. just a precaution.
            if (Query.Length > 64)
            {
                Query = Query.Substring(0, 64);
            }

            if (Query.Length > 0)
            {
                IEnumerable<RoomInstance> InstanceMatches =
                    (from RoomInstance in RoomManager.RoomInstances
                    where RoomInstance.Value.HumanActorCount > 0 &&
                        RoomInstance.Value.Info.Type == RoomType.Flat &&
                        (RoomInstance.Value.Info.OwnerName.StartsWith(Query) ||
                        RoomInstance.Value.SearchableTags.Contains(Query) ||
                        RoomInstance.Value.Info.Name.Contains(Query) ||
                        (RoomInstance.Value.HasOngoingEvent &&
                        (RoomInstance.Value.Event.Name.StartsWith(Query) ||
                        (SearchEventCatId > 0 && RoomInstance.Value.Event.CategoryId == SearchEventCatId))))
                    orderby RoomInstance.Value.HumanActorCount descending
                    select RoomInstance.Value).Take(50);

                foreach (RoomInstance Instance in InstanceMatches)
                {
                    Rooms.Add(Instance.RoomId, Instance.Info);
                }

                if (Rooms.Count < 50) // need db results?
                {
                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        MySqlClient.SetParameter("query", Query + "%");
                        MySqlClient.SetParameter("fquery", "%" + Query + "%");

                        uint ToUid = CharacterResolverCache.GetUidFromName(Query);

                        if (ToUid > 0)
                        {
                            MySqlClient.SetParameter("owneruid", ToUid);
                        }

                        DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM rooms WHERE name LIKE @query AND type = 'flat' OR tags LIKE @fquery AND type = 'flat'" + (ToUid > 0 ? " OR owner_id = @owneruid AND type = 'flat'" : string.Empty) + " LIMIT 50");

                        foreach (DataRow Row in Table.Rows)
                        {
                            uint RoomId = (uint)Row["id"];

                            if (!Rooms.ContainsKey(RoomId))
                            {
                                Rooms.Add(RoomId, RoomInfoLoader.GenerateRoomInfoFromRow(Row));
                            }
                        }
                    }
                }
            }

            Response = NavigatorRoomListComposer.Compose(1, 9, Query, Rooms.Values.Take(50).ToList());
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        private static void GetPopularTags(Session Session, ClientMessage Message)
        {
            ServerMessage Response = TryGetResponseFromCache(0, Message);

            if (Response != null)
            {
                Session.SendData(Response);
                return;
            }

            IEnumerable<List<string>> Tags =
                (from RoomInstance in RoomManager.RoomInstances
                 where RoomInstance.Value.HumanActorCount > 0
                 orderby RoomInstance.Value.HumanActorCount descending
                 select RoomInstance.Value.SearchableTags).Take(50);

            Dictionary<string, int> TagValues = new Dictionary<string, int>();

            foreach (List<string> TagList in Tags)
            {
                foreach (string Tag in TagList)
                {
                    if (!TagValues.ContainsKey(Tag))
                    {
                        TagValues.Add(Tag, 1);
                    }
                    else
                    {
                        TagValues[Tag]++;
                    }
                }
            }

            List<KeyValuePair<string, int>> SortedTags = new List<KeyValuePair<string, int>>(TagValues);

            SortedTags.Sort((FirstPair, NextPair) =>
            {
                return FirstPair.Value.CompareTo(NextPair.Value);
            });

            SortedTags.Reverse();

            Response = NavigatorPopularTagListComposer.Compose(SortedTags);
            AddToCacheIfNeeded(0, Message, Response);
            Session.SendData(Response);
        }

        public static bool StaffPickedContainsRoom(uint RoomId)
        {
            uint CategoryId = (uint)ConfigManager.GetValue("rooms.staffpicked.category");

            lock (mOfficialItems)
            {
                foreach (NavigatorOfficialItem Item in mOfficialItems)
                {
                    if (Item.RoomId == RoomId && Item.ParentId == CategoryId)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        public static void AddRoomToStaffPicked(uint RoomId)
        {
            uint CategoryId = (uint)ConfigManager.GetValue("rooms.staffpicked.category");

            lock (mOfficialItems)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", RoomId);
                    MySqlClient.SetParameter("parentid", CategoryId);
                    MySqlClient.ExecuteNonQuery("INSERT INTO navigator_frontpage (parent_id,room_id) VALUES (@parentid,@id)");
                }

                mOfficialItems.Add(new NavigatorOfficialItem(0, CategoryId, RoomId, false, NavigatorOfficialItemDisplayType.Detailed,
                    string.Empty, string.Empty, NavigatorOfficialItemImageType.Internal, string.Empty, string.Empty, false));
            }
        }

        public static void RemoveRoomFromStaffPicked(uint RoomId)
        {
            uint CategoryId = (uint)ConfigManager.GetValue("rooms.staffpicked.category");

            lock (mOfficialItems)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("id", RoomId);
                    MySqlClient.SetParameter("parentid", CategoryId);
                    MySqlClient.ExecuteNonQuery("DELETE FROM navigator_frontpage WHERE room_id = @id AND parent_id = @parentid LIMIT 1");
                }

                foreach (NavigatorOfficialItem Item in mOfficialItems)
                {
                    if (Item.RoomId == RoomId)
                    {
                        mOfficialItems.Remove(Item);
                        return;
                    }
                }
            }
        }

        public static void FindNewFriends(Session Session, ClientMessage Message)
        {
            IEnumerable<RoomInstance> SelectedInstance =
                (from RoomInstance in RoomManager.RoomInstances
                 where (RoomInstance.Value.HumanActorCount > 0 &&
                    RoomInstance.Value.Info.AccessType == RoomAccessType.Open &&
                    RoomInstance.Value.HumanActorCount < RoomInstance.Value.Info.MaxUsers &&
                    RoomInstance.Value.Info.Type == RoomType.Flat)
                 orderby RoomInstance.Value.HumanActorCount descending
                 select RoomInstance.Value).Take(1);

            if (SelectedInstance.Count() != 1)
            {
                Session.SendData(FriendBarResultComposer.Compose(false));
                return;
            }

            Session.SendData(FriendBarResultComposer.Compose(true));
            Session.SendData(MessengerFollowResultComposer.Compose(SelectedInstance.First().Info));
        }
    }
}
