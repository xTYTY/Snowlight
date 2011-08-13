using System;

using Snowlight.Game.Music;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class SongDataComposer
    {
        public static ServerMessage Compose(List<SongData> Songs)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.SONG_DATA);
            Message.AppendInt32(Songs.Count);

            foreach (SongData Song in Songs)
            {
                Message.AppendUInt32(Song.Id);
                Message.AppendStringWithBreak(Song.Name);
                Message.AppendStringWithBreak(Song.Data);
                Message.AppendInt32(Song.LengthMiliseconds);
                Message.AppendStringWithBreak(Song.Artist);
            }

            return Message;
        }
    }
}
