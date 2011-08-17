using System;
using System.Collections.Generic;
using System.Net;
using System.IO;

namespace Snowlight.Config.Lang
{
    public static class LangManager
    {
        private static string mLangPath;
        private static Dictionary<string, LangElement> mLangData;

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
            mLangData = new Dictionary<string, LangElement>();

            mLangData.Add("initialized.info.cmd", new LangElement("initialized.info.cmd", LangElementType.Text, ""));
            mLangData.Add("initialized.error", new LangElement("initialized.error", LangElementType.Text, ""));
            mLangData.Add("command.commands.info", new LangElement("command.commands.info", LangElementType.Text, ""));
            mLangData.Add("command.online.part1", new LangElement("command.online.part1", LangElementType.Text, ""));
            mLangData.Add("command.online.part2", new LangElement("command.online.part2", LangElementType.Text, ""));
            mLangData.Add("command.updatecatalog.success", new LangElement("command.updatecatalog.success", LangElementType.Text, ""));
            mLangData.Add("command.invalidsyntax", new LangElement("command.invalidsyntax", LangElementType.Text, ""));
            mLangData.Add("command.targetuser", new LangElement("command.targetuser", LangElementType.Text, ""));
            mLangData.Add("command.cannotproceedcmd", new LangElement("command.cannotproceedcmd", LangElementType.Text, ""));
            mLangData.Add("command.cannotproceedcmd2", new LangElement("command.cannotproceedcmd2", LangElementType.Text, ""));
            mLangData.Add("command.kick.success", new LangElement("command.kick.success", LangElementType.Text, ""));
            mLangData.Add("command.roomunmute.success", new LangElement("command.roomunmute.success", LangElementType.Text, ""));
            mLangData.Add("command.roomunmute.error", new LangElement("command.roomunmute.error", LangElementType.Text, ""));
            mLangData.Add("command.roommute.success", new LangElement("command.roommute.success", LangElementType.Text, ""));
            mLangData.Add("command.roommute.error", new LangElement("command.roommute.error", LangElementType.Text, ""));
            mLangData.Add("command.cannotproceedcmd3", new LangElement("command.cannotproceedcmd3", LangElementType.Text, ""));
            mLangData.Add("command.unmute.error", new LangElement("command.unmute.error", LangElementType.Text, ""));
            mLangData.Add("command.unmute.sucess", new LangElement("command.unmute.sucess", LangElementType.Text, ""));
            mLangData.Add("command.mute.error", new LangElement("command.mute.error", LangElementType.Text, ""));
            mLangData.Add("command.mute.sucess.part1", new LangElement("command.mute.sucess.part1", LangElementType.Text, ""));
            mLangData.Add("command.mute.sucess.part2", new LangElement("command.mute.sucess.part2", LangElementType.Text, ""));
            mLangData.Add("command.mute.sucess.part3", new LangElement("command.mute.sucess.part3", LangElementType.Text, ""));
            mLangData.Add("command.emptyinv.sucess", new LangElement("command.emptyinv.sucess", LangElementType.Text, ""));
            mLangData.Add("command.pickall.error", new LangElement("command.pickall.error", LangElementType.Text, ""));
            mLangData.Add("command.unmute.sucess2", new LangElement("command.unmute.sucess2", LangElementType.Text, ""));
            mLangData.Add("command.cannotproceedcmd4", new LangElement("command.cannotproceedcmd4", LangElementType.Text, ""));


            if (File.Exists(mLangPath))
            {
                RetrieveValuesFromFile();

                foreach (LangElement Element in mLangData.Values)
                {
                    if (!Element.UserConfigured)
                    {
                        Output.WriteLine("Lang value '" + Element.Key.ToLower() + "' missing; using default value.", OutputLevel.Warning);
                    }
                }
            }
            else
            {
                Output.WriteLine("Lang file is missing at " + mLangPath + "; using default values.", OutputLevel.Warning);
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

                if (mLangData.ContainsKey(Key))
                {
                    mLangData[Key].CurrentValue = Value;
                }
            }
        }

        public static object GetValue(string Key)
        {
            if (mLangData == null || !mLangData.ContainsKey(Key))
            {
                throw new KeyNotFoundException();
            }

            return mLangData[Key].CurrentValue;
        }
    }
}
