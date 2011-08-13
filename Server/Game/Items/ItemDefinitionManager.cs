using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;


namespace Snowlight.Game.Items
{
    public static class ItemDefinitionManager
    {
        private static Dictionary<uint, ItemDefinition> mDefinitions;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mDefinitions = new Dictionary<uint, ItemDefinition>();

            int Count = 0;
            int Failed = 0;

            DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM item_definitions");

            foreach (DataRow Row in Table.Rows)
            {
                ItemStackingBehavior Behavior = ItemStackingBehavior.Normal;

                switch (Row["stacking_behavior"].ToString().ToLower())
                {
                    case "terminator":

                        Behavior = ItemStackingBehavior.Terminator;
                        break;

                    case "initiator":

                        Behavior = ItemStackingBehavior.Initiator;
                        break;

                    case "ignore":

                        Behavior = ItemStackingBehavior.Ignore;
                        break;

                    case "disable":

                        Behavior = ItemStackingBehavior.InitiateAndTerminate;
                        break;
                }

                ItemWalkableMode WMode = ItemWalkableMode.Never;

                switch (Row["walkable"].ToString())
                {
                    case "1":

                        WMode = ItemWalkableMode.Limited;
                        break;

                    case "2":

                        WMode = ItemWalkableMode.Always;
                        break;
                }

                mDefinitions.Add((uint)Row["id"], new ItemDefinition((uint)Row["id"], (uint)Row["sprite_id"],
                    (string)Row["name"], GetTypeFromString(Row["type"].ToString()),
                    ItemBehaviorUtil.FromString((Row["behavior"].ToString())), (int)Row["behavior_data"], Behavior, 
                    WMode, (int)Row["room_limit"], (int)Row["size_x"], (int)Row["size_y"], (float)Row["height"],
                    (Row["allow_recycling"].ToString() == "1"), (Row["allow_trading"].ToString() == "1"),
                    (Row["allow_selling"].ToString() == "1"), (Row["allow_gifting"].ToString() == "1"),
                    (Row["allow_inventory_stacking"].ToString() == "1")));

                Count++;             
            }

            Output.WriteLine("Loaded " + Count + " item definition(s)" + (Failed > 0 ? " (" + Failed + " skipped due to errors)" : "") + ".", OutputLevel.DebugInformation);
        }

        private static ItemType GetTypeFromString(string Type)
        {
            switch (Type.ToLower())
            {
                default:
                case "s":

                    return ItemType.FloorItem;
                
                case "i":

                    return ItemType.WallItem;

                case "h":

                    return ItemType.ClubSubscription;

                case "p":

                    return ItemType.Pet;

                case "e":

                    return ItemType.AvatarEffect;
            }
        }

        public static ItemDefinition GetDefinition(uint Id)
        {
            lock (mDefinitions)
            {
                if (mDefinitions.ContainsKey(Id))
                {
                    return mDefinitions[Id];
                }
            }

            return null;
        }
    }
}
