using System;
using System.Collections.Generic;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class FuseRightsListComposer
    {
        public static ServerMessage Compose(Session Session)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_RIGHTS);

            if (Session.HasRight("club_vip"))
            {
                Message.AppendInt32(2);
            }
            else if (Session.HasRight("club_regular"))
            {
                Message.AppendInt32(1);
            }
            else
            {
                Message.AppendInt32(0);
            }

            // TODO: Dig in to the mod tool and other staff stuff further to figure out how much this does

            Message.AppendInt32(Session.HasRight("hotel_admin") ? 1000 : 0);

            return Message;
        }
    }
}
