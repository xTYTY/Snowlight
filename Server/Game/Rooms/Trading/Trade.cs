using System;
using System.Collections.Generic;
using System.Text;

using Snowlight.Game.Items;
using Snowlight.Game.Sessions;
using Snowlight.Storage;
using Snowlight.Communication.Outgoing;

namespace Snowlight.Game.Rooms.Trading
{
    public enum TradeStage
    {
        Negotiating = 0,
        Finalizing = 1,
        Finalized = 2,
        Dead = 3
    }

    public class Trade
    {
        private uint mUserOne;
        private uint mUserTwo;
        private Dictionary<uint, Item> mUserOneOffers;
        private Dictionary<uint, Item> mUserTwoOffers;
        private TradeStage mTradeStage;
        private bool mUserOneAccepted;
        private bool mUserTwoAccepted;
        private object mSyncRoot;

        public uint UserOne
        {
            get
            {
                return mUserOne;
            }
        }

        public uint UserTwo
        {
            get
            {
                return mUserTwo;
            }
        }

        public Dictionary<uint, Item> UserOneOffers
        {
            get
            {
                Dictionary<uint, Item> Copy = new Dictionary<uint, Item>();

                lock (mSyncRoot)
                {
                    foreach (Item Item in mUserOneOffers.Values)
                    {
                        Copy.Add(Item.Id, Item);
                    }
                }

                return Copy;
            }
        }

        public Dictionary<uint, Item> UserTwoOffers
        {
            get
            {
                Dictionary<uint, Item> Copy = new Dictionary<uint, Item>();

                lock (mSyncRoot)
                {
                    foreach (Item Item in mUserTwoOffers.Values)
                    {
                        Copy.Add(Item.Id, Item);
                    }
                }

                return Copy;
            }
        }

        public int UserOneStackCount
        {
            get
            {
                lock (mSyncRoot)
                {
                    List<uint> Stacks = new List<uint>();
                    int StackCount = 0;

                    foreach (Item Item in mUserOneOffers.Values)
                    {
                        if (Item.Definition.AllowInventoryStack)
                        {
                            if (!Stacks.Contains(Item.DefinitionId))
                            {
                                Stacks.Add(Item.DefinitionId);
                                StackCount++;
                            }

                            continue;
                        }

                        StackCount++;
                    }

                    return StackCount;
                }
            }
        }

        public int UserTwoStackCount
        {
            get
            {
                lock (mSyncRoot)
                {
                    List<uint> Stacks = new List<uint>();
                    int StackCount = 0;

                    foreach (Item Item in mUserTwoOffers.Values)
                    {
                        if (Item.Definition.AllowInventoryStack)
                        {
                            if (!Stacks.Contains(Item.DefinitionId))
                            {
                                Stacks.Add(Item.DefinitionId);
                                StackCount++;
                            }

                            continue;
                        }

                        StackCount++;
                    }

                    return StackCount;
                }
            }
        }

        public TradeStage TradeStage
        {
            get
            {
                return mTradeStage;
            }
        }

        public bool AllUsersAccepted
        {
            get
            {
                return (mUserOneAccepted && mUserTwoAccepted);
            }
        }

        public Trade(uint UserOne, uint UserTwo)
        {
            mUserOne = UserOne;
            mUserTwo = UserTwo;

            mUserOneOffers = new Dictionary<uint, Item>();
            mUserTwoOffers = new Dictionary<uint, Item>();

            mSyncRoot = new object();
        }

        public bool OfferItem(bool User, Item Item)
        {
            lock (mSyncRoot)
            {
                if (mTradeStage != TradeStage.Negotiating || ((User && mUserOneAccepted) || (!User && mUserTwoAccepted)))
                {
                    return false;
                }

                if (!Item.Definition.AllowInventoryStack && ((User && UserOneStackCount >= 9) ||
                    (!User && UserTwoStackCount >= 9)))
                {
                    return false;
                }

                if (mUserOneOffers.ContainsKey(Item.Id) || mUserTwoOffers.ContainsKey(Item.Id))
                {
                    return false;
                }

                if (User)
                {
                    mUserOneOffers.Add(Item.Id, Item);
                }
                else
                {
                    mUserTwoOffers.Add(Item.Id, Item);
                }

                mUserOneAccepted = false;
                mUserTwoAccepted = false;
            }

            return true;
        }

        public bool TakeBackItem(bool User, uint ItemId)
        {
            lock (mSyncRoot)
            {
                if (mTradeStage != TradeStage.Negotiating || ((User && mUserOneAccepted) || (!User && mUserTwoAccepted)))
                {
                    return false;
                }

                if (User)
                {
                    if (!mUserOneOffers.ContainsKey(ItemId))
                    {
                        return false;
                    }

                    mUserOneOffers.Remove(ItemId);
                }
                else
                {
                    if (!mUserTwoOffers.ContainsKey(ItemId))
                    {
                        return false;
                    }

                    mUserTwoOffers.Remove(ItemId);
                }

                mUserOneAccepted = false;
                mUserTwoAccepted = false;
            }

            return true;
        }

        public bool AcceptTrade(bool User)
        {
            lock (mSyncRoot)
            {
                if (mTradeStage == Trading.TradeStage.Finalized)
                {
                    return false;
                }

                if (User)
                {
                    mUserOneAccepted = true;
                }
                else
                {
                    mUserTwoAccepted = true;
                }

                if (mUserOneAccepted && mUserTwoAccepted)
                {
                    mTradeStage = mTradeStage == Trading.TradeStage.Finalizing ? TradeStage.Finalized :
                        TradeStage.Finalizing;
                    mUserOneAccepted = false;
                    mUserTwoAccepted = false;
                }
            }

            return true;
        }

        public bool ModifyTrade(bool User)
        {
            lock (mSyncRoot)
            {
                if (mTradeStage != TradeStage.Negotiating)
                {
                    return false;
                }

                if (User)
                {
                    mUserOneAccepted = false;
                }
                else
                {
                    mUserTwoAccepted = false;
                }
            }

            return true;
        }

        public void DeliverItems(Session User1, Session User2)
        {
            lock (mSyncRoot)
            {
                using (SqlDatabaseClient MySqlClient = SqlDatabaseManager.GetClient())
                {
                    foreach (Item Item in mUserOneOffers.Values)
                    {
                        User1.InventoryCache.RemoveItem(Item.Id);
                        User2.InventoryCache.Add(Item);

                        Item.MoveToUserInventory(MySqlClient, User2.CharacterId);
                    }

                    foreach (Item Item in mUserTwoOffers.Values)
                    {
                        User2.InventoryCache.RemoveItem(Item.Id);
                        User1.InventoryCache.Add(Item);

                        Item.MoveToUserInventory(MySqlClient, User1.CharacterId);
                    }
                }

                User1.SendData(InventoryRefreshComposer.Compose());
                User2.SendData(InventoryRefreshComposer.Compose());

                mUserOneOffers.Clear();
                mUserTwoOffers.Clear();

                mTradeStage = TradeStage.Dead;
            }
        }
    }
}
