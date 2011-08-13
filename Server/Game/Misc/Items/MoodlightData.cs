using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Snowlight.Game.Misc
{
    public class MoodlightPreset
    {
        private string mColorCode;
        private bool mWallsOnly;
        private int mColorIntensity;

        public string ColorCode
        {
            get
            {
                return mColorCode;
            }

            set
            {
                mColorCode = value;
            }
        }

        public bool BackgroundOnly
        {
            get
            {
                return mWallsOnly;
            }

            set
            {
                mWallsOnly = value;
            }
        }

        public int ColorIntensity
        {
            get
            {
                return mColorIntensity;
            }

            set
            {
                mColorIntensity = value;
            }
        }

        public MoodlightPreset(string ColorCode, bool WallsOnly, int ColorIntensity)
        {
            mColorCode = ColorCode;
            mWallsOnly = WallsOnly;
            mColorIntensity = ColorIntensity;
        }
    }

    public class MoodlightData
    {
        private bool mEnabled;
        private int mCurrentPreset;
        private Dictionary<int, MoodlightPreset> mPresets;

        public bool Enabled
        {
            get
            {
                return mEnabled;
            }

            set
            {
                mEnabled = value;
            }
        }

        public int CurrentPreset
        {
            get
            {
                return mCurrentPreset;
            }

            set
            {
                mCurrentPreset = value;
            }
        }

        public Dictionary<int, MoodlightPreset> Presets
        {
            get
            {
                return mPresets;
            }

            set
            {
                mPresets = value;
            }
        }

        public MoodlightData(bool Enabled, int CurrentPreset, Dictionary<int, MoodlightPreset> Presets)
        {
            mEnabled = Enabled;
            mCurrentPreset = CurrentPreset;
            mPresets = Presets;
        }

        public string ToItemFlagData()
        {
            string FlagData = (mEnabled ? "1" : "0") + "|" + mCurrentPreset + "|";

            for (int i = 1; i <= 3; i++)
            {
                MoodlightPreset Preset = mPresets[i];

                if (i > 1)
                {
                    FlagData += ";";
                }

                FlagData += i + "," + Preset.ColorCode + "," + Preset.ColorIntensity + "," + (Preset.BackgroundOnly ? "1" : "0");
            }

            return FlagData;
        }

        public string ToDisplayData()
        {
            MoodlightPreset CurrentPreset = new MoodlightPreset("#000000", false, 255);

            if (mPresets.ContainsKey(mCurrentPreset))
            {
                CurrentPreset = mPresets[mCurrentPreset];
            }

            return (mEnabled ? "2" : "1") + "," + mCurrentPreset + "," + (CurrentPreset.BackgroundOnly ? "2" : "1") +
                "," + CurrentPreset.ColorCode + "," + CurrentPreset.ColorIntensity;
        }

        public static MoodlightData GenerateFromFlags(string ItemFlags)
        {
            // 1,1,1,#000000,255

            bool Enabled = false;
            int CurrentPreset = 1;

            Dictionary<int, MoodlightPreset> Presets = new Dictionary<int,MoodlightPreset>();

            for (int i = 1; i <= 3; i++)
            {
                Presets.Add(i, new MoodlightPreset("#000000", false, 255));
            }

            string[] Majors = ItemFlags.Split('|');

            if (Majors.Length == 3)
            {
                Enabled = (Majors[0] == "1");
                int.TryParse(Majors[1], out CurrentPreset);

                string[] Minors = Majors[2].Split(';');

                if (Minors.Length == 3)
                {
                    Presets.Clear();

                    foreach (string Minor in Minors)
                    {
                        string[] Bits = Minor.Split(',');

                        int Num = int.Parse(Bits[0]);
                        string ColorCode = Bits[1];
                        int ColorIntensity = int.Parse(Bits[2]);
                        bool BgOnly = (Bits[3] == "1");

                        Presets.Add(Num, new MoodlightPreset(ColorCode, BgOnly, ColorIntensity));
                    }
                }
            }

            return new MoodlightData(Enabled, CurrentPreset, Presets);         
        }

        public static bool IsValidColor(string ColorCode)
        {
            switch (ColorCode)
            {
                case "#000000":
                case "#0053F7":
                case "#EA4532":
                case "#82F349":
                case "#74F5F5":
                case "#E759DE":
                case "#F2F851":

                    return true;

                default:

                    return false;
            }
        }
    }
}
