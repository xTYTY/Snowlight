using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserTagsComposer
    {
        public static ServerMessage Compose(uint UserId, ReadOnlyCollection<string> Tags)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_TAGS);
            Message.AppendUInt32(UserId);
            Message.AppendInt32(Tags.Count);

            foreach (string Tag in Tags)
            {
                Message.AppendStringWithBreak(Tag);
            }

            return Message;
        }
    }
}
