using System;
using System.Collections.Generic;
using System.IO;

namespace Snowlight.Config
{
    public static class Localization
    {
        private static string mLangPath;
        private static Dictionary<string, string> mLangData;

        public static string LangPath
        {
            get
            {
                return mLangPath;
            }
        }

        public static void Initialize(string LangPath)
        {
            mLangPath = LangPath;
            mLangData = new Dictionary<string, string>();

            if (File.Exists(mLangPath))
            {
                RetrieveValuesFromFile();
            }
            else
            {
                Output.WriteLine("Server translation file is missing at " + mLangPath + ".", OutputLevel.Warning);
            }
        }

        private static void RetrieveValuesFromFile()
        {
            string[] Lines = File.ReadAllLines(mLangPath, Constants.DefaultEncoding);

            foreach (string Line in Lines)
            {
                if (Line.StartsWith("#") || !Line.Contains("="))
                {
                    continue;
                }

                string[] LineBits = Line.Split('=');
                string Key = LineBits[0].ToLower();
                string Value = string.Empty;

                for (int i = 1; i < LineBits.Length; i++)
                {
                    if (i > 1)
                    {
                        Value += '=';
                    }

                    Value += LineBits[i];
                }

                if (!mLangData.ContainsKey(Key))
                {
                    mLangData.Add(Key, Value);
                }
                else
                {
                    mLangData[Key] = Value;
                }
            }
        }

        public static string GetValue(string Key, string Arg)
        {
            return GetValue(Key, new string[] { Arg });
        }

        public static string GetValue(string Key, string[] Args = null)
        {
            if (mLangData == null || !mLangData.ContainsKey(Key))
            {
                return Key;
            }

            string ReturnValue = mLangData[Key];

            if (Args != null)
            {
                for (int i = 0; i < Args.Length; i++)
                {
                    ReturnValue = ReturnValue.Replace("%" + i + "%", Args[i]);
                }
            }

            ReturnValue = ReturnValue.Replace("<br>", "\n");
            return ReturnValue;
        }
    }
}
