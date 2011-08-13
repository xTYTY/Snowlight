using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;

using Snowlight.Storage;

using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Util;
using Snowlight.Game.Characters;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Moderation
{
    public static class ModerationTicketManager
    {
        #region Fields
        private static Dictionary<uint, ModerationTicket> mTickets;
        private static object mSyncRoot;
        #endregion

        #region Properties
        public static ReadOnlyCollection<ModerationTicket> ActiveTickets
        {
            get
            {
                lock (mSyncRoot)
                {
                    List<ModerationTicket> ActiveTickets = new List<ModerationTicket>();

                    if (mTickets != null)
                    {
                        lock (mTickets)
                        {
                            foreach (ModerationTicket Ticket in mTickets.Values)
                            {
                                if (Ticket.Status > ModerationTicketStatus.Assigned)
                                {
                                    continue;
                                }

                                ActiveTickets.Add(Ticket);
                            }
                        }
                    }

                    return ActiveTickets.AsReadOnly();
                }
            }
        }
        #endregion

        #region Init
        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mTickets = new Dictionary<uint, ModerationTicket>();
            mSyncRoot = new object();

            LoadPendingTickets(MySqlClient);

            DataRouter.RegisterHandler(OpcodesIn.HELP_SUBMIT_CFH, new ProcessRequestCallback(HandleIncomingTicket));
            DataRouter.RegisterHandler(OpcodesIn.HELP_DELETE_PENDING_CFH, new ProcessRequestCallback(DeletePendingTicket));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_TICKET_PICK, new ProcessRequestCallback(PickTicket));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_TICKET_RELEASE, new ProcessRequestCallback(ReleaseTicket));
            DataRouter.RegisterHandler(OpcodesIn.MODERATION_TICKET_CLOSE, new ProcessRequestCallback(CloseTicket));
        }
        #endregion

        #region Collection management
        public static void LoadPendingTickets(SqlDatabaseClient MySqlClient)
        {
            int i = 0;

            lock (mSyncRoot)
            {
                mTickets.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM moderation_tickets WHERE status = '0' OR status = '1' ORDER BY id ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    mTickets.Add((uint)Row["id"], new ModerationTicket((uint)Row["id"], (uint)Row["category"],
                        (ModerationTicketStatus)int.Parse(Row["status"].ToString()), (uint)Row["reported_user_id"],
                        (uint)Row["reportee_user_id"], (uint)Row["moderator_user_id"], (uint)Row["room_id"],
                        (double)Row["timestamp"], (string)Row["message"]));
                    i++;
                }
            }

            Output.WriteLine("Loaded " + i + " pending moderation ticket(s) from the database.", OutputLevel.DebugInformation);
        }

        public static ModerationTicket GetTicket(uint Id)
        {
            lock (mSyncRoot)
            {
                foreach (ModerationTicket Ticket in mTickets.Values)
                {
                    if (Ticket.Id == Id)
                    {
                        return Ticket;
                    }
                }
            }

            return null;
        }

        public static ModerationTicket GetPendingTicketForUser(uint UserId)
        {
            lock (mSyncRoot)
            {
                foreach (ModerationTicket Ticket in mTickets.Values)
                {
                    if ((Ticket.Status == ModerationTicketStatus.OpenTicket || Ticket.Status == ModerationTicketStatus.Assigned)
                        && Ticket.ReporteeUserId == UserId)
                    {
                        return Ticket;
                    }
                }
            }

            return null;
        }
        #endregion

        #region Misc
        public static void SendDataToAllModerators(ServerMessage Message)
        {
            SessionManager.BroadcastPacket(Message, "moderation_tickets");
        }

        public static void MarkTicketRespondedToForUser(uint UserId)
        {
            lock (mSyncRoot)
            {
                foreach (ModerationTicket Ticket in mTickets.Values)
                {
                    if (Ticket.Status == ModerationTicketStatus.Assigned && Ticket.ReporteeUserId == UserId)
                    {
                        Ticket.ModeratorResponded = true;
                        return;
                    }
                }
            }
        }
        #endregion

        #region Handlers
        private static void HandleIncomingTicket(Session Session, ClientMessage Message)
        {
            if (GetPendingTicketForUser(Session.CharacterId) != null)
            {
                Session.SendData(HelpSubmitCfhResultComposer.Compose(CfhErrorCode.AlreadyHaveCall));
                return;
            }

            if (Session.CharacterInfo.ModerationTicketsCooldownSeconds > 0)
            {
                Session.SendData(HelpSubmitCfhResultComposer.Compose(CfhErrorCode.AbusiveCooldown));
                return;
            }

            string TicketBody = UserInputFilter.FilterString(Message.PopString());
            uint Unknown = Message.PopWiredUInt32();
            uint Category = Message.PopWiredUInt32();
            uint ReportedUser = Message.PopWiredUInt32();
            uint RoomId = Session.CurrentRoomId;
            double Timestamp = UnixTimestamp.GetCurrent();

            lock (mSyncRoot)
            {
                uint GeneratedId = 0;

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {             
                    MySqlClient.SetParameter("category", Category);
                    MySqlClient.SetParameter("reporteduid", ReportedUser);
                    MySqlClient.SetParameter("reporteeuid", Session.CharacterId);
                    MySqlClient.SetParameter("roomid", RoomId); 
                    MySqlClient.SetParameter("timestamp", Timestamp);
                    MySqlClient.SetParameter("message", TicketBody);
                    string GeneratedResult = MySqlClient.ExecuteScalar("INSERT INTO moderation_tickets (category,reported_user_id,reportee_user_id,room_id,timestamp,message) VALUES (@category,@reporteduid,@reporteeuid,@roomid,@timestamp,@message); SELECT LAST_INSERT_ID();").ToString();

                    uint.TryParse(GeneratedResult, out GeneratedId);
                }

                if (GeneratedId > 0)
                {
                    ModerationTicket NewTicket = new ModerationTicket(GeneratedId, Category, ModerationTicketStatus.OpenTicket,
                        ReportedUser, Session.CharacterId, 0, RoomId, Timestamp, TicketBody);

                    mTickets.Add(GeneratedId, NewTicket);

                    ServerMessage TicketMessage = ModerationTicketComposer.Compose(NewTicket);
                    SendDataToAllModerators(TicketMessage);

                    Session.CharacterInfo.ModerationTickets++;
                }
            }

            Session.SendData(HelpSubmitCfhResultComposer.Compose(CfhErrorCode.Ok));
        }

        private static void DeletePendingTicket(Session Session, ClientMessage Message)
        {
            ModerationTicket OldTicket = GetPendingTicketForUser(Session.CharacterId);

            if (OldTicket == null)
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                OldTicket.UpdateStatus(MySqlClient, ModerationTicketStatus.DeletedByUser);
            }

            SendDataToAllModerators(ModerationTicketComposer.Compose(OldTicket));
            Session.SendData(HelpCfhDeletedOkComposer.Compose());
        }

        private static void PickTicket(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tickets"))
            {
                return;
            }

            int Unknown1 = Message.PopWiredInt32();

            lock (mSyncRoot)
            {
                ModerationTicket Ticket = GetTicket(Message.PopWiredUInt32());

                if (Ticket == null || Ticket.Status != ModerationTicketStatus.OpenTicket)
                {
                    Session.SendData(ModerationPickingErrorComposer.Compose());
                    return;
                }

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    Ticket.AssignTo(MySqlClient, Session.CharacterId);
                }

                SendDataToAllModerators(ModerationTicketComposer.Compose(Ticket));
            }
        }

        private static void ReleaseTicket(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tickets"))
            {
                return;
            }

            int Amount = Message.PopWiredInt32();

            lock (mSyncRoot)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    for (int i = 0; i < Amount; i++)
                    {
                        ModerationTicket Ticket = GetTicket(Message.PopWiredUInt32());

                        if (Ticket == null || Ticket.Status != ModerationTicketStatus.Assigned ||
                            Ticket.ModeratorUserId != Session.CharacterId)
                        {
                            continue;
                        }

                        Ticket.AssignTo(MySqlClient, 0);
                        SendDataToAllModerators(ModerationTicketComposer.Compose(Ticket));
                    }
                }
            }
        }

        private static void CloseTicket(Session Session, ClientMessage Message)
        {
            if (!Session.HasRight("moderation_tickets"))
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                int ResultCode = Message.PopWiredInt32();
                int Unknown1 = Message.PopWiredInt32();

                lock (mSyncRoot)
                {
                    ModerationTicket Ticket = GetTicket(Message.PopWiredUInt32());

                    if (Ticket == null || Ticket.Status != ModerationTicketStatus.Assigned ||
                        Ticket.ModeratorUserId != Session.CharacterId)
                    {
                        return;
                    }

                    ModerationTicketStatus ResultStatus = ModerationTicketStatus.Resolved;
                    Session TargetSession = SessionManager.GetSessionByCharacterId(Ticket.ReporteeUserId);

                    switch (ResultCode)
                    {
                        case 1:

                            ResultStatus = ModerationTicketStatus.ClosedInvalid;
                            break;

                        case 2:

                            ResultStatus = ModerationTicketStatus.ClosedAbusive;
                            break;
                    }

                    Ticket.UpdateStatus(MySqlClient, ResultStatus);

                    SendDataToAllModerators(ModerationTicketComposer.Compose(Ticket));

                    if (TargetSession != null && !Ticket.ModeratorResponded)
                    {
                        TargetSession.SendData(HelpCfhClosedResultComposer.Compose(ResultCode));
                    }

                    if (ResultStatus == ModerationTicketStatus.ClosedAbusive)
                    {
                        CharacterInfo TargetInfo = TargetSession == null ? CharacterInfoLoader.GetCharacterInfo(MySqlClient,
                            Ticket.ReporteeUserId) : TargetSession.CharacterInfo;

                        if (TargetInfo != null)
                        {
                            TargetInfo.ModerationTicketsCooldownSeconds = 600;
                            TargetInfo.ModerationTicketsAbusive++;

                            // Sync our new statistics manually if this will not happen by session closure
                            if (TargetSession == null)
                            {
                                TargetInfo.SynchronizeStatistics(MySqlClient);
                            }
                        }
                    }
                }
            }
        }
        #endregion
    }
}
