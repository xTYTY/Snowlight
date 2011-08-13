using System;

using Snowlight.Game.AvatarEffects;

namespace Snowlight.Communication.Outgoing
{
    public static class UserEffectRemovedComposer
    {
        public static ServerMessage Compose(AvatarEffect Effect)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_EFFECT_EXPIRED);
            Message.AppendInt32(Effect.SpriteId);
            return Message;
        }
    }
}
