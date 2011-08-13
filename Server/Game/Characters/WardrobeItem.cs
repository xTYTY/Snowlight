using System;

namespace Snowlight.Game.Characters
{
    public class WardrobeItem
    {
        private string mFigure;
        private CharacterGender mGender;

        public string Figure
        {
            get
            {
                return mFigure;
            }
        }

        public CharacterGender Gender
        {
            get
            {
                return mGender;
            }
        }

        public WardrobeItem(string Figure, CharacterGender Gender)
        {
            mFigure = Figure;
            mGender = Gender;
        }
    }
}
