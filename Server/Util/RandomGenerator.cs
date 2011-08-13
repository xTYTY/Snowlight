using System;

namespace Snowlight.Util
{
    public static class RandomGenerator
    {
        private static Random mRandom;

        public static void Initialize()
        {
            mRandom = new Random();
        }

        public static int GetNext(int Min = 0, int Max = 10)
        {
            return mRandom.Next(Min, (Max + 1));
        }
    }
}
