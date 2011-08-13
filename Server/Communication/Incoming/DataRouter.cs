using System;
using System.Collections.Generic;

using Snowlight.Communication;
using Snowlight.Util;
using Snowlight.Game.Sessions;
using Snowlight.Config;

namespace Snowlight.Communication.Incoming
{
    public delegate void ProcessRequestCallback(Session Client, ClientMessage Message);

    public static class DataRouter
    {
        private static Dictionary<uint, ProcessRequestCallback> mCallbacks;
        private static List<uint> mCallbacksWithoutAuthentication;

        public static void Initialize()
        {
            mCallbacks = new Dictionary<uint, ProcessRequestCallback>();
            mCallbacksWithoutAuthentication = new List<uint>();
        }

        public static bool RegisterHandler(uint MessageId, ProcessRequestCallback Callback, bool PermitedUnauthenticated = false)
        {
            if (MessageId < 0 || Callback == null)
            {
                return false;
            }

            if (mCallbacks.ContainsKey(MessageId))
            {
                return false;
            }

            mCallbacks.Add(MessageId, Callback);

            if (PermitedUnauthenticated)
            {
                mCallbacksWithoutAuthentication.Add(MessageId);
            }

            return true;          
        }

        public static void HandleData(Session Session, ClientMessage Message)
        {
            if (Session == null || Session.Stopped || Message == null)
            {
                return;
            }

            if (!mCallbacks.ContainsKey(Message.Id))
            {
                Output.WriteLine("Unhandled packet: " + Message.Id + " (" + Constants.DefaultEncoding.GetString(Base64Encoding.EncodeUint32(Message.Id, 2)) + "), no suitable handler found.", OutputLevel.Warning);
                return;
            }

            if (!Session.Authenticated && !mCallbacksWithoutAuthentication.Contains(Message.Id))
            {
                return;
            }

            mCallbacks[Message.Id].Invoke(Session, Message);
        }
    }
}
