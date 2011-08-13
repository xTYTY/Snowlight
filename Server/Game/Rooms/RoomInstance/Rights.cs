using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Sessions;
using Snowlight.Storage;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Rooms
{
    public partial class RoomInstance : IDisposable
    {
        public bool CheckUserRights(Session Session, bool RequireOwnership = false)
        {
            bool IsOwner = (Session.HasRight("room_rights_owner") || Session.CharacterId == Info.OwnerId);

            if (RequireOwnership)
            {
                return IsOwner;
            }

            return (IsOwner || Session.HasRight("room_rights") || mUsersWithRights.Contains(Session.CharacterId));
        }

        public bool GiveUserRights(uint UserId)
        {
            lock (mActorSyncRoot)
            {
                if (mUsersWithRights.Contains(UserId))
                {
                    return false;
                }

                mUsersWithRights.Add(UserId);

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("roomid", RoomId);
                    MySqlClient.SetParameter("userid", UserId);
                    MySqlClient.ExecuteNonQuery("INSERT INTO room_rights (room_id,user_id) VALUES (@roomid,@userid)");
                }

                RoomActor Actor = GetActorByReferenceId(UserId);

                if (Actor != null)
                {
                    Actor.SetStatus("flatctrl");
                    Actor.UpdateNeeded = true;

                    Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                    if (ActorSession != null)
                    {
                        ActorSession.SendData(RoomRightsComposer.Compose());
                    }
                }
            }

            return true;
        }

        public bool TakeUserRights(uint UserId)
        {
            lock (mActorSyncRoot)
            {
                if (!mUsersWithRights.Contains(UserId))
                {
                    return false;
                }

                mUsersWithRights.Remove(UserId);

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("roomid", RoomId);
                    MySqlClient.SetParameter("userid", UserId);
                    MySqlClient.ExecuteNonQuery("DELETE FROM room_rights WHERE room_id = @roomid AND user_id = @userid LIMIT 1");
                }

                RoomActor Actor = GetActorByReferenceId(UserId);

                if (Actor != null)
                {
                    Actor.RemoveStatus("flatctrl");
                    Actor.UpdateNeeded = true;

                    Session ActorSession = SessionManager.GetSessionByCharacterId(Actor.ReferenceId);

                    if (ActorSession != null)
                    {
                        ActorSession.SendData(RoomRightsRemovedComposer.Compose());
                    }
                }
            }

            return true;
        }
    }
}
