using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

using Snowlight.Game.Navigation;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorFavoriteRoomsComposer
    {
        public static ServerMessage Compose(ReadOnlyCollection<uint> FavoriteRooms)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_FAVORITE_ROOMS);
            Message.AppendInt32(Navigator.MaxFavoritesPerUser);
            Message.AppendInt32(FavoriteRooms.Count);

            foreach (uint Id in FavoriteRooms)
            {
                Message.AppendUInt32(Id);
            }

            return Message;
        }
    }
}
