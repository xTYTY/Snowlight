using System;
using System.Collections.Generic;
using System.Threading;

namespace Snowlight.Communication.ResponseCache
{
    public class ResponseCacheController : IDisposable
    {
        private int mCacheItemLifetime;
        private int mCacheMaxCapacity;
        private List<ResponseCacheItem> mCachedResponses;
        private Timer mCacheMonitor;

        public ResponseCacheController(int ItemLifetime, int MaxCapacity = 10000)
        {
            mCacheItemLifetime = ItemLifetime;
            mCacheMaxCapacity = MaxCapacity;
            mCachedResponses = new List<ResponseCacheItem>(MaxCapacity);

            mCacheMonitor = new Timer(new TimerCallback(ProcessCacheMonitor), null, TimeSpan.FromSeconds(mCacheItemLifetime), TimeSpan.FromSeconds(mCacheItemLifetime));
        }

        public void Dispose()
        {
            if (mCacheMonitor != null)
            {
                mCacheMonitor.Dispose();
                mCacheMonitor = null;
            }

            if (mCachedResponses != null)
            {
                mCachedResponses.Clear();
                mCachedResponses = null;
            }
        }

        private void ProcessCacheMonitor(object state)
        {
            lock (mCachedResponses)
            {
                mCachedResponses.Clear();
            }
        }

        public void ClearCache()
        {
            lock (mCachedResponses)
            {
                mCachedResponses.Clear();
            }
        }

        public void ClearCacheGroup(uint GroupId)
        {
            lock (mCachedResponses)
            {
                List<ResponseCacheItem> ToRemove = new List<ResponseCacheItem>();

                foreach (ResponseCacheItem Item in mCachedResponses)
                {
                    if (Item.GroupId == GroupId)
                    {
                        ToRemove.Add(Item);
                    }
                }

                foreach (ResponseCacheItem RemoveItem in ToRemove)
                {
                    mCachedResponses.Remove(RemoveItem);
                }
            }
        }

        public ServerMessage TryGetResponse(uint GroupId, ClientMessage Request)
        {
            lock (mCachedResponses)
            {
                foreach (ResponseCacheItem Item in mCachedResponses)
                {
                    if (Item.GroupId == GroupId && Item.Request.ToString() == Request.ToString())
                    {
                        return Item.Response;
                    }
                }
            }

            return null;
        }

        public void AddIfNeeded(uint GroupId, ClientMessage Request, ServerMessage Response)
        {
            lock (mCachedResponses)
            {
                if (mCachedResponses.Count > mCacheMaxCapacity)
                {
                    // capacity has been reached, to protect overflow remove the oldest element in the cache immediatly..
                    mCachedResponses.RemoveAt(mCachedResponses.Count - 1);
                }

                foreach (ResponseCacheItem Item in mCachedResponses)
                {
                    if (Item.GroupId == GroupId && Item.Request.ToString() == Request.ToString())
                    {
                        return;
                    }
                }

                ResponseCacheItem NewItem = new ResponseCacheItem(GroupId, Request, Response);
                mCachedResponses.Add(NewItem);
            }
        }
    }
}
