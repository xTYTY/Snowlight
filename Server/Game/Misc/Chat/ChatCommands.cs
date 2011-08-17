using System;
using System.Collections.Generic;
using System.Linq;

using Snowlight.Game.Sessions;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Infobus;
using Snowlight.Game.Rooms;
using Snowlight.Game.Bots;
using Snowlight.Storage;
using Snowlight.Game.Achievements;
using Snowlight.Util;
using System.Text;
using Snowlight.Game.Moderation;
using Snowlight.Config.Lang;

namespace Snowlight.Game.Misc
{
    public static class ChatCommands
    {
        public static bool HandleCommand(Session Session, string Input)
        {
            Input = Input.Substring(1, Input.Length - 1);
            string[] Bits = Input.Split(' ');

            RoomInstance Instance = RoomManager.GetInstanceByRoomId(Session.CurrentRoomId);
            RoomActor Actor = (Instance == null ? null : Instance.GetActorByReferenceId(Session.CharacterId));

            switch (Bits[0].ToLower())
            {
                case "commands":
                    {
                        Session.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.commands.info") + ":\n\n:commands\n:online\n:about\n:pickall"));
                        return true;
                    }
                case "update_catalog":
                    {
                        if (!Session.HasRight("hotel_admin"))
                        {
                            return false;
                        }
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            Snowlight.Game.Catalog.CatalogManager.RefreshCatalogData(MySqlClient);
                        }
                        Session.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.updatecatalog.success")));
                        return true;
                    }
                case "update_items":
                    {
                        if (!Session.HasRight("hotel_admin"))
                        {
                            return false;
                        }
                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            Snowlight.Game.Items.ItemDefinitionManager.Initialize(MySqlClient);
                        }
                        Session.SendData(NotificationMessageComposer.Compose("Items reloaded"));
                        return true;
                    }
                case "online":
                    {
                        List<string> OnlineUsers = SessionManager.ConnectedUserData.Values.ToList();
                        StringBuilder MessageText = new StringBuilder((string)LangManager.GetValue("command.online.part1") + " " + OnlineUsers.Count + " " + (string)LangManager.GetValue("command.online.part2") + "\n");

                        foreach (string OnlineUser in OnlineUsers)
                        {
                            MessageText.Append('\n');
                            MessageText.Append("- " + OnlineUser);
                        }

                        Session.SendData(NotificationMessageComposer.Compose(MessageText.ToString()));
                        return true;
                    }
                case "superkick":
                    {
                        if (!Session.HasRight("hotel_admin"))
                        {
                            return false;
                        }

                        if (Bits.Length < 2)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.invalidsyntax") + " - :kick <username>", 0, ChatType.Whisper));
                            return true;
                        }

                        string Username = UserInputFilter.FilterString(Bits[1].Trim());
                        Session TargetSession = SessionManager.GetSessionByCharacterId(CharacterResolverCache.GetUidFromName(Username));

                        if (TargetSession == null || TargetSession.HasRight("moderation_tool") || !TargetSession.InRoom)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' is offline or cannot be kicked.", 0, ChatType.Whisper));
                            return true;
                        }

