using System;

using Snowlight.Game.Items;

namespace Snowlight.Game.Music
{
    public class SongInstance
    {
        private Item mDiskItem;
        private SongData mSongData;

        public Item DiskItem
        {
            get
            {
                return mDiskItem;
            }
        }

        public SongData SongData
        {
            get
            {
                return mSongData;
            }
        }

        public SongInstance(Item Item, SongData SongData)
        {
            mDiskItem = Item;
            mSongData = SongData;
        }
    }
}
