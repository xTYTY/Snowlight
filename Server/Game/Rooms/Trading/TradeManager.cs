using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Game.Rooms.Trading
{
    public class TradeManager
    {
        private Dictionary<uint, Trade> mTradeSessions;
        private object mSyncRoot;

        public TradeManager()
        {
            mTradeSessions = new Dictionary<uint, Trade>();
            mSyncRoot = new object();
        }

        public bool InitiateTrade(uint UserOne, uint UserTwo)
        {
            Trade Trade = new Trade(UserOne, UserTwo);

            lock (mSyncRoot)
            {
                if (mTradeSessions.ContainsKey(UserOne) || mTradeSessions.ContainsKey(UserTwo))
                {
                    return false;
                }

                mTradeSessions.Add(UserOne, Trade);
                mTradeSessions.Add(UserTwo, Trade);
            }

            return true;
        }

        public bool UserHasActiveTrade(uint UserId)
        {
            return (mTradeSessions.ContainsKey(UserId));
        }

        public Trade GetTradeForUser(uint UserId)
        {
            lock (mSyncRoot)
            {
                return mTradeSessions.ContainsKey(UserId) ? mTradeSessions[UserId] : null;
            }
        }

        public bool StopTradeForUser(uint UserId)
        {
            lock (mSyncRoot)
            {
                return mTradeSessions.Remove(UserId);
            }
        }
    }
}
