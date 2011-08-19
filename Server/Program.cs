using System;
using System.Collections.Generic;
using System.Security.Permissions;
using System.Net;
using System.Threading;

using Snowlight.Communication.Incoming;
using Snowlight.Config;
using Snowlight.Network;
using Snowlight.Storage;
//using Snowlight.Plugins;
using Snowlight.Util;

using Snowlight.Game;
using Snowlight.Game.Sessions;
using Snowlight.Game.Misc;
using Snowlight.Game.Handlers;
using Snowlight.Game.Moderation;
using Snowlight.Game.Messenger;
using Snowlight.Game.Characters;
using Snowlight.Game.Catalog;
using Snowlight.Game.Items;
using Snowlight.Game.Navigation;
using Snowlight.Game.Rooms;
using Snowlight.Game.Advertisements;
using Snowlight.Game.Rights;
using Snowlight.Game.Bots;
using Snowlight.Game.Infobus;
using Snowlight.Game.Achievements;
using Snowlight.Game.Recycler;
using Snowlight.Game.Pets;
using Snowlight.Game.Music;
using Snowlight.Game.Rooms.Trading;


namespace Snowlight
{
    public static class Program
    {
        private static bool mAlive;
        private static SnowTcpListener mServer;

        /// <summary>
        /// Should be used by all non-worker threads to check if they should remain alive, allowing for safe termination.
        /// </summary>
        public static bool Alive
        {
            get
            {
                return (!Environment.HasShutdownStarted && mAlive);
            }
        }

        [SecurityPermission(SecurityAction.Demand, Flags = SecurityPermissionFlag.ControlAppDomain)]
        public static void Main(string[] args)
        {
            mAlive = true;
            DateTime InitStart = DateTime.Now;

            // Set up basic output
            Output.InitializeStream(true, OutputLevel.DebugInformation);
            Output.WriteLine("Initializing Snowlight..."); // Cannot be localized before config+lang is loaded

            // Load configuration, translation, and re-configure output from config data
            ConfigManager.Initialize(Constants.DataFileDirectory + "\\server-main.cfg");
            Output.SetVerbosityLevel((OutputLevel)ConfigManager.GetValue("output.verbositylevel"));
            Localization.Initialize(Constants.LangFileDirectory + "\\lang_" + ConfigManager.GetValue("lang") + ".lang");

            // Process args
            foreach (string arg in args)
            {
                Output.WriteLine(Localization.GetValue("core.init.cmdarg", arg));
                Input.ProcessInput(arg.Split(' '));
            }

            try
            {
                // Initialize and test database
                Output.WriteLine(Localization.GetValue("core.init.mysql"));
                SqlDatabaseManager.Initialize();

                // Initialize network components
                Output.WriteLine(Localization.GetValue("core.init.net", ConfigManager.GetValue("net.bind.port").ToString()));
                mServer = new SnowTcpListener(new IPEndPoint(IPAddress.Any, (int)ConfigManager.GetValue("net.bind.port")),
                    (int)ConfigManager.GetValue("net.backlog"), new OnNewConnectionCallback(
                        SessionManager.HandleIncomingConnection));

                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    Output.WriteLine(Localization.GetValue("core.init.dbcleanup"));
                    PerformDatabaseCleanup(MySqlClient);

                    Output.WriteLine(Localization.GetValue("core.init.game"));

                    // Core
                    DataRouter.Initialize();

                    // Sessions, characters
                    Handshake.Initialize();
                    GlobalHandler.Initialize();
                    SessionManager.Initialize();
                    CharacterInfoLoader.Initialize();
                    RightsManager.Initialize(MySqlClient);
                    SingleSignOnAuthenticator.Initialize();

                    // Room management and navigator
                    RoomManager.Initialize(MySqlClient);
                    RoomInfoLoader.Initialize();
                    RoomHandler.Initialize();
                    RoomItemHandler.Initialize();
                    Navigator.Initialize(MySqlClient);

                    // Help and moderation
                    HelpTool.Initialize(MySqlClient);
                    ModerationPresets.Initialize(MySqlClient);
                    ModerationTicketManager.Initialize(MySqlClient);
                    ModerationHandler.Initialize();
                    ModerationBanManager.Initialize(MySqlClient);

                    // Catalog, pets and items
                    ItemDefinitionManager.Initialize(MySqlClient);
                    CatalogManager.Initialize(MySqlClient);
                    CatalogPurchaseHandler.Initialize();
                    Inventory.Initialize();
                    ItemEventDispatcher.Initialize();
                    PetDataManager.Initialize(MySqlClient);

                    // Messenger
                    MessengerHandler.Initialize();

                    // Achievements and quests
                    AchievementManager.Initialize(MySqlClient);
                    QuestManager.Initialize(MySqlClient);

                    // Misc/extras
                    CrossdomainPolicy.Initialize("Data\\crossdomain.xml");
                    InfobusManager.Initialize();
                    ActivityPointsWorker.Initialize();
                    BotManager.Initialize(MySqlClient);
                    InterstitialManager.Initialize(MySqlClient);
                    ChatEmotions.Initialize();
                    EffectsCacheWorker.Initialize();
                    RecyclerManager.Initialize(MySqlClient);
                    DrinkSetManager.Initialize(MySqlClient);
                    SongManager.Initialize();
                    TradeHandler.Initialize();
                    RandomGenerator.Initialize();
                    StatisticsSyncUtil.Initialize();

                    // Polish
                    WarningSurpressors.Initialize();
                }
            }
            catch (Exception e)
            {
                HandleFatalError(Localization.GetValue("core.init.error.details", new string[] { e.Message, e.StackTrace }));
                return;
            }

            // Init complete
            TimeSpan TimeSpent = DateTime.Now - InitStart;

            Output.WriteLine(Localization.GetValue("core.init.ok", Math.Round(TimeSpent.TotalSeconds, 2).ToString()), OutputLevel.Notification);
            Output.WriteLine((string)Localization.GetValue("core.init.ok.cmdinfo"), OutputLevel.Notification);

            Console.Beep();
            Input.Listen(); // This will make the main thread process console while Program.Alive.
        }

        private static void PerformDatabaseCleanup(SqlDatabaseClient MySqlClient)
        {
            MySqlClient.ExecuteNonQuery("UPDATE rooms SET current_users = 0");
            MySqlClient.SetParameter("timestamp", UnixTimestamp.GetCurrent());
            MySqlClient.ExecuteNonQuery("UPDATE room_visits SET timestamp_left = @timestamp WHERE timestamp_left = 0");
            MySqlClient.ExecuteNonQuery("UPDATE characters SET auth_ticket = ''");
        }

        public static void HandleFatalError(string Message)
        {
            Output.WriteLine(Message, OutputLevel.CriticalError);
            Output.WriteLine((string)Localization.GetValue("core.init.error.pressanykey"), OutputLevel.CriticalError);

            Console.ReadKey(true);

            Stop();
        }

        public static void Stop()
        {
            Output.WriteLine(Localization.GetValue("core.uninit"));

            mAlive = false; // Will destroy any threads looping for Program.Alive.

            SqlDatabaseManager.Uninitialize();

            mServer.Dispose();
            mServer = null;

            Environment.Exit(0);
        }
    }
}
