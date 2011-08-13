using System;
using System.Collections.Generic;
using Snowlight.Config;
using MySql.Data.MySqlClient;
using System.Threading;

namespace Snowlight.Storage
{
    public static class SqlDatabaseManager
    {
        private static Dictionary<int, SqlDatabaseClient> mClients;
        private static int mStarvationCounter;
        private static int mMinPoolSize;
        private static int mMaxPoolSize;
        private static int mPoolLifetime;
        private static int mClientIdGenerator;
        private static object mSyncRoot;

        public static int ClientCount
        {
            get
            {
                return mClients.Count;
            }
        }

        public static void Initialize()
        {
            mClients = new Dictionary<int, SqlDatabaseClient>();
            mMinPoolSize = (int)ConfigManager.GetValue("mysql.pool.min");
            mMaxPoolSize = (int)ConfigManager.GetValue("mysql.pool.max");
            mPoolLifetime = (int)ConfigManager.GetValue("mysql.pool.lifetime");
            mSyncRoot = new object();

            Thread MonitorThread = new Thread(new ThreadStart(ProcessMonitorThread));
            MonitorThread.Priority = ThreadPriority.Lowest;
            MonitorThread.Name = "SqlMonitor";
            MonitorThread.Start();

            if (mMinPoolSize < 0)
            {
                throw new ArgumentException("(Sql) Invalid database pool size configured (less than zero).");
            }

            SetClientAmount(mMinPoolSize, "server init");
        }

        public static void Uninitialize()
        {           
            int Attempts = 0;

            while (mClients.Count > 0)
            {
                lock (mSyncRoot)
                {
                    List<int> Removable = new List<int>();

                    foreach (SqlDatabaseClient Client in mClients.Values)
                    {
                        if (!Client.Available && Attempts <= 15)
                        {
                            continue;
                        }

                        Removable.Add(Client.Id);
                    }

                    foreach (int RemoveId in Removable)
                    {
                        mClients[RemoveId].Close();
                        mClients.Remove(RemoveId);
                    }
                }

                if (mClients.Count > 0)
                {
                    Output.WriteLine("(Sql) Waiting for all database clients to release (" + ++Attempts + ")...", OutputLevel.DebugInformation);
                    Thread.Sleep(100);
                }
            }          
        }

        public static void ProcessMonitorThread()
        {
            while (Program.Alive)
            {
                if (ClientCount > mMinPoolSize)
                {
                    lock (mSyncRoot)
                    {
                        List<int> ToDisconnect = new List<int>();
                        
                        foreach (SqlDatabaseClient Client in mClients.Values)
                        {
                            if (Client.Available && Client.TimeInactive >= mPoolLifetime)
                            {
                                ToDisconnect.Add(Client.Id);
                            }
                        }

                        foreach (int DisconnectId in ToDisconnect)
                        {
                            mClients[DisconnectId].Close();
                            mClients.Remove(DisconnectId);
                        }

                        if (ToDisconnect.Count > 0)
                        {
                            Output.WriteLine("(Sql) Disconnected " + ToDisconnect.Count + " inactive client(s).",
                                OutputLevel.DebugInformation);
                        }
                    }
                }

                Thread.Sleep(mPoolLifetime / 2);
            }
        }

        public static void SetClientAmount(int ClientAmount, string LogReason = "Unknown")
        {
            int Diff;

            lock (mSyncRoot)
            {
                Diff = ClientAmount - ClientCount;

                if (Diff > 0)
                {
                    for (int i = 0; i < Diff; i++)
                    {
                        int NewId = GenerateClientId();
                        mClients.Add(NewId, CreateClient(NewId));
                    }
                }
                else
                {
                    int ToDestroy = -Diff;
                    int Destroyed = 0;

                    foreach (SqlDatabaseClient Client in mClients.Values)
                    {
                        if (!Client.Available)
                        {
                            continue;
                        }

                        if (Destroyed >= ToDestroy || ClientCount <= mMinPoolSize)
                        {
                            break;
                        }

                        Client.Close();
                        mClients.Remove(Client.Id);
                        Destroyed++;
                    }
                }
            }

            Output.WriteLine("(Sql) Client availability: " + ClientAmount + "; modifier: " + Diff + "; reason: "
                + LogReason + ".", OutputLevel.DebugInformation);
        }

        public static SqlDatabaseClient GetClient()
        {
            lock (mSyncRoot)
            {
                foreach (SqlDatabaseClient Client in mClients.Values)
                {
                    if (!Client.Available)
                    {
                        continue;
                    }

                    Output.WriteLine("(Sql) Assigned client " + Client.Id + ".", OutputLevel.DebugInformation);
                    Client.Available = false;
                    return Client;
                }

                if (mMaxPoolSize <= 0 || ClientCount < mMaxPoolSize) // Max pool size ignored if set to 0 or lower
                {
                    SetClientAmount(ClientCount + 1, "out of assignable clients in GetClient()");
                    return GetClient();
                }
            }

            mStarvationCounter++;

            Output.WriteLine("(Sql) Client starvation; out of assignable clients/maximum pool size reached. Consider increasing the `mysql.pool.max` configuration value. Starvation count is " + mStarvationCounter + ".", OutputLevel.Warning);

            // Wait for a bit and try again, we have exceeded all our limits and have nothing available.
            Thread.Sleep(100);
            return GetClient();
        }

        private static int GenerateClientId()
        {
            lock (mSyncRoot)
            {
                return mClientIdGenerator++;
            }
        }

        private static SqlDatabaseClient CreateClient(int Id)
        {
            MySqlConnection Connection = new MySqlConnection(GenerateConnectionString());
            Connection.Open();

            return new SqlDatabaseClient(Id, Connection);
        }

        public static string GenerateConnectionString()
        {
            MySqlConnectionStringBuilder ConnectionStringBuilder = new MySqlConnectionStringBuilder();
            ConnectionStringBuilder.Server = (string)ConfigManager.GetValue("mysql.host");
            ConnectionStringBuilder.Port = (uint)(int)ConfigManager.GetValue("mysql.port");
            ConnectionStringBuilder.UserID = (string)ConfigManager.GetValue("mysql.user");
            ConnectionStringBuilder.Password = (string)ConfigManager.GetValue("mysql.pass");
            ConnectionStringBuilder.Database = (string)ConfigManager.GetValue("mysql.dbname");
            ConnectionStringBuilder.MinimumPoolSize = (uint)(int)ConfigManager.GetValue("mysql.pool.min");
            ConnectionStringBuilder.MaximumPoolSize = (uint)(int)ConfigManager.GetValue("mysql.pool.max");
            return ConnectionStringBuilder.ToString();
        }
    }
}
