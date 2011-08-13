using System;

namespace Snowlight.Communication.Outgoing
{
    public static class ActivityPointsBalanceComposer
    {
        public static ServerMessage Compose(int Balance, int NotifyAmount)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ACTIVITY_POINTS_BALANCE);
            Message.AppendInt32(Balance);
            Message.AppendInt32(NotifyAmount);
            return Message;
        }
    }
}
