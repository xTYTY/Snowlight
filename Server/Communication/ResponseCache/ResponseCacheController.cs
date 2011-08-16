using System;
using System.Collections.Generic;
using System.Threading;

namespace Snowlight.Communication.ResponseCache
{
    public class ResponseCacheController : IDisposable
    {
        private int mCacheItemLifetime;
        private List<ResponseCacheItem> mCachedResponses;
        private Timer mCacheMonitor;

        public ResponseCacheController(int ItemLifetime)
        {
            mCacheItemLifetime = ItemLifetime;
            mCachedResponses = new List<ResponseCacheItem>();

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
