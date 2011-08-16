using System;
using System.Net;
using System.Net.Sockets;

namespace Snowlight.Network
{
    /// <summary>
    /// Callback to be invoked upon accepting a new connection.
    /// </summary>
    /// <param name="Socket">Incoming socket connection</param>
    public delegate void OnNewConnectionCallback(Socket Socket);

    /// <summary>
    /// Snowlight simple asynchronous TCP listener.
    /// </summary>
    public class SnowTcpListener : IDisposable // Snow prefix to avoid conflicts with System.Net.TcpListener
    {
        private Socket mSocket;
        private OnNewConnectionCallback mCallback;

        public SnowTcpListener(IPEndPoint LocalEndpoint, int Backlog, OnNewConnectionCallback Callback)
        {
            mCallback = Callback;

            mSocket = new Socket(LocalEndpoint.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            mSocket.Bind(LocalEndpoint);
            mSocket.Listen(Backlog);
            mSocket.Blocking = false;

            BeginAccept();
        }

        public void Dispose()
        {
            if (mSocket != null)
            {
                mSocket.Dispose();
                mSocket = null;
            }
        }

        private void BeginAccept()
        {
            try
            {
                mSocket.BeginAccept(OnAccept, null);
            }
            catch (Exception) { }
        }

        private void OnAccept(IAsyncResult Result)
        {
            try
            {
                Socket ResultSocket = (Socket)mSocket.EndAccept(Result);
                mCallback.Invoke(ResultSocket);
            }
            catch (Exception) { }

            BeginAccept();
        }
    }
}
