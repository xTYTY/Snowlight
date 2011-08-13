using System;
using System.Data;

using Snowlight.Storage;
using Snowlight.Specialized;

namespace Snowlight.Game.Items
{
    public static class ItemFactory
    {
        public static Item CreateItem(SqlDatabaseClient MySqlClient, uint DefinitionId, uint UserId, string Flags, string FlagsDisplay, double ExpireTimestamp, bool Untradable = false)
        {
            MySqlClient.SetParameter("definitionid", DefinitionId);
            MySqlClient.SetParameter("userid", UserId);
            MySqlClient.SetParameter("flags", Flags);
            MySqlClient.SetParameter("flagsd", FlagsDisplay);
            MySqlClient.SetParameter("untradable", Untradable ? "1" : "0");
            MySqlClient.SetParameter("expiretimestamp", ExpireTimestamp);

            string RawId = MySqlClient.ExecuteScalar("INSERT INTO items (definition_id,user_id,flags,flags_display,untradable,expire_timestamp) VALUES (@definitionid,@userid,@flags,@flagsd,@untradable,@expiretimestamp); SELECT LAST_INSERT_ID();").ToString();

            uint Id = 0;
            uint.TryParse(RawId, out Id);

            if (Id == 0)
            {
                return null;
            }

            return new Item(Id, DefinitionId, UserId, 0, new Vector3(), string.Empty, 0, Flags, Flags, Untradable, 0, 0,
                ExpireTimestamp);         
        }

        public static Item CreateFromDatabaseRow(DataRow Row)
        {
            return new Item((uint)Row["id"], (uint)Row["definition_id"], (uint)Row["user_id"], (uint)Row["room_id"],
                Vector3.FromString((string)Row["room_pos"]), (string)Row["room_wall_pos"], (int)Row["room_rot"],
                (string)Row["flags"], (string)Row["flags_display"], (Row["untradable"].ToString() == "1"),
                (uint)Row["soundmanager_id"], (int)Row["soundmanager_order"], (double)Row["expire_timestamp"]);
        }
    }
}
