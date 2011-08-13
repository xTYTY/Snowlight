using System;
using System.Collections.Generic;

using Snowlight.Specialized;
using Snowlight.Game.Characters;

namespace Snowlight.Communication.Outgoing
{
    public static class UserWardrobeComposer
    {
        public static ServerMessage Compose(Dictionary<int, WardrobeItem> WardrobeItems)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_WARDROBE);
            Message.AppendBoolean(true); // used to indicate usage right. useless nowadays.
            Message.AppendInt32(WardrobeItems.Count);

            foreach (KeyValuePair<int, WardrobeItem> Item in WardrobeItems)
            {
                Message.AppendInt32(Item.Key);
                Message.AppendStringWithBreak(Item.Value.Figure);
                Message.AppendStringWithBreak(Item.Value.Gender == CharacterGender.Male ? "M" : "F");
            }

            return Message;
        }
    }
}
