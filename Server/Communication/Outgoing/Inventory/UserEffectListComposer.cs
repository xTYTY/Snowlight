using System;
using System.Collections.Generic;

using Snowlight.Game.AvatarEffects;
using Snowlight.Specialized;

namespace Snowlight.Communication.Outgoing
{
    public static class UserEffectListComposer
    {
        public static ServerMessage Compose(Dictionary<uint, AvatarEffect> Effects)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.USER_EFFECT_LIST);
            Message.AppendInt32(Effects.Count);

            foreach (AvatarEffect Effect in Effects.Values)
            {
                Message.AppendInt32(Effect.SpriteId);
                Message.AppendInt32((int)Effect.Duration);
                Message.AppendInt32(Effect.Activated ? Effect.Quantity - 1 : Effect.Quantity);
                Message.AppendInt32(Effect.Activated ? (int)Effect.TimeLeft : -1);
            }
           
            return Message;
        }
    }
}
