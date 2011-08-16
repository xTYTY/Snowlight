using System;

namespace Snowlight.Communication.Outgoing
{
    public static class ErrorsComposer
    {
        public static ServerMessage Compose(int errorcode)
        {
            //Send a server error alert (connection.server.error)
            ServerMessage Message = new ServerMessage(OpcodesOut.ERROR_NOTIFICATION);
            Message.AppendInt32(1);
            Message.AppendInt32(errorcode);
            return Message;
        }
    }
}