using System;

namespace Snowlight.Communication.Outgoing
{
    public static class SessionParamsComposer
    {
        public static ServerMessage Compose()
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.SESSION_PARAMS);
            Message.AppendInt32(9);
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            Message.AppendInt32(1);
            Message.AppendInt32(1);
            Message.AppendInt32(3);
            Message.AppendInt32(0);
            Message.AppendInt32(2);
            Message.AppendInt32(0);
            Message.AppendInt32(4);
            Message.AppendInt32(1);
            Message.AppendInt32(5);
            Message.AppendStringWithBreak("dd-MM-yyyy");
            Message.AppendInt32(7);
            Message.AppendInt32(0);
            Message.AppendInt32(8);
            Message.AppendStringWithBreak("http://hotel-us");
            Message.AppendInt32(9);
            Message.AppendInt32(0);
            return Message;
        }
    }
}
