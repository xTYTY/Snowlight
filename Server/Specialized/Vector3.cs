using System;

namespace Snowlight.Specialized
{
    public class Vector3
    {
        private int mX;
        private int mY;
        private double mZ;

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

        public double Z
        {
            get
            {
                return mZ;
            }

            set
            {
                mZ = value;
            }
        }

        public Vector3(int X, int Y, double Z)
        {
            mX = X;
            mY = Y;
            mZ = Z;
        }

        public Vector3()
        {
            mX = 0;
            mY = 0;
            mZ = 0;
        }

        public Vector2 GetVector2()
        {
            return new Vector2(mX, mY);
        }

        public override string ToString()
        {
            return mX + "|" + mY + "|" + Math.Round(mZ, 1);
        }

        public static Vector3 FromString(string Input)
        {
            string[] Bits = Input.Split('|');

            int X = 0;
            int Y = 0;
            double Z = 0;

            int.TryParse(Bits[0], out X);

            if (Bits.Length > 1)
            {
                int.TryParse(Bits[1], out Y);
            }

            if (Bits.Length > 2)
            {
                double.TryParse(Bits[2], out Z);
            }

            return new Vector3(X, Y, Z);
        }
    }
}