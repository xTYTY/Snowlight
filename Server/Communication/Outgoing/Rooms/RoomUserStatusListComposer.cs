using System;
using System.Collections.Generic;

using Snowlight.Game.Rooms;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomUserStatusListComposer
    {
        public static ServerMessage Compose(List<RoomActor> Actors)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_USER_STATUS_LIST);
            Message.AppendInt32(Actors.Count);

            foreach (RoomActor Actor in Actors)
            {
                // a|rBPCRB0.0JJ//
                Message.AppendUInt32(Actor.Id);
                Message.AppendInt32(Actor.Position.X);
                Message.AppendInt32(Actor.Position.Y);
                Message.AppendRawDouble(Actor.Position.Z);
                Message.AppendInt32(Actor.HeadRotation);
                Message.AppendInt32(Actor.BodyRotation);
                Message.AppendRawString("/");

                foreach (KeyValuePair<string, string> Status in Actor.UserStatusses)
                {
                    Message.AppendRawString(Status.Key + ' ' + Status.Value + '/');
                }

                Message.AppendStringWithBreak("/");
            }

            return Message;
        }
    }
}
