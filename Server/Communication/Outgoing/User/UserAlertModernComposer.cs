using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Snowlight.Communication.Outgoing
{
    public static class UserAlertModernComposer
    {
        public static ServerMessage Compose(string Title, string Text)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_ALERT_MODERN);
            Message.AppendStringWithBreak(Title);
            Message.AppendStringWithBreak(Text);
            return Message;
        }
    }
}
