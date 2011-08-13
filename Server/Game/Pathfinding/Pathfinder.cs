using System;

using Snowlight.Specialized;
using Snowlight.Game.Rooms;

namespace Snowlight.Game.Pathfinding
{
    public abstract class Pathfinder
    {
        public abstract Vector2 Target { get; }
        public abstract bool IsCompleted { get; }

        public abstract void SetRoomInstance(RoomInstance Room, uint ActorId);
        public abstract void MoveTo(Vector2 Position);
        public abstract void Clear();

        public abstract Vector2 GetNextStep();
    }
}
