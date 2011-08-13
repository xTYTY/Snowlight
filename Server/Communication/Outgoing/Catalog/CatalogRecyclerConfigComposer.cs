using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogRecyclerConfigComposer
    {
        public static ServerMessage Compose(bool Bool1, bool Bool2)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_RECYLCER_CONFIG);
            Message.AppendBoolean(Bool1);
            Message.AppendBoolean(Bool2);
            return Message;
        }
    }
}
