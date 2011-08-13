using System;

namespace Snowlight.Specialized
{
    public class Vector2
    {
        private int mX;
        private int mY;

        public int X
        {
            get
            {
                return mX;
            }

            set
            {
                mX = value;
            }
        }

        public int Y
        {
            get
            {
                return mY;
            }

            set
            {
                mY = value;
            }
        }

        public Vector2()
        {
            mX = 0;
            mY = 0;
        }

        public Vector2(int X, int Y)
        {
            mX = X;
            mY = Y;
        }

        public Vector3 GetVector3()
        {
            return new Vector3(mX, mY, 0);
        }

        public override string ToString()
        {
            return X + "|" + Y;
        }

        public static Vector2 FromString(string Input)
        {
            string[] Bits = Input.Split('|');

            int X = 0;
            int Y = 0;

            int.TryParse(Bits[0], out X);

            if (Bits.Length > 1)
            {
                int.TryParse(Bits[1], out Y);
            }

            return new Vector2(X, Y);
        }
    }
}
