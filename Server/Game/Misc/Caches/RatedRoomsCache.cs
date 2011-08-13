using System;
using System.Collections.Generic;

namespace Snowlight.Game.Misc
{
    public class RatedRoomsCache : IDisposable
    {
        private List<uint> mInner;

        public RatedRoomsCache()
        {
            mInner = new List<uint>();
        }

        public void Dispose()
        {
            if (mInner != null)
            {
                mInner.Clear();
                mInner = null;
            }
        }

        public void MarkRoomRated(uint RoomId)
        {
            lock (mInner)
            {
                if (!mInner.Contains(RoomId))
                {
                    mInner.Add(RoomId);
                }
            }
        }

        public bool HasRatedRoom(uint RoomId)
        {
            lock (mInner)
            {
                return mInner.Contains(RoomId);
            }
        }
    }
}
