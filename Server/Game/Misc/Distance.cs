using System;

using Snowlight.Specialized;

namespace Snowlight.Game.Misc
{
    public static class Distance
    {
        public static int Calculate(Vector2 Position1, Vector2 Position2)
        {
            return Math.Abs(Position1.X - Position2.X) + Math.Abs(Position1.Y - Position2.Y);
        }

        public static bool TilesTouching(Vector2 Position1, Vector2 Position2)
        {
            return (Calculate(Position1, Position2) <= 1);
        }

        public static bool IsDiagonal(Vector2 Position1, Vector2 Position2)
        {
            return (Position1.X != Position2.X && Position1.Y != Position2.Y && Calculate(Position1, Position2) == 2);
        }
    }
}
