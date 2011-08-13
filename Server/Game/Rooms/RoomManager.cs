using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Data;
using System.Linq;


using Snowlight.Specialized;
using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Rights;
using Snowlight.Game.Messenger;
using Snowlight.Game.Navigation;
using Snowlight.Game.Items;
using Snowlight.Game.Pets;

namespace Snowlight.Game.Rooms
{
    public static class RoomManager
    {
        #region Fields & Properties
        public const int ROOM_UPDATE_SPEED = 500;

        private static Thread mRoomInstanceThread;
        private static Thread mRoomWritebackThread;

        private static Dictionary<uint, RoomInstance> mRoomInstances;
        private static Dictionary<string, RoomModel> mRoomModels;

        private static Dictionary<Item, bool> mWritebackItems;
        private static List<Pet> mWritebackPets;
        
        private static uint mInstanceIdGenerator;
        private static object mIdGeneratorSyncLock;

        public static Dictionary<uint, RoomInstance> RoomInstances
        {
            get
            {
                return mRoomInstances;
            }
        }
        #endregion

        #region Initialization and collection management
        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mRoomInstances = new Dictionary<uint, RoomInstance>();
            mRoomModels = new Dictionary<string, RoomModel>();
            mWritebackItems = new Dictionary<Item, bool>();
            mWritebackPets = new List<Pet>();

            ReloadModels(MySqlClient);

            mRoomInstanceThread = new Thread(new ThreadStart(ProcessRooms));
            mRoomInstanceThread.Name = "RoomInstanceThread";
            mRoomInstanceThread.Priority = ThreadPriority.Highest;
            mRoomInstanceThread.Start();

            mRoomWritebackThread = new Thread(new ThreadStart(ProcessWritebacks));
            mRoomWritebackThread.Name = "RoomWritebackThread";
            mRoomWritebackThread.Priority = ThreadPriority.BelowNormal;
            mRoomWritebackThread.Start();

            mInstanceIdGenerator = 1;
            mIdGeneratorSyncLock = new object();
        }

        public static uint GenerateInstanceId()
        {
            lock (mIdGeneratorSyncLock)
            {
                return mInstanceIdGenerator++;
            }
        }

        public static void ReloadModels(SqlDatabaseClient MySqlClient)
        {
            lock (mRoomModels)
            {
                mRoomModels.Clear();

                MySqlClient.SetParameter("enabled", "1");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM room_models WHERE enabled = @enabled");

                foreach (DataRow Row in Table.Rows)
                {
                    mRoomModels.Add((string)Row["id"], new RoomModel((string)Row["id"], ((string)Row["type"] == "flat" ?
                        RoomModelType.Flat : RoomModelType.Public), new Heightmap((string)Row["heightmap"]),
                        new Vector3((int)Row["door_x"], (int)Row["door_y"], (double)Row["door_z"]), (int)Row["door_dir"],
                        (ClubSubscriptionLevel)(int.Parse(Row["subscription_requirement"].ToString())), (int)Row["max_users"]));
                }           
            }
        }

        public static RoomModel GetModel(string Id)
        {
            lock (mRoomModels)
            {
                foreach (RoomModel Model in mRoomModels.Values)
                {
                    if (Model.Id == Id)
                    {
                        return Model;
                    }
                }
            }

            return null;
        }
        #endregion

