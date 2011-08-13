using System;
using System.Collections.Generic;

namespace Snowlight.Game.Misc
{
    public class VoucherValueData
    {
        private int mValueCredits;
        private int mValuePixels;
        private List<uint> mValueFurni;

        public int ValueCredits
        {
            get
            {
                return mValueCredits;
            }
        }

        public int ValuePixels
        {
            get
            {
                return mValuePixels;
            }
        }

        public List<uint> ValueFurni
        {
            get
            {
                return mValueFurni;
            }
        }

        public VoucherValueData(int ValueCredits, int ValuePixels, List<uint> ValueFurni)
        {
            mValueCredits = ValueCredits;
            mValuePixels = ValuePixels;
            mValueFurni = ValueFurni;
        }
    }
}
