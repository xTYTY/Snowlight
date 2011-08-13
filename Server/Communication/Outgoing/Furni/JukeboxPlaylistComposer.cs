using System;
using System.Collections.Generic;

using Snowlight.Game.Music;

namespace Snowlight.Communication.Outgoing
{
    public static class JukeboxPlaylistComposer
    {
        public static ServerMessage Compose(int PlaylistCapacity, List<SongInstance> Playlist)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.JUKEBOX_PLAYLIST);
            Message.AppendInt32(PlaylistCapacity);
            Message.AppendInt32(Playlist.Count);

            foreach (SongInstance Song in Playlist)
            {
                Message.AppendUInt32(Song.DiskItem.Id);
                Message.AppendUInt32(Song.SongData.Id);
            }

            return Message;
        }
    }
}