        #region Room Instance Process Thread
        private static void ProcessRooms()
        {
            try
            {
                while (Program.Alive)
                {
                    DateTime ExecStart = DateTime.Now;
                    Dictionary<uint, RoomInstance> Copy = new Dictionary<uint, RoomInstance>();

                    lock (mRoomInstances)
                    {
                        foreach (KeyValuePair<uint, RoomInstance> CopyItem in mRoomInstances)
                        {
                            Copy.Add(CopyItem.Key, CopyItem.Value);
                        }
                    }

                    List<uint> ToDispose = new List<uint>();
                    List<uint> ToUnload = new List<uint>();

                    foreach (RoomInstance Instance in Copy.Values)
                    {
                        if (Instance.Unloaded)
                        {
                            if (Instance.TimeUnloaded > 15)
                            {
                                ToDispose.Add(Instance.InstanceId);
                                continue;
                            }
                        }
                        else if (Instance.HumanActorCount == 0)
                        {
                            if (Instance.MarkedAsEmpty >= 10)
                            {
                                ToUnload.Add(Instance.InstanceId);
                            }
                            else
                            {
                                Instance.MarkedAsEmpty++;
                            }

                            continue;
                        }
                        else if (Instance.MarkedAsEmpty > 0)
                        {
                            Instance.MarkedAsEmpty = 0;
                        }

                        Instance.PerformUpdate();
                    }

                    lock (mRoomInstances)
                    {
                        foreach (uint UnloadId in ToUnload)
                        {
                            if (mRoomInstances.ContainsKey(UnloadId))
                            {
                                mRoomInstances[UnloadId].Unload();
                                Output.WriteLine("[RoomMgr] Unloaded room instance " + UnloadId + ".", OutputLevel.DebugInformation);
                            }
                        }

                        foreach (uint DisposeId in ToDispose)
                        {
                            if (mRoomInstances.ContainsKey(DisposeId))
                            {
                                mRoomInstances[DisposeId].Dispose();
                                mRoomInstances[DisposeId] = null;
                                mRoomInstances.Remove(DisposeId);
                                Output.WriteLine("[RoomMgr] Disposed of room instance " + DisposeId + " and associated resources.", OutputLevel.DebugInformation);
                            }
                        }
                    }

                    double Time = (ROOM_UPDATE_SPEED - ((TimeSpan)(DateTime.Now - ExecStart)).TotalMilliseconds);

                    if (Time < 0)
                    {
                        Time = 0;
                        Output.WriteLine("Can't keep up! Did the system time change, or is the server overloaded?", OutputLevel.Warning);
                    }

                    if (Time > ROOM_UPDATE_SPEED)
                    {
                        Time = ROOM_UPDATE_SPEED;
                    }

                    Thread.Sleep((int)Time);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }
        #endregion

        #region Database writeback management
        private static void ProcessWritebacks()
        {
            try
            {
                while (Program.Alive)
                {
                    // Item location/state writebacks
                    Dictionary<Item, bool> WritebackCopy = new Dictionary<Item, bool>();

                    lock (mWritebackItems)
                    {
                        foreach (KeyValuePair<Item, bool> CopyItem in mWritebackItems)
                        {
                            WritebackCopy.Add(CopyItem.Key, CopyItem.Value);
                        }

                        mWritebackItems.Clear();
                    }

                    if (WritebackCopy.Count > 0)
                    {
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            foreach (KeyValuePair<Item, bool> Item in WritebackCopy)
                            {
                                Item.Key.SynchronizeDatabase(MySqlClient, Item.Value);
                            }
                        }
                    }

                    // Actorcount writebacks
                    List<RoomInstance> InstanceCopy = new List<RoomInstance>();

                    lock (mRoomInstances)
                    {
                        foreach (RoomInstance CopyItem in mRoomInstances.Values)
                        {
                            InstanceCopy.Add(CopyItem);
                        }
                    }

                    foreach (RoomInstance Instance in InstanceCopy)
                    {
                        if (Instance.ActorCountDatabaseWritebackNeeded)
                        {
                            Instance.DoActorCountSync();
                        }
                    }

                    // Pet writebacks
                    List<Pet> PetWritebackCopy = new List<Pet>();

                    lock (mWritebackPets)
                    {
                        foreach (Pet CopyItem in mWritebackPets)
                        {
                            PetWritebackCopy.Add(CopyItem);
                        }

                        mWritebackPets.Clear();
                    }

                    if (PetWritebackCopy.Count > 0)
                    {
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            foreach (Pet Pet in PetWritebackCopy)
                            {
                                Pet.SynchronizeDatabase(MySqlClient);
                            }
                        }
                    }

                    Thread.Sleep(7500);
                }
            }
            catch (ThreadAbortException) { }
            catch (ThreadInterruptedException) { }
        }

        public static void MarkWriteback(Pet Pet)
        {
            lock (mWritebackPets)
            {
                if (mWritebackPets.Contains(Pet))
                {
                    return;
                }

                mWritebackPets.Add(Pet);
            }
        }

