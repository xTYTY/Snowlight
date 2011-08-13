using System;

using Snowlight.Specialized;

namespace Snowlight.Game.Items
{
    public class StaticObject
    {
        private string mName;
        private Vector2 mPosition;
        private int mHeight;
        private int mRotation;
        private bool mIsSeat;

        public string Name
        {
            get
            {
                return mName;
            }
        }

        public Vector2 Position
        {
            get
            {
                return mPosition;
            }
        }

        public int Height
        {
            get
            {
                return mHeight;
            }
        }

        public int Rotation
        {
            get
            {
                return mRotation;
            }
        }

        public bool IsSeat
        {
            get
            {
                return mIsSeat;
            }
        }

        public StaticObject(string Name, Vector2 Position, int Height, int Rotation, bool IsSeat)
        {
            mName = Name;
            mPosition = Position;
            mHeight = Height;
            mRotation = Rotation;
            mIsSeat = IsSeat;
        }
    }
}
