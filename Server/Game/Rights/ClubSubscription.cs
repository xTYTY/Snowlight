using System;
using Snowlight.Storage;
using Snowlight.Game.Sessions;

namespace Snowlight.Game.Rights
{
    public enum ClubSubscriptionLevel
    {
        None = 0,
        BasicClub = 1,
        VipClub = 2
    }

    public class ClubSubscription
    {
        private uint mUserId;
        private ClubSubscriptionLevel mBaseLevel;
        private double mTimestampCreated;
        private double mTimestampExpire;
        private double mHcTime;
        private double mVipTime;

        public bool IsActive
        {
            get
            {
                return (mBaseLevel != ClubSubscriptionLevel.None && UnixTimestamp.GetCurrent() < mTimestampExpire);
            }
        }

        public ClubSubscriptionLevel SubscriptionLevel
        {
            get
            {
                return (IsActive ? mBaseLevel : ClubSubscriptionLevel.None);
            }
        }

        public double PastHcTime
        {
            get
            {
                double Time = mHcTime;

                if (mBaseLevel == ClubSubscriptionLevel.BasicClub)
                {
                    Time += (UnixTimestamp.GetCurrent() - mTimestampCreated);
                }

                return Time;
            }
        }

        public double PastVipTime
        {
            get
            {
                double Time = mVipTime;

                if (mBaseLevel == ClubSubscriptionLevel.VipClub)
                {
                    Time += (UnixTimestamp.GetCurrent() - mTimestampCreated);
                }

                return Time;
            }
        }

        public double TimeLeft
        {
            get
            {
                return (mTimestampExpire - UnixTimestamp.GetCurrent());
            }
        }

        public DateTime ExpireDateTime
        {
            get
            {
                return UnixTimestamp.GetDateTimeFromUnixTimestamp(mTimestampExpire);
            }
        }

        public double TimestampExpire
        {
            get
            {
                return mTimestampExpire;
            }
        }

        public ClubSubscription(uint UserId, ClubSubscriptionLevel BaseLevel, double TimestampCreated, double TimestampExpired,
            double HcTime, double VipTime)
        {
            mUserId = UserId;
            mBaseLevel = BaseLevel;
            mTimestampCreated = TimestampCreated;
            mTimestampExpire = TimestampExpired;
            mHcTime = HcTime;
            mVipTime = VipTime;        

            if (!IsActive)
            {
                if (mBaseLevel != ClubSubscriptionLevel.None)
                {
                    Expire();
                }
            }
        }

        public void Expire()
        {
            mHcTime = PastHcTime;
            mVipTime = PastVipTime;
            mBaseLevel = ClubSubscriptionLevel.None;
            mTimestampCreated = 0;
            mTimestampExpire = 0;       

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("userid", mUserId);
                MySqlClient.SetParameter("hctime", mHcTime);
                MySqlClient.SetParameter("viptime", mVipTime);
                MySqlClient.ExecuteNonQuery("UPDATE user_subscriptions SET subscription_level = '0', timestamp_created = 0, timestamp_expire = 0 WHERE user_id = @userid LIMIT 1");
            }
        }

        public void AddOrExtend(int Level, double ExtensionTime)
        {
            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                if (!IsActive)
                {
                    mTimestampCreated = UnixTimestamp.GetCurrent();
                    mTimestampExpire = UnixTimestamp.GetCurrent();
                }
                
                mTimestampExpire += ExtensionTime;
                mBaseLevel = (ClubSubscriptionLevel)Level;

                MySqlClient.SetParameter("userid", mUserId);
                bool CreateNewRecord = (MySqlClient.ExecuteScalar("SELECT null FROM user_subscriptions WHERE user_id = @userid LIMIT 1") == null);

                MySqlClient.SetParameter("userid", mUserId);
                MySqlClient.SetParameter("expirestamp", mTimestampExpire);
                MySqlClient.SetParameter("level", ((int)mBaseLevel).ToString());

                if (CreateNewRecord)
                {
                    MySqlClient.SetParameter("createstamp", UnixTimestamp.GetCurrent());
                    MySqlClient.ExecuteNonQuery("INSERT INTO user_subscriptions (user_id,subscription_level,timestamp_created,timestamp_expire) VALUES (@userid,@level,@createstamp,@expirestamp)");
                }
                else
                {
                    MySqlClient.ExecuteNonQuery("UPDATE user_subscriptions SET subscription_level = @level, timestamp_expire = @expirestamp WHERE user_id = @userid LIMIT 1");
                }
            }
        }
    }
}
