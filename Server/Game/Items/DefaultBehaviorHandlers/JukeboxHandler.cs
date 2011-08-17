using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Game.Rooms;
using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;
using Snowlight.Storage;
using System.Data;

namespace Snowlight.Game.Items.DefaultBehaviorHandlers
{
    public static class JukeboxHandler
    {
        public static void Register()
        {
            ItemEventDispatcher.RegisterEventHandler(ItemBehavior.TraxPlayer, new ItemEventHandler(HandleJukebox));
        }

        private static bool HandleJukebox(Session Session, Item Item, RoomInstance Instance, ItemEventType Event, int RequestData, uint Opcode)
        {
            switch (Event)
            {
                case ItemEventType.Placed:
                case ItemEventType.InstanceLoaded:

                    Instance.MusicController.Reset();
                    Instance.MusicController.LinkRoomOutputItem(Item);

                    List<Item> Disks = new List<Item>();

                    using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                    {
                        Disks = LoadPlaylist(MySqlClient, Item.Id);
                    }

                    foreach (Item Disk in Disks)
                    {
                        Instance.MusicController.AddDisk(Disk);
                    }

                    if (Item.DisplayFlags == "1")
                    {
                        if (Instance.MusicController.PlaylistSize > 0)
                        {
                            Instance.MusicController.Start();
                        }
                        else
                        {
                            Item.DisplayFlags = "0";
                            Item.BroadcastStateUpdate(Instance);
                        }
                    }

                    break;

                case ItemEventType.Removing:

                    if (Instance.MusicController.IsPlaying)
                    {
                        Instance.MusicController.Stop();
                        Instance.MusicController.BroadcastCurrentSongData(Instance);
                    }

                    Instance.MusicController.Reset();
                    break;

                case ItemEventType.Interact:

                    if (!Instance.CheckUserRights(Session, true))
                    {
                        return true; 
                    }

                    switch (RequestData)
                    {
                        case -1: // Open interface

                            break;

                        default: // it loves sending random numbers. as you do.

                            if (Item.DisplayFlags == "1")
                            {
                                Item.DisplayFlags = "0";
                                Instance.MusicController.Stop();
                            }
                            else
                            {
                                if (Instance.MusicController.PlaylistSize < 1)
                                {
                                    break;
                                }

                                Item.DisplayFlags = "1";
                                Instance.MusicController.Start();
                            }

                            Item.BroadcastStateUpdate(Instance);
                            RoomManager.MarkWriteback(Item, true);

                            Instance.MusicController.BroadcastCurrentSongData(Instance);
                            break;
                    }

                    break;
            }

            return true;
        }

        private static List<Item> LoadPlaylist(SqlDatabaseClient MySqlClient, uint SoundManagerId)
        {
            List<Item> List = new List<Item>();

            MySqlClient.SetParameter("soundmanagerid", SoundManagerId);
            DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM items WHERE soundmanager_id = @soundmanagerid ORDER BY soundmanager_order ASC");

            foreach (DataRow Row in Table.Rows)
            {
                Item Item = ItemFactory.CreateFromDatabaseRow(Row);

                if (Item == null)
                {
                    continue;
                }

                List.Add(Item);
            }

            return List;
        }
    }
}
