using System;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogVerifyPetNameResultComposer
    {
        public static ServerMessage Compose(int Code)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_VERIFY_PET_NAME_RESULT);
            Message.AppendInt32(Code);
            return Message;
        }
    }
}
