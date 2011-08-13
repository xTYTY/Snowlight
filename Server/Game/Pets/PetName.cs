using System;
using System.Collections.Generic;

namespace Snowlight.Game.Pets
{
    public enum PetNameError
    {
        NameOk = 0,
        NameTooLong = 1,
        NameTooShort = 2,
        InvalidCharacter = 3,
        DisallowedTerm = 4
    }

    public static class PetName
    {
        private static readonly List<char> mAllowedCharacters = new List<char>() { 'A', 'B', 'C', 'D', 'E', 'F', 'G',
            'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b',
            'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
            'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ' ', '_', '-', '.'};

        public static PetNameError VerifyPetName(string Name)
        {
            if (Name.Length < 1)
            {
                return PetNameError.NameTooShort;
            }

            if (Name.Length > 16)
            {
                return PetNameError.NameTooLong;
            }

            for (int i = 0; i < Name.Length; i++)
            {
                if (!mAllowedCharacters.Contains(Name[i]))
                {
                    return PetNameError.InvalidCharacter;
                }
            }

            return PetNameError.NameOk;
        }
    }
}
