using System;

namespace Snowlight.Communication.Outgoing
{
    public static class HelpCfhClosedResultComposer
    {
        public static ServerMessage Compose(int Code)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_CFH_CLOSED_RESULT);
            Message.AppendInt32(Code);
            return Message;
        }
    }
}
