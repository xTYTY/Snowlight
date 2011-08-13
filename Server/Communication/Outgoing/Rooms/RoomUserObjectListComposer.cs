using System;
using System.Collections.Generic;

using Snowlight.Game.Rooms;
using Snowlight.Game.Characters;
using Snowlight.Game.Bots;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserObjectListComposer
    {
        public static ServerMessage Compose(List<RoomActor> Actors)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_LIST);
            Message.AppendInt32(Actors.Count);

            foreach (RoomActor Actor in Actors)
            {
                bool IsBot = (Actor.Type == RoomActorType.AiBot);
                Bot BotData = (IsBot ? (Bot)Actor.ReferenceObject : null);
                bool IsPet = (BotData != null && BotData.IsPet);

                if (IsBot && !IsPet)
                {
                    Message.AppendInt32(-1);
                }
                else
                {
                    Message.AppendUInt32(Actor.ReferenceId);
                }

                Message.AppendStringWithBreak(Actor.Name);
                Message.AppendStringWithBreak(Actor.Motto);
                Message.AppendStringWithBreak(Actor.Figure);
                Message.AppendUInt32(Actor.Id);
                Message.AppendInt32(Actor.Position.X);
                Message.AppendInt32(Actor.Position.Y);
                Message.AppendRawDouble(Actor.Position.Z);

                Message.AppendInt32(Actor.Type == RoomActorType.UserCharacter ? 2 : 4); // 2 for user, 4 for bot
                Message.AppendInt32(Actor.Type == RoomActorType.UserCharacter ? 1 : (((Bot)Actor.ReferenceObject).BehaviorType == "pet" ? 2 : 3)); // 1 for user, 2 for pet, 3 for other bot

                if (!IsBot)
                {
                    Message.AppendStringWithBreak(((CharacterInfo)Actor.ReferenceObject).Gender == CharacterGender.Male ? "m" : "f");
                    Message.AppendInt32(-1); // Unknown
                    Message.AppendInt32(-1); // Group ID
                    Message.AppendInt32(-1); // Unknown (sometimes -1, sometimes 1)
                    Message.AppendStringWithBreak(string.Empty);
                    Message.AppendInt32(((CharacterInfo)Actor.ReferenceObject).Score);
                }
                else if (IsPet)
                {
                    Message.AppendInt32(500);
                }
            }

            return Message;
        }
    }
}
