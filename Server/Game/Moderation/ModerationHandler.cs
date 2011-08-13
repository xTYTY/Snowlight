using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Storage;
using Snowlight.Game.Rooms;
using Snowlight.Game.Characters;
using System.Collections.ObjectModel;
using System.Text;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Moderation
{
    public static class ModerationHandler
    {
        public static void Initialize()
        {
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_ROOM_INFO, new ProcessRequestCallback(GetRoomInfo));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_USER_INFO, new ProcessRequestCallback(GetUserInfo));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_ROOM_ACTION, new ProcessRequestCallback(PerformRoomAction));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_ALERT_ROOM, new ProcessRequestCallback(AlertRoom));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_USER_VISITS, new ProcessRequestCallback(GetVisits));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_ROOM_CHATLOG, new ProcessRequestCallback(GetRoomChatlog));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_USER_CHATLOG, new ProcessRequestCallback(GetUserChatlog));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_GET_TICKET_CHATLOG, new ProcessRequestCallback(GetTicketChatlog));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_USER_MESSAGE, new ProcessRequestCallback(MessageUser));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_USER_CAUTION, new ProcessRequestCallback(CautionUser));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_KICK, new ProcessRequestCallback(KickUser));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_BAN, new ProcessRequestCallback(BanUser));
        }

        private static void GetRoomInfo(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            RoomInfo Info = RoomInfoLoader.GetRoomInfo(Message.PopWiredUInt32());

            if (Info == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("Could not retrieve room information."));
                return;
            }

            Session.SendData(ModerationRoomInfoComposer.Compose(Info, RoomManager.GetInstanceByRoomId(Info.Id)));
        }

        private static void GetUserInfo(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            CharacterInfo Info = null;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                 Info = CharacterInfoLoader.GetCharacterInfo(MySqlClient, Message.PopWiredUInt32());
            }

            if (Info == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("Could not retrieve user information."));
                return;
            }

            Session.SendData(ModerationUserInfoComposer.Compose(Info, SessionManager.GetSessionByCharacterId(Info.Id)));
        }

        private static void PerformRoomAction(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Message.PopWiredUInt32());

            if (Instance == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("Could not perform room action."));
                return;
            }

            bool SetLock = Message.PopWiredBoolean();
            bool SetName = Message.PopWiredBoolean();
            bool KickAll = Message.PopWiredBoolean();

            List<string> Tags = new List<string>();

            if (!SetName)
            {
                foreach (string Tag in Instance.Info.Tags)
                {
                    Tags.Add(Tag);
                }
            }

            Instance.Info.EditRoom(SetName ? "Inappropriate to hotel management" : Instance.Info.Name, SetName ?
                "Inappropriate to hotel management" : Instance.Info.Description, SetLock ? RoomAccessType.Locked :
                Instance.Info.AccessType, SetLock ? string.Empty : Instance.Info.Password, Instance.Info.MaxUsers,
                SetName ? 0 : Instance.Info.CategoryId, Tags, Instance.Info.AllowPets, Instance.Info.AllowPets,
                Instance.Info.DisableRoomBlocking, Instance.Info.HideWalls, Instance.Info.WallThickness,
                Instance.Info.FloorThickness);

            if (KickAll)
            {
                Instance.KickRoom(true);
            }

            if (KickAll || SetName || SetLock)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    StringBuilder Details = new StringBuilder();

                    Details.Append("Room '" + Instance.Info.Name + "' (ID " + Instance.Info.Id + "): ");
                    int i = 0;

                    if (SetName)
                    {
                        Details.Append("Name set to 'Inappropriate to hotel management'");
                        i++;
                    }

                    if (KickAll)
                    {
                        if (i > 0)
                        {
                            Details.Append(", ");
                        }

                        Details.Append("Kicked all users from room");
                        i++;
                    }

                    if (SetLock)
                    {
                        if (i > 0)
                        {
                            Details.Append(", ");
                        }

                        Details.Append("Locked room");
                        i++;
                    }

                    ModerationLogs.LogModerationAction(MySqlClient, Session, "Performed room moderation action",
                        Details.ToString());
                }
            }
        }

        private static void AlertRoom(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("Could not send room alert."));
                return;
            }

            int Unknown1 = Message.PopWiredInt32();
            int AlertMode = Message.PopWiredInt32();
            string AlertMessage = Message.PopString();
            bool IsCaution = AlertMode != 3;

            Instance.SendModerationAlert(AlertMessage, IsCaution);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                ModerationLogs.LogModerationAction(MySqlClient, Session, "Sent room " + (IsCaution ? "caution" : "message"),
                    "Room " + Instance.Info.Name + " (ID " + Instance.RoomId + "): '" + AlertMessage + "'");
            }
        }

        private static void GetVisits(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();

            Session.SendData(ModerationUserVisitsComposer.Compose(UserId, ModerationLogs.GetRoomVistsForUser(UserId,
                UnixTimestamp.GetCurrent() - 3600)));
        }

        private static void GetRoomChatlog(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            int Unknown1 = Message.PopWiredInt32();
            uint RoomId = Message.PopWiredUInt32();

            RoomInfo Info = RoomInfoLoader.GetRoomInfo(RoomId);

            if (Info == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("Room not found; could not load chatlogs."));
                return;
            }

            Session.SendData(ModerationRoomChatlogsComposer.Compose(Info, ModerationLogs.GetLogsForRoom(RoomId,
                (UnixTimestamp.GetCurrent() - 3600), UnixTimestamp.GetCurrent())));
        }

        private static void GetUserChatlog(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();

            Session.SendData(ModerationUserChatlogsComposer.Compose(UserId, ModerationLogs.GetLogsForUser(UserId,
                (UnixTimestamp.GetCurrent() - 3600))));
        }

        private static void GetTicketChatlog(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            ModerationTicket Ticket = ModerationTicketManager.GetTicket(Message.PopWiredUInt32());

            if (Ticket == null || Ticket.ModeratorUserId != Session.CharacterId)
            {
                Session.SendData(NotificationMessageComposer.Compose("Ticket not found or ticket is not assigned to you."));
                return;
            }

            RoomInfo Info = null;

            if (Ticket.RoomId > 0)
            {
                Info = RoomInfoLoader.GetRoomInfo(Ticket.RoomId);
            }

            Session.SendData(ModerationTicketChatlogsComposer.Compose(Ticket, Info, ModerationLogs.GetLogsForRoom(Ticket.RoomId,
                (Ticket.CreatedTimestamp - 600), UnixTimestamp.GetCurrent())));
        }

        private static void MessageUser(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();
            string MessageText = Message.PopString();

            Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

            if (TargetSession == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("That user is not online at this point in time."));
                return;
            }

            TargetSession.SendData(NotificationMessageComposer.Compose("Notification from staff:\n\n" + MessageText));
            ModerationTicketManager.MarkTicketRespondedToForUser(UserId);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                ModerationLogs.LogModerationAction(MySqlClient, Session, "Sent message to user",
                    "User " + TargetSession.CharacterInfo.Username + " (ID " + TargetSession.CharacterId + "): '" +
                    MessageText + "'.");
            }
        }

        private static void CautionUser(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();
            string MessageText = Message.PopString();

            Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

            if (TargetSession != null)
            {
                TargetSession.SendData(HotelManagerNotificationComposer.Compose("Caution from moderator:\n\n" + MessageText));
                ModerationTicketManager.MarkTicketRespondedToForUser(UserId);
            }
            else
            {
                Session.SendData(NotificationMessageComposer.Compose("That user is not online at this point in time."));
            }

            CharacterInfo Info = (TargetSession != null ? TargetSession.CharacterInfo : null);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                if (Info == null)
                {
                    Info = CharacterInfoLoader.GetCharacterInfo(MySqlClient, UserId);
                }

                if (Info != null)
                {
                    Info.ModerationCautions++;
                }

                ModerationLogs.LogModerationAction(MySqlClient, Session, "Sent caution to user",
                    "User " + TargetSession.CharacterInfo.Username + " (ID " + TargetSession.CharacterId + "): '" +
                    MessageText + "'.");
            }
        }

        private static void KickUser(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();
            string MessageText = Message.PopString();

            Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

            if (TargetSession == null || TargetSession.HasRight("moderation_tool"))
            {
                Session.SendData(NotificationMessageComposer.Compose("That user is not online or cannot be kicked at this point in time."));
                return;
            }

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(TargetSession.CurrentRoomId);

            if (Instance == null)
            {
                Session.SendData(NotificationMessageComposer.Compose("That user is not currently in any room."));
                return;
            }

            TargetSession.CharacterInfo.ModerationCautions++;
            Instance.SoftKickUser(TargetSession.CharacterId, true, false, true);
            TargetSession.SendData(NotificationMessageComposer.Compose("A moderator has kicked you from the room for the following reason:\n\n" + MessageText));

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                ModerationLogs.LogModerationAction(MySqlClient, Session, "Kicked user from room",
                    "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ") from '" +
                    Instance.Info.Name + "' (ID " + Instance.RoomId + "): '" + MessageText + "'.");
            }
        }

        private static void BanUser(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tool"))
            {
                return;
            }

            uint UserId = Message.PopWiredUInt32();
            string MessageText = Message.PopString();
            double Length = (Message.PopWiredInt32() * 3600);

            Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);

            if (TargetSession == null || TargetSession.HasRight("moderation_tool"))
            {
                Session.SendData(NotificationMessageComposer.Compose("This user is not online or you do not have permission to ban them.\nPlease use housekeeping to ban users that are offline."));
                return;
            }

            SessionManager.StopSession(TargetSession.Id);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                ModerationBanManager.BanUser(MySqlClient, UserId, MessageText, Session.CharacterId, Length);
                ModerationLogs.LogModerationAction(MySqlClient, Session, "Banned user",
                    "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ") for " +
                    Length + " hours: '" + MessageText + "'");
            }
        }
    }
}
