using System;
using System.Collections.Generic;

namespace Snowlight.Game.Misc
{
    public static class ChatEmotions
    {
        public static Dictionary<string, int> mEmotions;

        public static void Initialize()
        {
            mEmotions = new Dictionary<string, int>();
            
            mEmotions.Add(":)", 1);
            mEmotions.Add(":d", 1);
            mEmotions.Add("(:", 1);

            mEmotions.Add(">:(", 2);
            mEmotions.Add(":@", 2);

            mEmotions.Add(":o", 3);

            mEmotions.Add(":(", 4);
            mEmotions.Add(":'(", 4);
        }

        public static int GetEmotionForText(string InputText)
        {
            foreach (KeyValuePair<string, int> Emotion in mEmotions)
            {
                if (InputText.ToLower().Contains(Emotion.Key.ToLower()))
                {
                    return Emotion.Value;
                }
            }

            return 0;
        }
    }
}
