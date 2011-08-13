using System;

namespace Snowlight.Communication.Outgoing
{
    public static class MusicPlayingComposer
    {
        public static ServerMessage Compose(uint SongId, int PlaylistItemNumber, int SyncTimestampMs)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MUSIC_PLAYING);

            if (SongId == 0)
            {
                Message.AppendInt32(-1);
                Message.AppendInt32(-1);
                Message.AppendInt32(-1);
                Message.AppendInt32(-1);
                Message.AppendInt32(0);
            }
            else
            {
                Message.AppendUInt32(SongId);
                Message.AppendInt32(PlaylistItemNumber);
                Message.AppendUInt32(SongId);
                Message.AppendInt32(0);
                Message.AppendInt32(SyncTimestampMs);
            }

            return Message;
        }
    }
}
