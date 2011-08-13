using System;

namespace Snowlight.Communication.Outgoing
{
    public static class GenericErrorComposer
    {
        public static ServerMessage Compose(int ErrorCode)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.GENERIC_ERROR);
            Message.AppendInt32(ErrorCode);
            return Message;
        }
    }
}
