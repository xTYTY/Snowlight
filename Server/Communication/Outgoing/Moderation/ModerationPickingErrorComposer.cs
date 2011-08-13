using System;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationPickingErrorComposer
    {
        public static ServerMessage Compose()
        {
            return new ServerMessage(OpcodesOut.MODERATION_PICKING_ERROR);
        }
    }
}
