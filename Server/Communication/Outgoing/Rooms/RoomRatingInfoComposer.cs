using System;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomRatingInfoComposer
    {
        public static ServerMessage Compose(int RatingData)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_RATING_INFO);
            Message.AppendInt32(RatingData);
            return Message;
        }
    }
}
