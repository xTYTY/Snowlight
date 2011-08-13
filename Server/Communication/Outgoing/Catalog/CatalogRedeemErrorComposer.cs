using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogRedeemErrorComposer
    {
        public static ServerMessage Compose(int Code)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_REDEEM_ERROR);
            Message.AppendRawInt32(Code);
            return Message;
        }
    }
}
