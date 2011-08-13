using System;
using System.Collections.Generic;

namespace Snowlight.Game.Rights
{
    public class Badge
    {
        private uint mId;
        private string mCode;
        private List<uint> mRightsSets;

        public uint Id
        {
            get
            {
                return mId;
            }
        }

        public string Code
        {
            get
            {
                return mCode;
            }
        }

        public List<uint> RightsSets
        {
            get
            {
                return mRightsSets;
            }
        }

        public Badge(uint Id, string Code, List<uint> RightsSets)
        {
            mId = Id;
            mCode = Code;
            mRightsSets = RightsSets;
        }
    }
}
