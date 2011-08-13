using System;
using System.Collections.Generic;
using System.Threading;

namespace Snowlight.Communication.ResponseCache
{
    public class ResponseCacheController : IDisposable
    {
        private int mCacheItemLifetime;
        private List<ResponseCacheItem> mCachedResponses;
        private Thread mCacheMonitorThread;

        public ResponseCacheController(int ItemLifetime)
        {
            mCacheItemLifetime = ItemLifetime;
            mCachedResponses = new List<ResponseCacheItem>();

            mCacheMonitorThread = new Thread(new ThreadStart(ProcessCacheMonitor));
            mCacheMonitorThread.Priority = ThreadPriority.BelowNormal;
            mCacheMonitorThread.Name = "CacheControllerInstanceThread";
            mCacheMonitorThread.Start();
        }

        public void Dispose()
        {
            if (mCacheMonitorThread != null)
            {
                mCacheMonitorThread.Abort();
                mCacheMonitorThread = null;
            }

            if (mCachedResponses != null)
            {
                mCachedResponses.Clear();
                mCacheMonitorThread = null;
            }
        }

        private void ProcessCacheMonitor()
        {
            try
            {
                while (Program.Alive)
                {
                    lock (mCachedResponses)
                    {
                        mCachedResponses.Clear();
                    }

                    Thread.Sleep(mCacheItemLifetime * 1000);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
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
