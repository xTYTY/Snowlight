using System;
using System.Collections.Generic;
using System.Text;

namespace Snowlight.Game.Rooms
{
    public class RoomIcon
    {
        private int mBackgroundImageId;
        private int mOverlayImageId;
        private Dictionary<int, int> mObjects;

        public int BackgroundImageId
        {
            get
            {
                return mBackgroundImageId;
            }
        }

        public int OverlayImageId
        {
            get
            {
                return mOverlayImageId;
            }
        }

        public Dictionary<int, int> Objects
        {
            get
            {
                return mObjects;
            }
        }

        public RoomIcon()
        {
            mBackgroundImageId = 1;
            mOverlayImageId = 0;
            mObjects = new Dictionary<int, int>();
        }

        public RoomIcon(int Background, int Foreground, Dictionary<int, int> Objects)
        {
            mBackgroundImageId = Background;
            mOverlayImageId = Foreground;
            mObjects = Objects;
        }

        public string Serialize()
        {
            StringBuilder Builder = new StringBuilder();
            Builder.Append(mBackgroundImageId);
            Builder.Append('|');
            Builder.Append(mOverlayImageId);
            Builder.Append('|');
            Builder.Append(mObjects.Count);

            foreach (KeyValuePair<int, int> Data in mObjects)
            {
                Builder.Append('|');
                Builder.Append(Data.Key);
                Builder.Append(',');
                Builder.Append(Data.Value);
            }

            return Builder.ToString();
        }

        public void Deserialize(string Input)
        {
            string[] Bits = Input.Split('|');

            int.TryParse(Bits[0], out mBackgroundImageId);
            int.TryParse(Bits[1], out mOverlayImageId);

            int ForegroundCount = 0;

            int.TryParse(Bits[2], out ForegroundCount);

            for (int i = 1; i <= ForegroundCount; i++)
            {
                int n = (2 + i);
                string[] ForegroundBits = Bits[n].Split(',');

                mObjects.Add(int.Parse(ForegroundBits[0]), int.Parse(ForegroundBits[1]));
            }
        }
    }
}
