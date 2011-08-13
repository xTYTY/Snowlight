using System;
using System.Collections.Generic;
using Snowlight.Util;

namespace Snowlight.Game.Misc
{
    public class DrinkSet
    {
        private int mId;
        private List<int> mDrinks;

        public int Id
        {
            get
            {
                return mId;
            }
        }

        public DrinkSet(int Id, List<int> Drinks)
        {
            mId = Id;
            mDrinks = Drinks;
        }

        public int GetRandomDrink()
        {
            return mDrinks[RandomGenerator.GetNext(0, mDrinks.Count - 1)];
        }
    }
}
