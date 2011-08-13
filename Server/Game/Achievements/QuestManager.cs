using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;

using Snowlight.Storage;
using Snowlight.Game.Sessions;
using Snowlight.Communication;
using Snowlight.Communication.Outgoing;
using Snowlight.Communication.Incoming;

namespace Snowlight.Game.Achievements
{
    public static class QuestManager
    {
        private static Dictionary<uint, Quest> mQuests;
        private static object mSyncRoot;

        public static void Initialize(SqlDatabaseClient MySqlClient)
        {
            mQuests = new Dictionary<uint, Quest>();
            mSyncRoot = new object();

            ReloadQuests(MySqlClient);

            DataRouter.RegisterHandler(OpcodesIn.QUESTS_GET_LIST, new ProcessRequestCallback(GetList));
            DataRouter.RegisterHandler(OpcodesIn.QUESTS_ACTIVATE, new ProcessRequestCallback(ActivateQuest));
            DataRouter.RegisterHandler(OpcodesIn.QUESTS_GET_CURRENT, new ProcessRequestCallback(GetCurrentQuest));
            DataRouter.RegisterHandler(OpcodesIn.QUESTS_CANCEL, new ProcessRequestCallback(CancelQuest));
        }

        public static void ReloadQuests(SqlDatabaseClient MySqlClient)
        {
            lock (mSyncRoot)
            {
                mQuests.Clear();

                DataTable Table = MySqlClient.ExecuteQueryTable("SELECT * FROM quests");

                foreach (DataRow Row in Table.Rows)
                {
                    mQuests.Add((uint)Row["id"], new Quest((uint)Row["id"], (string)Row["category"], (int)Row["series_number"],
                        (QuestType)((int)Row["goal_type"]), (uint)Row["goal_data"], (string)Row["name"], (int)Row["reward"],
                        (string)Row["data_bit"]));
                }
            }
        }

        public static Quest GetQuest(uint Id)
        {
            lock (mSyncRoot)
            {
                return (mQuests.ContainsKey(Id) ? mQuests[Id] : null);
            }
        }

        public static int GetAmountOfQuestsInCategory(string Category)
        {
            int i = 0;

            lock (mSyncRoot)
            {
                foreach (Quest Quest in mQuests.Values)
                {
                    if (Quest.Category == Category)
                    {
                        i++;
                    }
                }
            }

            return i;
        }

        public static void ProgressUserQuest(Session Session, QuestType QuestType, uint EventData = 0)
        {
            if (Session.QuestCache.CurrentQuestId <= 0)
            {
                return;
            }

            Quest UserQuest = GetQuest(Session.QuestCache.CurrentQuestId);

            if (UserQuest == null || UserQuest.GoalType != QuestType)
            {
                return;
            }

            int CurrentProgress = Session.QuestCache.GetQuestProgress(UserQuest.Id);
            int NewProgress = CurrentProgress;
            bool PassQuest = false;

            switch (QuestType)
            {
                default:

                    NewProgress++;

                    if (NewProgress >= UserQuest.GoalData)
                    {
                        PassQuest = true;
                    }

                    break;

                case QuestType.EXPLORE_FIND_ITEM:

                    if (EventData != UserQuest.GoalData)
                    {
                        return;
                    }

                    NewProgress = (int)UserQuest.GoalData;
                    PassQuest = true;
                    break;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.QuestCache.AddOrUpdateData(MySqlClient, UserQuest.Id, NewProgress, !PassQuest);
                
                if (PassQuest)
                {
                    Session.CharacterInfo.UpdateActivityPointsBalance(MySqlClient, UserQuest.Reward);

                    Quest NextQuest = GetNextQuestInSeries(UserQuest.Category, UserQuest.Number + 1);

                    if (NextQuest != null)
                    {
                        Session.QuestCache.AddOrUpdateData(MySqlClient, NextQuest.Id, 0, true);
                    }
                }
            }

            Session.SendData(QuestStartedComposer.Compose(Session, UserQuest));

            if (PassQuest)
            {
                Session.SendData(QuestCompletedComposer.Compose(Session, UserQuest));
                Session.SendData(ActivityPointsBalanceComposer.Compose(Session.CharacterInfo.ActivityPointsBalance,
                    UserQuest.Reward));
                GetList(Session, null);

                Session.MessengerFriendCache.BroadcastToFriends(MessengerFriendEventComposer.Compose(Session.CharacterId,
                    MessengerFriendEventType.QuestCompleted, UserQuest.Category + "." + UserQuest.QuestName));
            }
        }

        public static Quest GetNextQuestInSeries(string Category, int Number)
        {
            lock (mSyncRoot)
            {
                foreach (Quest Quest in mQuests.Values)
                {
                    if (Quest.Category == Category && Quest.Number == Number)
                    {
                        return Quest;
                    }
                }
            }

            return null;
        }

        private static void GetList(Session Session, ClientMessage Message)
        {
            lock (mSyncRoot)
            {
                Session.SendData(QuestListComposer.Compose(Session, mQuests.Values.ToList().AsReadOnly(), (Message != null)));
            }
        }

        private static void ActivateQuest(Session Session, ClientMessage Message)
        {
            Quest Quest = GetQuest(Message.PopWiredUInt32());

            if (Quest == null)
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.QuestCache.AddOrUpdateData(MySqlClient, Quest.Id, Session.QuestCache.GetQuestProgress(Quest.Id), true);
            }

            GetList(Session, null);
            Session.SendData(QuestStartedComposer.Compose(Session, Quest));
        }

        private static void GetCurrentQuest(Session Session, ClientMessage Message)
        {
            if (!Session.InRoom)
            {
                return;
            }

            Quest Quest = GetQuest(Session.QuestCache.CurrentQuestId);

            if (Quest == null)
            {
                return;
            }

            Session.SendData(QuestStartedComposer.Compose(Session, Quest));
        }

        private static void CancelQuest(Session Session, ClientMessage Message)
        {
            Quest Quest = GetQuest(Session.QuestCache.CurrentQuestId);

            if (Quest == null)
            {
                return;
            }

            using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
            {
                Session.QuestCache.AddOrUpdateData(MySqlClient, Quest.Id, 0, false);
            }

            Session.SendData(QuestAbortedComposer.Compose());
            GetList(Session, null);
        }
    }
}