        public static void MarkWriteback(Item Item, bool FlagsOnly)
        {
            lock (mWritebackItems)
            {
                if (mWritebackItems.ContainsKey(Item))
                {
                    if (mWritebackItems[Item] == true && !FlagsOnly)
                    {
                        mWritebackItems[Item] = false;
                    }

                    return;
                }

                mWritebackItems.Add(Item, FlagsOnly);
            }
        }

        public static void UnmarkWriteback(Item Item)
        {
            lock (mWritebackItems)
            {
                mWritebackItems.Remove(Item);
            }
        }
        #endregion

        #region Instance/room data management
        public static bool InstanceIsLoadedForRoom(uint RoomId)
        {
            return (GetInstanceByRoomId(RoomId) != null);
        }

        public static bool TryLoadRoomInstance(uint RoomId)
        {
            lock (mRoomInstances)
            {
                RoomInstance OldInstance = GetInstanceByRoomId(RoomId);

                if (OldInstance != null)
                {
                    return false; // instance already exists, bail!
                }

                uint NewInstanceId = GenerateInstanceId();

                RoomInstance Instance = RoomInstance.TryCreateRoomInstance(NewInstanceId, RoomId);

                if (Instance == null)
                {
                    return false;
                }

                lock (mRoomInstances)
                {
                    mRoomInstances.Add(NewInstanceId, Instance);
                }

                Output.WriteLine("[RoomMgr] Room instance " + NewInstanceId + " has been loaded for room " + RoomId + ".", OutputLevel.DebugInformation);
            }
            return true;
        }

        public static RoomInstance GetInstanceByRoomId(uint RoomId)
        {
            lock (mRoomInstances)
            {
                foreach (RoomInstance Instance in mRoomInstances.Values)
                {
                    if (Instance.Unloaded)
                    {
                        continue;
                    }

                    if (Instance.Info.Id == RoomId)
                    {
                        return Instance;
                    }
                }
            }

            return null;
        }

        public static uint CreateRoom(uint OwnerId, string Name, string Model)
        {
            string Result = string.Empty;

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("type", "flat");
                MySqlClient.SetParameter("ownerid", OwnerId);
                MySqlClient.SetParameter("name", Name);
                MySqlClient.SetParameter("model", Model);
                Result = MySqlClient.ExecuteScalar("INSERT INTO rooms (type,owner_id,name,model) VALUES (@type,@ownerid,@name,@model); SELECT LAST_INSERT_ID();").ToString();
            }

            return (Result == string.Empty ? 0 : uint.Parse(Result));
        }

        public static void DeleteRoom(SqlDatabaseClient MySqlClient, uint RoomId)
        {
            MySqlClient.SetParameter("id", RoomId);
            MySqlClient.ExecuteNonQuery("DELETE FROM rooms WHERE id = @id LIMIT 1");

            MySqlClient.SetParameter("id", RoomId);
            MySqlClient.ExecuteNonQuery("DELETE FROM navigator_frontpage WHERE room_id = @id");
            
            RoomInfoLoader.RemoveFromCache(RoomId);
            Navigator.ReloadOfficialItems(MySqlClient);
        }

        public static bool RemoveUserFromRoom(Session Session, bool SendKick = true)
        {
            uint CurrentRoomId = Session.AbsoluteRoomId;
            bool Ok = false;

            if (CurrentRoomId > 0)
            {
                if (Session.RoomJoined)
                {
                    RoomInstance Instance = RoomManager.GetInstanceByRoomId(CurrentRoomId);

                    if (Instance != null)
                    {
                        Instance.RemoveCharacterFromRoom(Session.CharacterId);
                    }
                }

                Session.AbsoluteRoomId = 0;
                Session.RoomAuthed = false;
                Session.RoomJoined = false;

                MessengerHandler.MarkUpdateNeeded(Session, 0, false);

                Ok = true;
            }

            if (SendKick)
            {
                Session.SendData(RoomKickedComposer.Compose());
            }

            return Ok;
        }
        #endregion
    }
}
