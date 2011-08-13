using System;

namespace Snowlight.Communication.ResponseCache
{
    public class ResponseCacheItem
    {
        private uint mGroupId;
        private ClientMessage mRequest;
        private ServerMessage mResponse;

        public uint GroupId
        {
            get
            {
                return mGroupId;
            }
        }

        public ClientMessage Request
        {
            get
            {
                return mRequest;
            }
        }

        public ServerMessage Response
        {
            get
            {
                return mResponse;
            }
        }

        public ResponseCacheItem(uint GroupId, ClientMessage Request, ServerMessage Response)
        {
            mGroupId = GroupId;
            mRequest = Request;
            mResponse = Response;
        }
    }
}
