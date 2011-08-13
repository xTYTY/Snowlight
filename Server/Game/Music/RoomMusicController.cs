using System;
using System.Collections.Generic;
using System.Linq;

using Snowlight.Game.Rooms;
using Snowlight.Game.Items;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Music
{
    public class RoomMusicController
    {
        private Dictionary<uint, Item> mLoadedDisks;
        private SortedDictionary<int, SongInstance> mPlaylist;
        private SongInstance mSong;
        private int mSongQueuePosition;
        private bool mIsPlaying;
        private double mStartedPlayingTimestamp;
        private Item mRoomOutputItem;
        private static bool mBroadcastNeeded;

        public SongInstance CurrentSong
        {
            get
            {
                return mSong;
            }
        }

        public bool IsPlaying
        {
            get
            {
                return mIsPlaying;
            }
        }

        public double TimePlaying
        {
            get
            {
                return UnixTimestamp.GetCurrent() - mStartedPlayingTimestamp;
            }
        }

        public int SongSyncTimestamp
        {
            get
            {
                if (!mIsPlaying || mSong == null)
                {
                    return 0;
                }

                if (TimePlaying >= mSong.SongData.LengthSeconds)
                {
                    return (int)mSong.SongData.LengthSeconds;
                }

                return (int)(TimePlaying * 1000);
            }
        }

        public SortedDictionary<int, SongInstance> Playlist
        {
            get
            {
                SortedDictionary<int, SongInstance> Copy = new SortedDictionary<int, SongInstance>();

                lock (mPlaylist)
                {
                    foreach (KeyValuePair<int, SongInstance> Data in mPlaylist)
                    {
                        Copy.Add(Data.Key, Data.Value);
                    }
                }

                return Copy;
            }
        }

        public int PlaylistCapacity
        {
            get
            {
                return (mRoomOutputItem == null ? 0 : mRoomOutputItem.Definition.BehaviorData);
            }
        }

        public int PlaylistSize
        {
            get
            {
                return mPlaylist.Count;
            }
        }

        public bool HasLinkedItem
        {
            get
            {
                return mRoomOutputItem != null;
            }
        }

        public uint LinkedItemId
        {
            get
            {
                return (mRoomOutputItem != null ? mRoomOutputItem.Id : 0);
            }
        }

        public int SongQueuePosition
        {
            get
            {
                return mSongQueuePosition;
            }
        }

        public RoomMusicController()
        {
            mLoadedDisks = new Dictionary<uint, Item>();
            mPlaylist = new SortedDictionary<int, SongInstance>();
        }

        public void LinkRoomOutputItem(Item Item)
        {
            mRoomOutputItem = Item;
        }

        public int AddDisk(Item DiskItem)
        {
            uint SongId = 0;
            uint.TryParse(DiskItem.DisplayFlags, out SongId);

            if (SongId == 0)
            {
                return -1;
            }

            SongData SongData = SongManager.GetSong(SongId);

            if (SongData == null)
            {
                return -1;
            }

            lock (mLoadedDisks)
            {
                mLoadedDisks.Add(DiskItem.Id, DiskItem);
            }

            int NewPlaylistId = mPlaylist.Count;

            lock (mPlaylist)
            {
                mPlaylist.Add(NewPlaylistId, new SongInstance(DiskItem, SongData));
            }

            return NewPlaylistId;
        }

        public Item RemoveDisk(int PlaylistIndex)
        {
            SongInstance Instance = null;

            lock (mPlaylist)
            {
                if (!mPlaylist.ContainsKey(PlaylistIndex))
                {
                    return null;
                }

                Instance = mPlaylist[PlaylistIndex];
                mPlaylist.Remove(PlaylistIndex);
            }

            lock (mLoadedDisks)
            {
                mLoadedDisks.Remove(Instance.DiskItem.Id);
            }

            RepairPlaylist();

            if (PlaylistIndex == mSongQueuePosition)
            {
                PlaySong();
            }

            return Instance.DiskItem;
        }

        public void Update(RoomInstance Instance)
        {
            if (mIsPlaying && (mSong == null || (TimePlaying >= (mSong.SongData.LengthSeconds + 1))))
            {
                if (mPlaylist.Count == 0)
                {
                    Stop();

                    mRoomOutputItem.DisplayFlags = "0";
                    mRoomOutputItem.BroadcastStateUpdate(Instance);

                    RoomManager.MarkWriteback(mRoomOutputItem, true);
                }
                else
                {
                    SetNextSong();
                }

                mBroadcastNeeded = true;
            }

            if (mBroadcastNeeded)
            {
                BroadcastCurrentSongData(Instance);
                mBroadcastNeeded = false;
            }
        }

        public void RepairPlaylist()
        {
            List<Item> LoadedDiskCopy = null;

            lock (mLoadedDisks)
            {
                LoadedDiskCopy = mLoadedDisks.Values.ToList();
                mLoadedDisks.Clear();
            }

            lock (mPlaylist)
            {
                mPlaylist.Clear();
            }

            foreach (Item LoadedDisk in LoadedDiskCopy)
            {
                AddDisk(LoadedDisk);
            } 
        }

        public void SetNextSong()
        {
            mSongQueuePosition++;
            PlaySong();
        }

        public void PlaySong()
        {
            if (mSongQueuePosition >= mPlaylist.Count)
            {
                mSongQueuePosition = 0;
            }

            if (mPlaylist.Count == 0)
            {
                Stop();
                return;
            }

            mSong = mPlaylist[mSongQueuePosition];
            mStartedPlayingTimestamp = UnixTimestamp.GetCurrent();
            mBroadcastNeeded = true;
        }

        public void Start()
        {
            mIsPlaying = true;
            mSongQueuePosition = -1;
            SetNextSong();
        }

        public void Stop()
        {
            mSong = null;
            mIsPlaying = false;
            mSongQueuePosition = -1;
        }

        public void BroadcastCurrentSongData(RoomInstance Instance)
        {
            Instance.BroadcastMessage(MusicPlayingComposer.Compose(mSong == null ? 0 : mSong.SongData.Id,
                mSongQueuePosition, 0));
        }

        public void Reset()
        {
            lock (mLoadedDisks)
            {
                mLoadedDisks.Clear();
            }

            lock (mPlaylist)
            {
                mPlaylist.Clear();
            }

            mRoomOutputItem = null;
            mSongQueuePosition = -1;
            mStartedPlayingTimestamp = 0;
        }
    }
}
