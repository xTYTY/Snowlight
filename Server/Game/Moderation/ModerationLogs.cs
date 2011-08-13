using System;
using System.Data;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Storage;
using Snowlight.Game.Rooms;
using Snowlight.Specialized;

using Snowlight.Game.Sessions;
using Snowlight.Config;

namespace Snowlight.Game.Moderation
{
    public static class ModerationLogs
    {
        public static void LogChatMessage(SqlDatabaseClient MySqlClient, uint UserId, uint RoomId, string Message)
        {
            if (!(bool)ConfigManager.GetValue("moderation.chatlogs.enabled"))
            {
                return;
            }

            MySqlClient.SetParameter("userid", UserId);
            MySqlClient.SetParameter("roomid", RoomId);
            MySqlClient.SetParameter("message", Message);
            MySqlClient.SetParameter("timestamp", UnixTimestamp.GetCurrent());
            MySqlClient.ExecuteNonQuery("INSERT INTO moderation_chatlogs (user_id,room_id,message,timestamp) VALUES (@userid,@roomid,@message,@timestamp)");
        }

        public static void LogRoomEntry(uint UserId, uint RoomId)
        {
            if (!(bool)ConfigManager.GetValue("moderation.roomlogs.enabled"))
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                double Stamp = UnixTimestamp.GetCurrent();

                MySqlClient.SetParameter("userid", UserId);
                MySqlClient.SetParameter("timestamp", Stamp);
                MySqlClient.ExecuteNonQuery("UPDATE room_visits SET timestamp_left = @timestamp WHERE user_id = @userid AND timestamp_left = 0 LIMIT 1");

                MySqlClient.SetParameter("userid", UserId);
                MySqlClient.SetParameter("roomid", RoomId);
                MySqlClient.SetParameter("timestamp", Stamp);
                MySqlClient.ExecuteNonQuery("INSERT INTO room_visits (user_id,room_id,timestamp_entered) VALUES (@userid,@roomid,@timestamp)");
            }
        }

        public static ReadOnlyCollection<ModerationRoomVisit> GetRoomVistsForUser(uint UserId, double FromTimestamp)
        {
            List<ModerationRoomVisit> Visits = new List<ModerationRoomVisit>();

            if (!(bool)ConfigManager.GetValue("moderation.roomlogs.enabled"))
            {
                return Visits.AsReadOnly();
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("userid", UserId);
                MySqlClient.SetParameter("timestamp", FromTimestamp);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT room_id,timestamp_entered,timestamp_left FROM room_visits WHERE user_id = @userid AND timestamp_entered >= @timestamp ORDER BY timestamp_entered DESC");

                foreach (DataRow Row in Table.Rows)
                {
                    Visits.Add(new ModerationRoomVisit((uint)Row["room_id"], (double)Row["timestamp_entered"],
                        (double)Row["timestamp_left"]));
                }
            }   

            return Visits.AsReadOnly();
        }

        public static Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>> GetLogsForUser(uint UserId, double FromTimestamp)
        {
            if (!(bool)ConfigManager.GetValue("moderation.roomlogs.enabled"))
            {
                return new Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>>();
            }

            Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>> Entries =
                new Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>>();
            ReadOnlyCollection<ModerationRoomVisit> Visits = GetRoomVistsForUser(UserId, FromTimestamp);

            foreach (ModerationRoomVisit Visit in Visits)
            {
                Entries.Add(Visit, GetLogsForRoom(Visit.RoomId, Visit.TimestampEntered, Visit.TimestampLeft > 0 ?
                    Visit.TimestampLeft : UnixTimestamp.GetCurrent()));
            } 

            return new Dictionary<ModerationRoomVisit, ReadOnlyCollection<ModerationChatlogEntry>>(Entries);
        }

        public static ReadOnlyCollection<ModerationChatlogEntry> GetLogsForRoom(uint RoomId, double FromTimestamp, double ToTimestamp)
        {
            List<ModerationChatlogEntry> Entries = new List<ModerationChatlogEntry>();
            
            if (!(bool)ConfigManager.GetValue("moderation.chatlogs.enabled"))
            {
                return Entries.AsReadOnly();
            }       

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("roomid", RoomId);
                MySqlClient.SetParameter("timestamp_from", FromTimestamp);
                MySqlClient.SetParameter("timestamp_to", ToTimestamp);

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT user_id,room_id,timestamp,message FROM moderation_chatlogs WHERE room_id = @roomid AND timestamp >= @timestamp_from AND timestamp <= @timestamp_to ORDER BY timestamp DESC");

                foreach (DataRow Row in Table.Rows)
                {
                    Entries.Add(new ModerationChatlogEntry((uint)Row["user_id"], (uint)Row["room_id"], (double)Row["timestamp"],
                        (string)Row["message"]));
                }
            }

            return Entries.AsReadOnly();
        }

        public static void LogModerationAction(SqlDatabaseClient MySqlClient, Session Session, string ActionDescr, string ActionDetail)
        {
            MySqlClient.SetParameter("userid", Session.CharacterId);
            MySqlClient.SetParameter("username", Session.CharacterInfo.Username);
            MySqlClient.SetParameter("timestamp", UnixTimestamp.GetCurrent());
            MySqlClient.SetParameter("actiondescr", ActionDescr);
            MySqlClient.SetParameter("actiondetail", ActionDetail);
            MySqlClient.ExecuteNonQuery("INSERT INTO moderation_action_log (moderator_id,moderator_name,action_descr,action_detail,timestamp) VALUES (@userid,@username,@actiondescr,@actiondetail,@timestamp)");
        }
    }
}
