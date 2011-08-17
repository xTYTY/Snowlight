using System;
using System.Collections.Generic;
using System.Net;
using System.IO;

namespace Snowlight.Config
{
    public static class ConfigManager
    {
        private static string mConfigPath;
        private static Dictionary<string, ConfigElement> mConfigData;

        public static string ConfigPath
        {
            get
            {
                return mConfigPath;
            }
        }

        public static void Initialize(string ConfigPath)
        {
            mConfigPath = ConfigPath;
            mConfigData = new Dictionary<string, ConfigElement>();

            // Core/Output
            mConfigData.Add("output.enablelogfiles", new ConfigElement("output.enablelogfiles", ConfigElementType.Boolean, true));
            mConfigData.Add("output.verbositylevel", new ConfigElement("output.verbositylevel", ConfigElementType.Integer, -1));
            // MySQL
            mConfigData.Add("mysql.pool.min", new ConfigElement("mysql.pool.min", ConfigElementType.Integer, 5));
            mConfigData.Add("mysql.pool.max", new ConfigElement("mysql.pool.max", ConfigElementType.Integer, 20));
            mConfigData.Add("mysql.pool.lifetime", new ConfigElement("mysql.pool.lifetime", ConfigElementType.Integer, 10));
            mConfigData.Add("mysql.user", new ConfigElement("mysql.user", ConfigElementType.Text, "root"));
            mConfigData.Add("mysql.pass", new ConfigElement("mysql.pass", ConfigElementType.Text, "changeme"));
            mConfigData.Add("mysql.host", new ConfigElement("mysql.host", ConfigElementType.Text, "localhost"));
            mConfigData.Add("mysql.port", new ConfigElement("mysql.port", ConfigElementType.Integer, 3306));
            mConfigData.Add("mysql.dbname", new ConfigElement("mysql.port", ConfigElementType.Text, "snowdb"));
            // Net
            mConfigData.Add("net.backlog", new ConfigElement("net.backlog", ConfigElementType.Integer, 50));
            mConfigData.Add("net.bind.ip", new ConfigElement("net.bind.ip", ConfigElementType.IpAddress, IPAddress.Any));
            mConfigData.Add("net.bind.port", new ConfigElement("net.bind.port", ConfigElementType.Integer, 38101));
            // General
            mConfigData.Add("pathfinder.mode", new ConfigElement("pathfinder.mode", ConfigElementType.Text, "simple"));
            // Cache control
            mConfigData.Add("cache.navigator.enabled", new ConfigElement("cache.navigator.enabled", ConfigElementType.Boolean, true));
            mConfigData.Add("cache.catalog.enabled", new ConfigElement("cache.catalog.enabled", ConfigElementType.Boolean, true));
            mConfigData.Add("cache.navigator.lifetime", new ConfigElement("cache.navigator.lifetime", ConfigElementType.Integer, 30));
            mConfigData.Add("cache.catalog.lifetime", new ConfigElement("cache.catalog.lifetime", ConfigElementType.Integer, 120));
            // Navigator/room settings
            mConfigData.Add("navigator.maxroomsperuser", new ConfigElement("navigator.maxroomsperuser", ConfigElementType.Integer, 15));
            mConfigData.Add("navigator.maxfavoritesperuser", new ConfigElement("navigator.maxfavoritesperuser", ConfigElementType.Integer, 30));
            mConfigData.Add("rooms.staffpicked.category", new ConfigElement("rooms.staffpicked.category", ConfigElementType.Integer, 2));
            mConfigData.Add("rooms.limit.furni", new ConfigElement("rooms.limit.furni", ConfigElementType.Integer, 1000));
            mConfigData.Add("rooms.limit.stacking", new ConfigElement("rooms.limit.stacking", ConfigElementType.Integer, 12));
            mConfigData.Add("rooms.limit.pets", new ConfigElement("rooms.limit.pets", ConfigElementType.Integer, 10));
            // Pixels
            mConfigData.Add("activitypoints.enabled", new ConfigElement("activitypoints.enabled", ConfigElementType.Boolean, true));
            mConfigData.Add("activitypoints.interval", new ConfigElement("activitypoints.interval", ConfigElementType.Integer, 1800));
            mConfigData.Add("activitypoints.amount", new ConfigElement("activitypoints.amount", ConfigElementType.Integer, 50));
            // Moderation logs
            mConfigData.Add("moderation.chatlogs.enabled", new ConfigElement("moderation.chatlogs.enabled", ConfigElementType.Boolean, true));
            mConfigData.Add("moderation.roomlogs.enabled", new ConfigElement("moderation.roomlogs.enabled", ConfigElementType.Boolean, true));
            // Debug
            mConfigData.Add("debug.sso", new ConfigElement("debug.sso", ConfigElementType.Text, string.Empty));
            // Lang
            mConfigData.Add("lang", new ConfigElement("lang", ConfigElementType.Text, "en"));

            if (File.Exists(mConfigPath))
            {
                RetrieveValuesFromFile();

                foreach (ConfigElement Element in mConfigData.Values)
                {
                    if (!Element.UserConfigured)
                    {
                        Output.WriteLine("Configuration value '" + Element.Key.ToLower() + "' missing; using default value.", OutputLevel.Warning);
                    }
                }
            }
            else
            {
                Output.WriteLine("Configuration file is missing at " + mConfigPath + "; using default values.", OutputLevel.Warning);
            }
        }

        private static void RetrieveValuesFromFile()
        {
            string[] Lines = File.ReadAllLines(mConfigPath, Constants.DefaultEncoding);

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

                if (mConfigData.ContainsKey(Key))
                {
                    mConfigData[Key].CurrentValue = Value;
                }
            }
        }     

        public static object GetValue(string Key)
        {
            if (mConfigData == null || !mConfigData.ContainsKey(Key))
            {
                throw new KeyNotFoundException();
            }

            return mConfigData[Key].CurrentValue;           
        }
    }
}
