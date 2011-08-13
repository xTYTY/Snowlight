using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Storage;

namespace Snowlight.Game.Moderation
{
    public enum ModerationTicketStatus
    {
        OpenTicket = 0,
        Assigned = 1,
        Resolved = 2,
        ClosedAbusive = 3,
        ClosedInvalid = 4,
        DeletedByUser = 5
    }

    public class ModerationTicket
    {
        private uint mId;
        private uint mCategoryId;
        private ModerationTicketStatus mStatus;
        private uint mReportedUserId;
        private uint mReporteeUserId;
        private uint mModeratorUserId;
        private uint mRoomId;
        private double mCreatedTimestamp;
        private string mTicketMessage;
        private bool mModeratorResponded;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public uint CategoryId
        {
            get
            {
                return mCategoryId;
            }
        }

        public uint Score
        {
            get
            {
                return 10 + (uint)((Age / 60) * 1);
            }
        }

        public ModerationTicketStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        public uint TabId
        {
            get
            {
                switch (mStatus)
                {
                    case ModerationTicketStatus.OpenTicket:

                        return 1;

                    case ModerationTicketStatus.Assigned:

                        return 2;

                    default:

                        return 0;
                }
            }
        }

        public uint ReportedUserId
        {
            get
            {
                return mReportedUserId;
            }
        }

        public uint ReporteeUserId
        {
            get
            {
                return mReporteeUserId;
            }
        }

        public uint ModeratorUserId
        {
            get
            {
                return mModeratorUserId;
            }
        }

        public uint RoomId
        {
            get
            {
                return mRoomId;
            }
        }

        public double Age
        {
            get
            {
                return (UnixTimestamp.GetCurrent() - mCreatedTimestamp);
            }
        }

        public double CreatedTimestamp
        {
            get
            {
                return mCreatedTimestamp;
            }
        }

        public string Message
        {
            get
            {
                return mTicketMessage;
            }
        }

        public bool ModeratorResponded
        {
            get
            {
                return mModeratorResponded;
            }

            set
            {
                mModeratorResponded = value;
            }
        }

        public ModerationTicket(uint Id, uint Category, ModerationTicketStatus Status, uint ReportedUserId, uint ReporteeUserId,
            uint ModeratorUserId, uint RoomId, double Timestamp, string Message)
        {
            mId = Id;
            mCategoryId = Category;
            mStatus = Status;
            mReportedUserId = ReportedUserId;
            mReporteeUserId = ReporteeUserId;
            mModeratorUserId = ModeratorUserId;
            mRoomId = RoomId;
            mCreatedTimestamp = Timestamp;
            mTicketMessage = Message;
        }

        public void AssignTo(SqlDatabaseClient MySqlClient, uint ModeratorId)
        {
            if (mStatus > ModerationTicketStatus.Assigned)
            {
                return;
            }

            mModeratorUserId = ModeratorId;
            mStatus = (ModeratorId > 0 ? ModerationTicketStatus.Assigned : ModerationTicketStatus.OpenTicket);

            MySqlClient.SetParameter("id", mId);
            MySqlClient.SetParameter("status", (ModeratorId > 0 ? (int)ModerationTicketStatus.Assigned : (int)ModerationTicketStatus.OpenTicket).ToString());
            MySqlClient.SetParameter("moderatorid", ModeratorId);
            MySqlClient.ExecuteNonQuery("UPDATE moderation_tickets SET status = @status, moderator_user_id = @moderatorid WHERE id = @id LIMIT 1");
        }

        public void UpdateStatus(SqlDatabaseClient MySqlClient, ModerationTicketStatus NewStatus)
        {
            mStatus = NewStatus;
          
            MySqlClient.SetParameter("id", mId);
            MySqlClient.SetParameter("status", (int)NewStatus);
            MySqlClient.ExecuteNonQuery("UPDATE moderation_tickets SET status = @status WHERE id = @id LIMIT 1");      
        }
    }
}
