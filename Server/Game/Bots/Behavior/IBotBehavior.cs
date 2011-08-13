using System;
using Snowlight.Game.Rooms;

namespace Snowlight.Game.Bots.Behavior
{
    public abstract class IBotBehavior
    {
        public abstract void Initialize(Bot BotObject);
        public abstract void PerformUpdate(RoomInstance Instance);
        public abstract void OnSelfEnterRoom(RoomInstance Instance);
        public abstract void OnSelfLeaveRoom(RoomInstance Instance);
        public abstract void OnUserChat(RoomInstance Instance, RoomActor Actor, string MessageText, bool Shout);
        public abstract void OnUserEnter(RoomInstance Instance, RoomActor Actor);
        public abstract void OnUserLeave(RoomInstance Instance, RoomActor Actor);
    }
}
