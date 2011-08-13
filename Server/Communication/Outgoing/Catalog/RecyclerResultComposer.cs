using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RecyclerResultComposer
    {
        public static ServerMessage Compose(bool Success, uint ItemId)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_RECYCLER_RESULT);
            Message.AppendBoolean(Success);
            Message.AppendUInt32(ItemId);
            return Message;
        }
    }
}
