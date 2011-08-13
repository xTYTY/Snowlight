using System;

namespace Snowlight.Game.Music
{
    public class SongData
    {
        private uint mId;
        private string mName;
        private string mArtist;
        private string mData;
        private double mLength;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Name
        {
            get
            {
                return mName;
            }
        }

        public string Artist
        {
            get
            {
                return mArtist;
            }
        }

        public string Data
        {
            get
            {
                return mData;
            }
        }

        public double LengthSeconds
        {
            get
            {
                return mLength;
            }
        }

        public int LengthMiliseconds
        {
            get
            {
                return (int)(mLength * 1000);
            }
        }

        public SongData(uint Id, string Name, string Artist, string Data, double Length)
        {
            mId = Id;
            mName = Name;
            mArtist = Artist;
            mData = Data;
            mLength = Length;
        }
    }
}
