using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;


namespace Snowlight.Game.Moderation
{
    public static class ModerationPresets
    {
        private static List<string> mUserMessagePresets;
        private static List<string> mRoomMessagePresets;
        private static Dictionary<uint, string> mUserActionPresetCategories;
        private static Dictionary<uint, Dictionary<string, string>> mUserActionPresetMessages;

        public static List<string> UserMessagePresets
        {
            get
            {
                return mUserMessagePresets;
            }
        }

        public static List<string> RoomMessagePresets
        {
            get
            {
                return mRoomMessagePresets;
            }
        }

        public static Dictionary<string, Dictionary<string, string>> UserActionPresets
        {
            get
            {
                Dictionary<string, Dictionary<string, string>> Result = new Dictionary<string, Dictionary<string, string>>();

                foreach (KeyValuePair<uint, string> Category in mUserActionPresetCategories)
                {
                    Result.Add(Category.Value, new Dictionary<string, string>());

                    if (mUserActionPresetMessages.ContainsKey(Category.Key))
                    {
                        foreach (KeyValuePair<string, string> Data in mUserActionPresetMessages[Category.Key])
                        {
                            Result[Category.Value].Add(Data.Key, Data.Value);
                        }
                    }
                }

                return Result;
            }
        }

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mUserMessagePresets = new List<string>();
            mRoomMessagePresets = new List<string>();
            mUserActionPresetCategories = new Dictionary<uint, string>();
            mUserActionPresetMessages = new Dictionary<uint, Dictionary<string, string>>();

            Reload(MySqlClient);
        }

        public static void Reload(SqlDatabaseClient MySqlClient)
        {
            int i = 0;

            mUserMessagePresets.Clear();
            mRoomMessagePresets.Clear();
            mUserActionPresetCategories.Clear();
            mUserActionPresetMessages.Clear();

            DataTable BasicPresetTable = MySqlClient.ExecuteQueryTable("SELECT type,message FROM moderation_presets");

            foreach (DataRow Row in BasicPresetTable.Rows)
            {
                string Message = (string)Row["message"];

                switch ((string)Row["type"])
                {
                    case "room":

                        mRoomMessagePresets.Add(Message);
                        break;

                    case "user":

                        mUserMessagePresets.Add(Message);
                        break;
                }

                i++;
            }

            DataTable UserActionCategoryTable = MySqlClient.ExecuteQueryTable("SELECT id,caption FROM moderation_preset_action_categories");

            foreach (DataRow Row in UserActionCategoryTable.Rows)
            {
                mUserActionPresetCategories.Add((uint)Row["id"], (string)Row["caption"]);
                i++;
            }

            DataTable UserActionMsgTable = MySqlClient.ExecuteQueryTable("SELECT id,parent_id,caption,message_text FROM moderation_preset_action_messages");

            foreach (DataRow Row in UserActionMsgTable.Rows)
            {
                uint ParentId = (uint)Row["parent_id"];

                if (!mUserActionPresetMessages.ContainsKey(ParentId))
                {
                    mUserActionPresetMessages.Add(ParentId, new Dictionary<string, string>());
                }

                mUserActionPresetMessages[ParentId].Add((string)Row["caption"], (string)Row["message_text"]);
                i++;
            }

            Output.WriteLine("Loaded " + i + " moderation categories and presets.", OutputLevel.DebugInformation);
        }
    }
}
