using System;

namespace Snowlight.Game.Pets
{
    public class PetRaceData
    {
        private int mData1;
        private int mData2;
        private int mData3;

        public int Data1
        {
            get
            {
                return mData1;
            }
        }

        public int Data2
        {
            get
            {
                return mData2;
            }
        }

        public int Data3
        {
            get
            {
                return mData3;
            }
        }

        public PetRaceData(int Data1, int Data2, int Data3)
        {
            mData1 = Data1;
            mData2 = Data2;
            mData3 = Data3;
        }

        public override string ToString()
        {
            return mData1 + " " + mData2 + " " + mData3;
        }
    }
}
