using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogRedeemOkComposer
    {
        public static ServerMessage Compose()
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_REDEEM_OK);
            return Message;
        }
    }
}