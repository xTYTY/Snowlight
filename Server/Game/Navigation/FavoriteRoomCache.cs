using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Text;

using Snowlight.Storage;

namespace Snowlight.Game.Navigation
{
    public class FavoriteRoomsCache : IDisposable
    {
        private uint mCharacterId;
        private List<uint> mInner;

        public ReadOnlyCollection<uint> FavoriteRooms
        {
            get
            {
                lock (mInner)
                {
                    List<uint> Copy = new List<uint>();
                    Copy.AddRange(mInner);
                    return Copy.AsReadOnly();
                }
            }
        }

        public FavoriteRoomsCache(SqlDatabaseClient MySqlClient, uint CharacterId)
        {
            mCharacterId = CharacterId;
            mInner = new List<uint>();

            ReloadCache(MySqlClient);
        }

        public void ReloadCache(SqlDatabaseClient MySqlClient)
        {
            lock (mInner)
            {
                mInner.Clear();

                MySqlClient.SetParameter("characterid", mCharacterId);
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT room_id FROM favorites WHERE user_id = @characterid LIMIT " + Navigator.MaxFavoritesPerUser);

                foreach (DataRow Row in Table.Rows)
                {
                    mInner.Add((uint)Row["room_id"]);
                }             
            }
        }

        public void Dispose()
        {
            if (mInner != null)
            {
                mInner.Clear();
                mInner = null;
            }
        }

        public bool AddRoomToFavorites(uint RoomId)
        {
            lock (mInner)
            {
                if (mInner.Contains(RoomId) || mInner.Count >= Navigator.MaxFavoritesPerUser)
                {
                    return false;
                }

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("userid", mCharacterId);
                    MySqlClient.SetParameter("roomid", RoomId);
                    MySqlClient.ExecuteNonQuery("INSERT INTO favorites (user_id,room_id) VALUES (@userid,@roomid)");
                }

                mInner.Add(RoomId);
            }

            return true;
        }

        public bool RemoveRoomFromFavorites(uint RoomId)
        {
            lock (mInner)
            {
                if (!mInner.Contains(RoomId))
                {
                    return false;
                }

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    MySqlClient.SetParameter("userid", mCharacterId);
                    MySqlClient.SetParameter("roomid", RoomId);
                    MySqlClient.ExecuteNonQuery("DELETE FROM favorites WHERE user_id = @userid AND room_id = @roomid LIMIT 1");
                }

                mInner.Remove(RoomId);
            }

            return true;
        }
    }
}
