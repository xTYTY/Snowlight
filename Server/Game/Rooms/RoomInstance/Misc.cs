using System;
using System.Collections.Generic;
using System.Linq;

using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Characters;
using Snowlight.Game.Items;
using Snowlight.Game.Rooms.Events;
using System.Collections.ObjectModel;
using Snowlight.Game.Music;
using Snowlight.Game.Rooms.Trading;

namespace Snowlight.Game.Rooms
{
    public enum StickieEditingRights
    {
        ReadOnly = 0,
        GuestEdit = 1,
        Edit = 2,
        Owner = 3
    }

    public partial class RoomInstance : IDisposable
    {
        private RoomEvent mEvent;
        private bool mRoomMuted;
        private RoomMusicController mMusicController;
        private Dictionary<uint, uint> mTemporaryStickieRights;
        private TradeManager mTradeManager;

        public RoomMusicController MusicController
        {
            get
            {
                return mMusicController;
            }
        }

        public RoomEvent Event
        {
            get
            {
                return mEvent;
            }
        }

        public bool HasOngoingEvent
        {
            get
            {
                return (mEvent != null);
            }
        }

        public bool RoomMuted
        {
            get
            {
                return mRoomMuted;
            }

            set
            {
                mRoomMuted = value;
            }
        }

        public TradeManager TradeManager
        {
            get
            {
                return mTradeManager;
            }
        }

        public void PickAllToUserInventory(Session Session)
        {
            List<Item> Copy = new List<Item>();

            lock (mItemSyncRoot)
            {
                Copy = mItems.Values.ToList();
            }

            foreach (Item Item in Copy)
            {
                if (Item.Definition.Behavior == ItemBehavior.StickyNote)
                {
                    continue;
                }

                TakeItem(Item.Id);
                Session.InventoryCache.Add(Item);
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("roomid", RoomId);
                MySqlClient.SetParameter("userid", Session.CharacterId);
                MySqlClient.ExecuteNonQuery("UPDATE items SET user_id = @userid, room_pos = '0|0|0', room_wall_pos = '', room_rot = '0', room_id = '0' WHERE room_id = @roomid");
            }

            lock (mItemSyncRoot)
            {
                mItems.Clear();
                mItemLimitCache.Clear();
            }

            RegenerateRelativeHeightmap();

            Session.SendData(InventoryRefreshComposer.Compose());
        }

        public void DeleteRoom(Session Session)
        {
            lock (mActorSyncRoot)
            {
                lock (mItemSyncRoot)
                {
                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        PickAllToUserInventory(Session);
                        RoomManager.DeleteRoom(MySqlClient, RoomId);
                    }

                    Unload();
                }
            }
        }

        public void SendModerationAlert(string AlertMessage, bool IsCaution)
        {
            ServerMessage Message = IsCaution ? HotelManagerNotificationComposer.Compose("Caution from moderator:\n\n" +
                AlertMessage) : NotificationMessageComposer.Compose("Notification from staff:\n\n" + AlertMessage);

            lock (mActorSyncRoot)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    if (Actor.Type == RoomActorType.AiBot)
                    {
                        continue;
                    }

                    Session TargetSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                    if (TargetSession == null)
                    {
                        continue;
                    }

                    TargetSession.SendData(Message);

                    if (IsCaution)
                    {
                        TargetSession.CharacterInfo.ModerationCautions++;
                    }
                }
            }
        }

        public int MuteRoom(SqlDatabaseClient MySqlClient, int TimeToMute)
        {
            int i = 0;

            lock (mActorSyncRoot)
            {
                foreach (RoomActor Actor in mActors.Values)
                {
                    if (Actor.Type != RoomActorType.UserCharacter)
                    {
                        continue;
                    }

                    ((CharacterInfo)Actor.ReferenceObject).Mute(MySqlClient, TimeToMute);
                    i++;
                }
            }

            return i;
        }

        public void StartOrUpdateEvent(string Name, string Description, int CategoryId, List<string> Tags)
        {
            if (mEvent == null)
            {
                mEvent = new RoomEvent(Name, Description, CategoryId, Tags, Info.OwnerId, RoomId);
            }
            else
            {
                mEvent.Name = Name;
                mEvent.Description = Description;
                mEvent.CategoryId = CategoryId;
                mEvent.Tags = Tags;
            }

            BroadcastEventData();
        }

        public void StopEvent()
        {
            lock (mEvent)
            {
                mEvent = null;
            }

            BroadcastEventData();
        }

        public void KickRoom(bool SkipModerators)
        {
            ReadOnlyCollection<RoomActor> Copy = null;

            lock (mActorSyncRoot)
            {
                Copy = Actors;
            }

            foreach (RoomActor Actor in Copy)
            {
                if (Actor.Type == RoomActorType.UserCharacter)
                {
                    Session SessionObject = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                    if (SessionObject == null)
                    {
                        RemoveActorFromRoom(Actor.Id);
                        continue;
                    }

                    if (SkipModerators && SessionObject.HasRight("moderation_tool"))
                    {
                        continue;
                    }

                    SoftKickUser(Actor.ReferenceId, true, false, true);
                }
            }           
        }

        public void GiveTemporaryStickieRights(uint StickieId, uint UserId)
        {
            mTemporaryStickieRights.Add(StickieId, UserId);
        }

        public void RevokeTemporaryStickieRights(uint StickieId)
        {
            mTemporaryStickieRights.Remove(StickieId);
        }

        public StickieEditingRights GetStickieEditingRights(Session Session, Item Stickie)
        {
            if (CheckUserRights(Session, true))
            {
                return StickieEditingRights.Owner;
            }

            if (CheckUserRights(Session))
            {
                return StickieEditingRights.Edit;
            }

            if (mTemporaryStickieRights.ContainsKey(Stickie.Id) && mTemporaryStickieRights[Stickie.Id] ==
                Session.CharacterId)
            {
                return StickieEditingRights.GuestEdit;
            }

            return StickieEditingRights.ReadOnly;
        }
    }
}
