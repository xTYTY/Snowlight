using System;
using System.Collections.Generic;
using System.Data;

using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication;

using Snowlight.Communication.Outgoing;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Moderation
{
    public static class HelpTool
    {
        private static Dictionary<uint, HelpTopic> mTopics;
        private static Dictionary<uint, HelpCategory> mCategories;

        private static List<HelpTopic> ImportantTopics
        {
            get
            {
                List<HelpTopic> List = new List<HelpTopic>();

                foreach (HelpTopic Topic in mTopics.Values)
                {
                    if (Topic.Priority == HelpTopicPriority.ImportantIssue)
                    {
                        List.Add(Topic);
                    }
                }

                return List;
            }
        }

        private static List<HelpTopic> FaqTopics
        {
            get
            {
                List<HelpTopic> List = new List<HelpTopic>();

                foreach (HelpTopic Topic in mTopics.Values)
                {
                    if (Topic.Priority == HelpTopicPriority.FrequentlyAskedQuestion)
                    {
                        List.Add(Topic);
                    }
                }

                return List;
            }
        }

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mCategories = new Dictionary<uint,HelpCategory>();
            mTopics = new Dictionary<uint, HelpTopic>();

            LoadCategories(MySqlClient);
            LoadTopics(MySqlClient);

            DataRouter.RegisterHandler(OpcodesIn.HELP_HOMEPAGE, new ProcessRequestCallback(GetHelpHomepage));
            DataRouter.RegisterHandler(OpcodesIn.HELP_VIEW_TOPIC, new ProcessRequestCallback(GetHelpTopic));
            DataRouter.RegisterHandler(OpcodesIn.HELP_GET_CATEGORIES, new ProcessRequestCallback(GetHelpCategoryList));
            DataRouter.RegisterHandler(OpcodesIn.HELP_SEARCH, new ProcessRequestCallback(GetHelpSearch));
            DataRouter.RegisterHandler(OpcodesIn.HELP_VIEW_CATEGORY, new ProcessRequestCallback(GetTopicsList));
        }

        public static void LoadCategories(SqlDatabaseClient MySqlClient)
        {
            int i = 0;

            lock (mTopics)
            {
                mCategories.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT id,name FROM help_categories ORDER BY id ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    mCategories.Add((uint)Row["id"], new HelpCategory((uint)Row["id"], (string)Row["name"]));
                    i++;
                }
            }

            Output.WriteLine("Loaded " + i + " help categories(s).", OutputLevel.DebugInformation);
        }

        public static void LoadTopics(SqlDatabaseClient MySqlClient)
        {
            int i = 0;

            lock (mTopics)
            {
                mTopics.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT id,category,title,body,priority FROM help_topics ORDER BY id ASC");

                foreach (DataRow Row in Table.Rows)
                {
                    mTopics.Add((uint)Row["id"], new HelpTopic((uint)Row["id"], (uint)Row["category"], (string)Row["title"],
                        (string)Row["body"], (HelpTopicPriority)((int.Parse(Row["priority"].ToString())))));
                    i++;
                }
            }

            Output.WriteLine("Loaded " + i + " help topic(s).", OutputLevel.DebugInformation);
        }

        public static HelpTopic GetTopicById(uint TopicId)
        {
            lock (mTopics)
            {
                if (mTopics.ContainsKey(TopicId))
                {
                    return mTopics[TopicId];
                }
            }

            return null;
        }

        public static int GetArticleCountForCategory(uint CategoryId)
        {
            int c = 0;

            lock (mTopics)
            {
                foreach (HelpTopic Topic in mTopics.Values)
                {
                    if (CategoryId == Topic.Category)
                    {
                        c++;
                    }
                }
            }

            return c;
        }

        #region Handlers
        private static void GetHelpHomepage(Session Client, ClientMessage Message)
        {
            Client.SendData(HelpHomepageComposer.Compose(ImportantTopics, FaqTopics));
        }

        private static void GetHelpTopic(Session Client, ClientMessage Message)
        {
            HelpTopic Topic = GetTopicById(Message.PopWiredUInt32());

            if (Topic == null)
            {
                return;
            }

            Client.SendData(HelpTopicComposer.Compose(Topic));
        }

        private static void GetHelpCategoryList(Session Client, ClientMessage Message)
        {
            lock (mCategories)
            {
                Client.SendData(HelpCategoryListComposer.Compose(mCategories));
            }
        }

        private static void GetHelpSearch(Session Client, ClientMessage Message)
        {
            string Query = Message.PopString();

            if (Query.Length == 0)
            {
                return;
            }   

            Dictionary<uint, string> Results = new Dictionary<uint, string>();

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                MySqlClient.SetParameter("query", "%" + Query + "%");
                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT id,title FROM help_topics WHERE title LIKE @query");

                foreach (DataRow Row in Table.Rows)
                {
                    Results.Add((uint)Row["id"], (string)Row["title"]);
                }
            }

            Client.SendData(HelpSearchResultsComposer.Compose(Results));
        }

        private static void GetTopicsList(Session Client, ClientMessage Message)
        {
            uint CategoryId = Message.PopWiredUInt32();
            List<HelpTopic> Topics = new List<HelpTopic>();

            lock (mTopics)
            {
                foreach (HelpTopic Topic in mTopics.Values)
                {
                    if (Topic.Category == CategoryId)
                    {
                        Topics.Add(Topic);
                    }
                }
            }

            Client.SendData(HelpTopicListComposer.Compose(CategoryId, Topics));
        }
        #endregion
    }
}
