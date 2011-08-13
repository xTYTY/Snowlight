using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CreditsBalanceComposer
    {
        public static ServerMessage Compose(int Balance)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CREDITS_BALANCE);
            Message.AppendStringWithBreak(Balance.ToString() + ".0");
            return Message;
        }
    }
}
