using System;
using System.Collections.Generic;
using Snowlight.Util;

namespace Snowlight.Communication.Outgoing
{
    public static class MessengerRequestListComposer
    {
        public static ServerMessage Compose(List<uint> Requests)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MESSENGER_REQUESTS_LIST);
            Message.AppendInt32(Requests.Count);
            Message.AppendInt32(Requests.Count);

            foreach (uint RequestId in Requests)
            {
                Message.AppendUInt32(RequestId);
                Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(RequestId));
                Message.AppendStringWithBreak(RequestId.ToString());
            }

            return Message;
        }
    }
}
