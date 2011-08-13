using System;
using Snowlight.Specialized;

namespace Snowlight.Communication.Outgoing
{
    public static class RollerEventComposer
    {
        public static ServerMessage Compose(Vector3 Source, Vector3 Target, uint RollerId, uint ActorId, uint ItemId)
        {
            bool ItemMode = ItemId > 0;

            ServerMessage Message = new ServerMessage(OpcodesOut.ROLLER_EVENT);
            Message.AppendInt32(Source.X);
            Message.AppendInt32(Source.Y);
            Message.AppendInt32(Target.X);
            Message.AppendInt32(Target.Y);
            Message.AppendBoolean(ItemMode);

            if (ItemMode)
            {
                Message.AppendUInt32(ItemId);
            }
            else
            {
                Message.AppendUInt32(RollerId);
                Message.AppendInt32(2);
                Message.AppendUInt32(ActorId);
            }

            Message.AppendRawDouble(Source.Z);
            Message.AppendRawDouble(Target.Z);

            if (ItemMode)
            {
                Message.AppendUInt32(RollerId);
            }

            return Message;
        }
    }
}
