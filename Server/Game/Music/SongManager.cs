using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;

using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Rooms;
using Snowlight.Game.Items;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Music
{
    public static class SongManager
    {
        private const int CACHE_LIFETIME = 180;

        private static Dictionary<uint, SongData> mSongCache;
        private static Dictionary<uint, double> mCacheTimer;
        private static Thread mCacheMonitorThread;
        private static object mSyncRoot;

        public static void Initialize()
        {
            mSongCache = new Dictionary<uint, SongData>();
            mCacheTimer = new Dictionary<uint, double>();
            mSyncRoot = new object();

            mCacheMonitorThread = new Thread(new ThreadStart(ProcessThread));
            mCacheMonitorThread.Priority = ThreadPriority.Lowest;
            mCacheMonitorThread.Name = "SongCacheManager";
            mCacheMonitorThread.Start();

            DataRouter.RegisterHandler(OpcodesIn.GET_MUSIC_DATA, new ProcessRequestCallback(GetSongData));
            DataRouter.RegisterHandler(OpcodesIn.JUKEBOX_PLAYLIST_ADD, new ProcessRequestCallback(AddToPlaylist));
            DataRouter.RegisterHandler(OpcodesIn.JUKEBOX_PLAYLIST_REMOVE, new ProcessRequestCallback(RemoveFromPlaylist));
            DataRouter.RegisterHandler(OpcodesIn.JUKEBOX_GET_DISKS, new ProcessRequestCallback(GetDisks));
            DataRouter.RegisterHandler(OpcodesIn.JUKEBOX_GET_PLAYLIST, new ProcessRequestCallback(GetPlaylist));
        }

        public static void ProcessThread()
        {
            try
            {
                while (Program.Alive)
                {
                    Thread.Sleep(5000);

                    double CurrentTime = UnixTimestamp.GetCurrent();

                    lock (mSyncRoot)
                    {
                        List<uint> ToRemove = new List<uint>();

                        foreach (KeyValuePair<uint, double> CacheData in mCacheTimer)
                        {
                            if (CurrentTime - CacheData.Value >= CACHE_LIFETIME)
                            {
                                ToRemove.Add(CacheData.Key);
                            }
                        }

                        foreach (uint RemoveId in ToRemove)
                        {
                            mSongCache.Remove(RemoveId);
                            mCacheTimer.Remove(RemoveId);
                        }
                    }
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }

        public static SongData GetSongFromDataRow(DataRow Row)
        {
            return new SongData((uint)Row["id"], (string)Row["name"], (string)Row["artist"], (string)Row["song_data"],
                (double)Row["length"]);
        }

        public static SongData GetSong(uint SongId)
        {
            lock (mSyncRoot)
            {
                if (mSongCache.ContainsKey(SongId))
                {
                    double CacheTime = UnixTimestamp.GetCurrent() - mCacheTimer[SongId];

                    if (CacheTime >= CACHE_LIFETIME)
                    {
                        mSongCache.Remove(SongId);
                        mCacheTimer.Remove(SongId);
                    }
                    else
                    {
                        return mSongCache[SongId];
                    }
                }
            }

            SongData Song = null;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("id", SongId);
                DataRow Row = MySqlClient.ExecuteQueryRow("SELECT * FROM songs WHERE id = @id LIMIT 1");

                if (Row != null)
                {
                    Song = GetSongFromDataRow(Row);

                    lock (mSyncRoot)
                    {
                        mSongCache.Add(Song.Id, Song);
                        mCacheTimer.Add(Song.Id, UnixTimestamp.GetCurrent());
                    }
                }
            }

            return Song;
        }

        private static void GetSongData(Session Session, ClientMessage Message)
        {
            int Amount = Message.PopWiredInt32();
            List<SongData> Songs = new List<SongData>();

            for (int i = 0; i < Amount; i++)
            {
                SongData Song = GetSong(Message.PopWiredUInt32());

                if (Song == null)
                {
                    continue;
                }

                Songs.Add(Song);
            }

            Session.SendData(SongDataComposer.Compose(Songs));
        }

        private static void AddToPlaylist(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true) || Instance.MusicController == null ||
                Instance.MusicController.PlaylistSize >= Instance.MusicController.PlaylistCapacity)
            {
                return;
            }

            Item DiskItem = Session.InventoryCache.GetItem(Message.PopWiredUInt32());

            if (DiskItem == null || DiskItem.Definition.Behavior != ItemBehavior.MusicDisk)
            {
                return;
            }

            int NewOrder = Instance.MusicController.AddDisk(DiskItem);

            if (NewOrder < 0)
            {
                return;
            }
 
            Session.InventoryCache.RemoveItem(DiskItem.Id);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                DiskItem.MoveToSoundManager(MySqlClient, Instance.MusicController.LinkedItemId, NewOrder);
            }

            Session.SendData(InventoryItemRemovedComposer.Compose(DiskItem.Id));
            Session.SendData(JukeboxPlaylistComposer.Compose(Instance.MusicController.PlaylistCapacity,
                Instance.MusicController.Playlist.Values.ToList()));
        }

        private static void RemoveFromPlaylist(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || Instance.MusicController == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Item TakenItem = Instance.MusicController.RemoveDisk(Message.PopWiredInt32());
            // playlist will skip to the next item automatically if it has to

            if (TakenItem == null)
            {
                return;
            }

            Session.InventoryCache.Add(TakenItem);

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                TakenItem.MoveToUserInventory(MySqlClient, Session.CharacterId);
            }

            Session.SendData(InventoryItemAddedComposer.Compose(TakenItem));
            Session.SendData(JukeboxDisksComposer.Compose(Session));
            Session.SendData(JukeboxPlaylistComposer.Compose(Instance.MusicController.PlaylistCapacity,
                Instance.MusicController.Playlist.Values.ToList()));
        }

        private static void GetDisks(Session Session, ClientMessage Message)
        {
            Session.SendData(JukeboxDisksComposer.Compose(Session));
        }

        private static void GetPlaylist(Session Session, ClientMessage Message)
        {
            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);

            if (Instance == null || !Instance.CheckUserRights(Session, true))
            {
                return;
            }

            Session.SendData(JukeboxPlaylistComposer.Compose(Instance.MusicController.PlaylistCapacity,
                Instance.MusicController.Playlist.Values.ToList()));
        }
    }
}
