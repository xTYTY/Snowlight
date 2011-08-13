using System;

namespace Snowlight.Communication.Outgoing
{
    public enum CfhErrorCode
    {
        Ok = 0,
        AlreadyHaveCall = 1,
        AbusiveCooldown = 2
    }

    public static class HelpSubmitCfhResultComposer
    {
        public static ServerMessage Compose(CfhErrorCode Code)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_SUBMIT_CFH_RESULT);
            Message.AppendInt32((int)Code);
            return Message;
        }
    }
}
