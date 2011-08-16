using System;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Threading;
using Snowlight.Communication;
using Snowlight.Storage;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Moderation;

namespace Snowlight.Game.Sessions
{
    public static class SessionManager
    {
        private static Dictionary<uint, Session> mSessions;
        private static uint mCounter;
        private static List<uint> mSessionsToStop;
        private static Timer mMonitorThread;
        private static Timer mLatencyTestThread;
        private static object mSyncRoot;

        public static Dictionary<uint, Session> Sessions
        {
            get
            {
                Dictionary<uint, Session> Copy = new Dictionary<uint, Session>();

                lock (mSessions)
                {
                    foreach (KeyValuePair<uint, Session> Session in mSessions)
                    {
                        if (Session.Value.Stopped)
                        {
                            continue;
                        }

                        Copy.Add(Session.Key, Session.Value);
                    }
                }

                return new Dictionary<uint, Session>(Copy);
            }
        }

        public static Dictionary<uint, string> ConnectedUserData
        {
            get
            {
                Dictionary<uint, string> ConnectedUsers = new Dictionary<uint, string>();

                lock (mSessions)
                {
                    foreach (Session Session in mSessions.Values)
                    {
                        if (!Session.Authenticated)
                        {
                            continue;
                        }

                        ConnectedUsers.Add(Session.CharacterId, Session.CharacterInfo.Username);
                    }
                }

                return ConnectedUsers;
            }
        }

        public static int ActiveConnections
        {
            get
            {
                lock (mSessions)
                {
                    return mSessions.Count;
                }
            }
        }

        public static void Initialize()
        {
            mSessions = new Dictionary<uint, Session>();
            mSessionsToStop = new List<uint>();
            mCounter = 0;

            mMonitorThread = new Timer(new TimerCallback(ExecuteMonitor), null, TimeSpan.FromMilliseconds(300), TimeSpan.FromMilliseconds(300));
            mLatencyTestThread = new Timer(new TimerCallback(ExecuteLatencyMonitor), null, TimeSpan.FromSeconds(35), TimeSpan.FromSeconds(35));

            mSyncRoot = new object();
        }

        private static void ExecuteMonitor(object state)
        {
            List<Session> ToDispose = new List<Session>();
            List<Session> ToStop = new List<Session>();

            lock (mSessions)
            {
                lock (mSessionsToStop)
                {
                    foreach (uint SessionId in mSessionsToStop)
                    {
                        if (mSessions.ContainsKey(SessionId))
                        {
                            ToStop.Add(mSessions[SessionId]);
                        }
                    }

                    mSessionsToStop.Clear();
                }

                foreach (Session Session in mSessions.Values)
                {
                    if (ToStop.Contains(Session))
                    {
                        continue;
                    }

                    if (Session.Stopped)
                    {
                        if (Session.TimeStopped > 15)
                        {
                            ToDispose.Add(Session);
                        }

                        continue;
                    }
                }
            }

            if (ToStop.Count > 0)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    foreach (Session SessionStop in ToStop)
                    {
                        SessionStop.Stop(MySqlClient);
                    }
                }
            }

            foreach (Session SessionDispose in ToDispose)
            {
                SessionDispose.Dispose();

                lock (mSessions)
                {
                    if (mSessions.ContainsKey(SessionDispose.Id))
                    {
                        mSessions.Remove(SessionDispose.Id);
                    }
                }
            }
        }

        private static void ExecuteLatencyMonitor(object state)
        {
            ServerMessage PingMessage = PingComposer.Compose();

            lock (mSessions)
            {
                lock (mSessionsToStop)
                {
                    foreach (Session Session in mSessions.Values)
                    {
                        if (Session.Stopped || mSessionsToStop.Contains(Session.Id))
                        {
                            continue;
                        }

                        if (!Session.LatencyTestOk)
                        {
                            mSessionsToStop.Add(Session.Id);
                            continue;
                        }

                        Session.LatencyTestOk = false;
                        Session.SendData(PingMessage);
                    }
                }
            }
        }

        public static void StopSession(uint SessionId)
        {
            lock (mSessionsToStop)
            {
                mSessionsToStop.Add(SessionId);
            }
        }

        public static bool ContainsCharacterId(uint Uid)
        {
            lock (mSessions)
            {
                foreach (Session Session in mSessions.Values)
                {
                    if (!Session.Stopped && Session.CharacterId == Uid)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

        public static Session GetSessionByCharacterId(uint Id)
        {
            lock (mSessions)
            {
                foreach (Session Session in mSessions.Values)
                {
                    if (Session.Stopped)
                    {
                        continue;
                    }

                    if (Session.CharacterId == Id)
                    {
                        return Session;
                    }
                }
            }

            return null;
        }

        public static void BroadcastPacket(ServerMessage Message)
        {
            BroadcastPacket(Message.GetBytes(), string.Empty);
        }

        public static void BroadcastPacket(byte[] Data)
        {
            BroadcastPacket(Data, string.Empty);
        }

        public static void BroadcastPacket(ServerMessage Message, string RequiredRight)
        {
            BroadcastPacket(Message.GetBytes(), RequiredRight);
        }

        public static void BroadcastPacket(byte[] Data, string RequiredRight)
        {
            lock (mSessions)
            {
                foreach (Session Session in mSessions.Values)
                {
                    if (Session == null || Session.Stopped || !Session.Authenticated || 
                        (RequiredRight.Length > 0 && !Session.HasRight(RequiredRight)))
                    {
                        continue;
                    }

                    Session.SendData(Data);
                }
            }
        }

        public static void HandleIncomingConnection(Socket IncomingSocket)
        {
            bool Reject = ModerationBanManager.IsRemoteAddressBlacklisted(IncomingSocket.RemoteEndPoint.ToString().Split(':')[0]);

            Output.WriteLine((Reject ? "Rejected" : "Accepted") + " incoming connection from " + IncomingSocket.RemoteEndPoint.ToString().Split(':')[0] + ".",
                OutputLevel.Informational);

            if (Reject)
            {
                try
                {
                    IncomingSocket.Close();
                }
                catch (Exception) { }

                return;
            }

            lock (mSyncRoot)
            {
                uint Id = mCounter++;
                mSessions.Add(Id, new Session(Id, IncomingSocket));
            }
        }
    }
}