                        SessionManager.StopSession(TargetSession.Id);

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Superkicked user from server (chat command)",
                               "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ").");
                        }

                        return true;
                    }
                case "kick":
                    {
                        if (!Session.HasRight("moderation_tool"))
                        {
                            return false;
                        }

                        if (Bits.Length < 2)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.invalidsyntax") + " - :kick <username>", 0, ChatType.Whisper));
                            return true;
                        }

                        string Username = UserInputFilter.FilterString(Bits[1].Trim());
                        Session TargetSession = SessionManager.GetSessionByCharacterId(CharacterResolverCache.GetUidFromName(Username));

                        if (TargetSession == null || TargetSession.HasRight("moderation_tool") || !TargetSession.InRoom)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' is offline, not in a room, or cannot be kicked.", 0, ChatType.Whisper));
                            return true;
                        }

                        RoomManager.RemoveUserFromRoom(TargetSession, true);
                        TargetSession.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.kick.success")));

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Kicked user from room (chat command)",
                                "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ").");
                        }

                        return true;
                    }
                case "roomunmute":
                    {
                        if (!Session.HasRight("mute"))
                        {
                            return false;
                        }

                        if (Instance.RoomMuted)
                        {
                            Instance.RoomMuted = false;
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.roomunmute.success"), 0, ChatType.Whisper));
                        }
                        else
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.roomunmute.error"), 0, ChatType.Whisper));
                        }

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Unmuted room", "Room '"
                                + Instance.Info.Name + "' (ID " + Instance.RoomId + ")");
                        }

                        return true;
                    }
                case "roommute":
                    {
                        if (!Session.HasRight("mute"))
                        {
                            return false;
                        }

                        if (!Instance.RoomMuted)
                        {
                            Instance.RoomMuted = true;
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.roommute.success"), 0, ChatType.Whisper));
                        }
                        else
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.roommute.error"), 0, ChatType.Whisper));
                        }

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Muted room", "Room '"
                                + Instance.Info.Name + "' (ID " + Instance.RoomId + ")");
                        }

                        return true;
                    }

                case "unmute":
                    {
                        if (!Session.HasRight("mute"))
                        {
                            return false;
                        }

                        if (Bits.Length < 2)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.invalidsyntax") + " - :unmute <username>", 0, ChatType.Whisper));
                            return true;
                        }

                        string Username = UserInputFilter.FilterString(Bits[1].Trim());

                        Session TargetSession = SessionManager.GetSessionByCharacterId(CharacterResolverCache.GetUidFromName(Username));

                        if (TargetSession == null)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' " + (string)LangManager.GetValue("command.cannotproceedcmd3"), 0, ChatType.Whisper));
                            return true;
                        }

                        if (!TargetSession.CharacterInfo.IsMuted)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' " + (string)LangManager.GetValue("command.unmute.error"), 0, ChatType.Whisper));
                            return true;
                        }

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            TargetSession.CharacterInfo.Unmute(MySqlClient);
                        }

                        TargetSession.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.unmute.sucess")));
                        Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' " + (string)LangManager.GetValue("command.unmute.sucess2"), 0, ChatType.Whisper));

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Unmuted user",
                                "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ").");
                        }

                        return true;
                    }

                case "mute":
                    {
                        if (!Session.HasRight("mute"))
                        {
                            return false;
                        }

                        if (Bits.Length < 2)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.invalidsyntax") + " - :mute <username> [length in seconds]", 0, ChatType.Whisper));
                            return true;
                        }

                        string Username = UserInputFilter.FilterString(Bits[1].Trim());
                        int TimeToMute = 0;

                        if (Bits.Length >= 3)
                        {
                            int.TryParse(Bits[2], out TimeToMute);
                        }

                        if (TimeToMute <= 0)
                        {
                            TimeToMute = 300;
                        }

                        if (TimeToMute > 3600)
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.mute.error"), 0, ChatType.Whisper));
                            return true;
                        }

                        Session TargetSession = SessionManager.GetSessionByCharacterId(CharacterResolverCache.GetUidFromName(Username));

                        if (TargetSession == null || TargetSession.HasRight("mute"))
                        {
                            Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.targetuser") + " '" + Username + "' " + (string)LangManager.GetValue("command.cannotproceedcmd4"), 0, ChatType.Whisper));
                            return true;
                        }

                        using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                        {
                            TargetSession.CharacterInfo.Mute(MySqlClient, TimeToMute);
                            ModerationLogs.LogModerationAction(MySqlClient, Session, "Muted user",
                                "User '" + TargetSession.CharacterInfo.Username + "' (ID " + TargetSession.CharacterId + ") for " + TimeToMute + " seconds.");
                        }

                        TargetSession.SendData(RoomMutedComposer.Compose(TimeToMute));
                        Session.SendData(RoomChatComposer.Compose(Actor.Id, (string)LangManager.GetValue("command.mute.sucess.part1") + " '" + Username + "' " + (string)LangManager.GetValue("command.mute.sucess.part2") + " " + TimeToMute + " seconds.", 0, ChatType.Whisper));
                        return true;
                    }

                case "clipping":

                    if (!Session.HasRight("hotel_admin"))
                    {
                        return false;
                    }

                    Actor.OverrideClipping = !Actor.OverrideClipping;
                    Actor.ApplyEffect(Actor.ClippingEnabled ? 0 : 23);
                    Session.CurrentEffect = 0;
                    return true;

                case "about":

                    Session.SendData(UserAlertModernComposer.Compose("Powered by Snowlight", "This hotel is proudly powered by Snowlight, the premium open-source Habbo Hotel emulator.\n\nhttp://www.meth0d.org/snowlight"));
                    return true;

                case "t":

                    if (!Session.HasRight("hotel_admin"))
                    {
                        return false;
                    }

                    Session.SendData(NotificationMessageComposer.Compose("Position: " + Actor.Position.ToString() + ", Rotation: " + Actor.BodyRotation));
                    return true;

                case "emptyinv":

                    if (!Session.HasRight("hotel_admin"))
                    {
                        return false;
                    }

                    Session.InventoryCache.ClearAndDeleteAll();
                    Session.SendData(InventoryRefreshComposer.Compose());
                    Session.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.emptyinv.sucess")));
                    return true;

                case "pickall":

                    if (!Instance.CheckUserRights(Session, true))
                    {
                        Session.SendData(NotificationMessageComposer.Compose((string)LangManager.GetValue("command.pickall.error")));
                        return true;
                    }

                    Instance.PickAllToUserInventory(Session);
                    return true;
            }

            return false;
        }
    }
}
