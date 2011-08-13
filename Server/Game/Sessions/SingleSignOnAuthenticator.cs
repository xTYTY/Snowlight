using System;
using System.Data;

using Snowlight.Storage;
using Snowlight.Game.Characters;

using Snowlight.Game.Sessions;
using Snowlight.Game.Moderation;
using Snowlight.Config;

namespace Snowlight.Game.Sessions
{
    /// <summary>
    /// Provides user authentication for single sign on tickets.
    /// </summary>
    public static class SingleSignOnAuthenticator
    {
        private static int mSuccessfulLoginCount;
        private static int mFailedLoginCount;
        private static object mAuthSyncRoot;

        /// <summary>
        /// Returns the total amount of successful authentication attempts.
        /// </summary>
        public static int SuccessfulLoginCount
        {
            get
            {
                return mSuccessfulLoginCount;
            }
        }

        /// <summary>
        /// Returns the total amount of failed authentication attempts.
        /// </summary>
        public static int FailedLoginCount
        {
            get
            {
                return mFailedLoginCount;
            }
        }

        /// <summary>
        /// Returns the total amount of authentication attempts.
        /// </summary>
        public static int TotalLoginCount
        {
            get
            {
                return (mSuccessfulLoginCount + mFailedLoginCount);
            }
        }

        /// <summary>
        /// Initializes the user authenticator.
        /// </summary>
        public static void Initialize()
        {
            mSuccessfulLoginCount = 0;
            mFailedLoginCount = 0;
            mAuthSyncRoot = new object();
        }

        /// <summary>
        /// Attemps to authenticate an user using an SSO (Single Sign On) ticket.
        /// </summary>
        /// <param name="Ticket">The ticket string.</param>
        /// <returns>Character id on success, 0 on authentication failure.</returns>
        public static uint TryAuthenticate(SqlDatabaseClient MySqlClient, string Ticket, string RemoteAddress)
        {
            lock (mAuthSyncRoot)
            {
                // Remove any spacing from single sign on ticket
                Ticket = Ticket.Trim();

                // Ensure the ticket meets the minimum length requirement
                if (Ticket.Length <= 5)
                {
                    mFailedLoginCount++;
                    return 0;
                }

                // Debug
                string DebugTicket = (string)ConfigManager.GetValue("debug.sso");
                if (DebugTicket.Length > 0 && Ticket == DebugTicket)
                    return 1;

                // Check the database for a matching single sign on ticket
                uint UserId = 0;
                string LogName = string.Empty;

                MySqlClient.SetParameter("ticket", Ticket);
                DataRow Row = MySqlClient.ExecuteQueryRow("SELECT id,username FROM characters WHERE auth_ticket = @ticket LIMIT 1");

                if (Row != null)
                {
                    UserId = (uint)Row["id"];
                    LogName = (string)Row["username"];

                    RemoveTicket(MySqlClient, (uint)Row["id"], RemoteAddress);
                }

                // Check if ticket was OK + Check for user id bans
                if (UserId <= 0 || ModerationBanManager.IsUserIdBlacklisted(UserId))
                {
                    mFailedLoginCount++;
                    return 0;
                }

                // Disconnect any previous sessions for this account
                if (SessionManager.ContainsCharacterId(UserId))
                {
                    Session TargetSession = SessionManager.GetSessionByCharacterId(UserId);
                    SessionManager.StopSession(TargetSession.Id);
                }

                // Mark as a successful login and continue
                Output.WriteLine("User " + LogName + " (ID " + UserId + ") has logged in from " + RemoteAddress + ".");

                mSuccessfulLoginCount++;
                return UserId;
            }
        }

        /// <summary>
        /// Removes the SSO (Single Sign On) ticket from the database after a successful login attempt.
        /// </summary>
        /// <param name="UserId">The character id to remove the ticket from.</param>
        private static void RemoveTicket(SqlDatabaseClient MySqlClient, uint UserId, string AddressToLog)
        {
            MySqlClient.SetParameter("id", UserId);
            MySqlClient.SetParameter("lastip", AddressToLog);
            MySqlClient.SetParameter("lastonline", UnixTimestamp.GetCurrent());
            MySqlClient.ExecuteNonQuery("UPDATE characters SET auth_ticket = '', last_ip = @lastip, timestamp_lastvisit = @lastonline WHERE id = @id LIMIT 1");
        }
    }
}
