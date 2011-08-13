using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;


using Snowlight.Specialized;
using Snowlight.Game.Items;
using Snowlight.Communication.Outgoing;
using Snowlight.Game.Sessions;
using Snowlight.Config;

namespace Snowlight.Game.Rooms
{
    public partial class RoomInstance : IDisposable
    {
        private object mItemSyncRoot;
        private Dictionary<uint, Item> mItems;
        private Dictionary<ItemBehavior, int> mItemLimitCache;
        private double[,] mStackHeight;
        private double[,] mStackTopItemHeight;
        private bool mGuestsCanPlaceStickies;
        private List<StaticObject> mStaticObjects;
        private RoomTileEffect[,] mTileEffects;
        private Vector2[,] mRedirectGrid;
        private List<Item>[,] mRollerItems;

        public bool GuestsCanPlaceStickies
        {
            get
            {
                return mGuestsCanPlaceStickies;
            }
        }

        public Item MoodlightItem
        {
            get
            {
                lock (mItemSyncRoot)
                {
                    foreach (Item Item in mItems.Values)
                    {
                        if (Item.Definition.Behavior == ItemBehavior.Moodlight)
                        {
                            return Item;
                        }
                    }
                }

                return null;
            }
        }

        public ReadOnlyCollection<Item> GetFloorItems()
        {
            lock (mItemSyncRoot)
            {
                List<Item> Items = new List<Item>();

                foreach (Item Item in mItems.Values)
                {
                    if (Item.Definition.Type == ItemType.FloorItem)
                    {
                        Items.Add(Item);
                    }
                }

                return Items.AsReadOnly();
            }
        }

        public ReadOnlyCollection<Item> GetWallItems()
        {
            lock (mItemSyncRoot)
            {
                List<Item> Items = new List<Item>();

                foreach (Item Item in mItems.Values)
                {
                    if (Item.Definition.Type == ItemType.WallItem)
                    {
                        Items.Add(Item);
                    }
                }

                return Items.AsReadOnly();
            }
        }

        public ReadOnlyCollection<Item> GetItemsOnPosition(Vector2 Position)
        {
            lock (mItemSyncRoot)
            {
                List<Item> ItemsOnPosition = new List<Item>();

                foreach (Item Item in mItems.Values)
                {
                    List<Vector2> Tiles = CalculateAffectedTiles(Item, Item.RoomPosition.GetVector2(), Item.RoomRotation);

                    foreach (Vector2 Tile in Tiles)
                    {
                        if (Tile.X == Position.X && Tile.Y == Position.Y)
                        {
                            ItemsOnPosition.Add(Item);
                        }
                    }
                }

                return ItemsOnPosition.AsReadOnly();
            }
        }

        public Item GetItem(uint ItemId)
        {
            lock (mItemSyncRoot)
            {
                if (mItems.ContainsKey(ItemId))
                {
                    return mItems[ItemId];
                }
            }

            return null;
        }

        public void IncrecementFurniLimitCache(ItemBehavior Behavior)
        {
            if (!mItemLimitCache.ContainsKey(Behavior))
            {
                mItemLimitCache.Add(Behavior, 1);
                return;
            }

            mItemLimitCache[Behavior]++;
        }

        public void DecrecementFurniLimitCache(ItemBehavior Behavior)
        {
            if (!mItemLimitCache.ContainsKey(Behavior))
            {
                return;
            }

            mItemLimitCache[Behavior]--;
        }

        public double GetItemPlacementHeight(Item Item, List<Vector2> AffectedTiles, bool RotateOnly)
        {
            lock (mItemSyncRoot)
            {
                // Collect a list of tiles we need to watch
                double RootFloorHeight = -1;
                double HighestStack = 0;

                double[,] TempStackHeights = new double[mCachedModel.Heightmap.SizeX, mCachedModel.Heightmap.SizeY];

                // Check if all tiles are valid
                foreach (Vector2 AffectedTile in AffectedTiles)
                {
                    if (!IsValidPosition(AffectedTile) || mTileStates[AffectedTile.X, AffectedTile.Y] == TileState.Door)
                    {
                        return -1;
                    }

                    if (RootFloorHeight == -1)
                    {
                        RootFloorHeight = mCachedModel.Heightmap.FloorHeight[AffectedTile.X, AffectedTile.Y];
                    }

                    if (RootFloorHeight != mCachedModel.Heightmap.FloorHeight[AffectedTile.X, AffectedTile.Y])
                    {
                        return -1; // inconsistent floor height
                    }

                    TempStackHeights[AffectedTile.X, AffectedTile.Y] = RootFloorHeight;
                    HighestStack = RootFloorHeight;

                    if (Item.Definition.StackingBehavior != ItemStackingBehavior.Ignore)
                    {
                        bool CanRotateIntoActors = (Item.Definition.Behavior == ItemBehavior.Seat ||
                            Item.Definition.Behavior == ItemBehavior.Bed || Item.Definition.Behavior ==
                            ItemBehavior.LoveShuffler || Item.Definition.Behavior == ItemBehavior.Teleporter || 
                            Item.Definition.Behavior == ItemBehavior.Roller);

                        if ((!RotateOnly || !CanRotateIntoActors) && GetActorsOnPosition(AffectedTile).Count > 0)
                        {
                            return -1;
                        }
                    }
                }

                // If this is an IGNORE item, all we need to know is that we're on a valid position etc
                if (Item.Definition.StackingBehavior == ItemStackingBehavior.Ignore)
                {
                    return RootFloorHeight;
                }

                // Loop items & build temp information for validation later
                ItemStackingBehavior[,] TempStackBehaviors = new ItemStackingBehavior[mCachedModel.Heightmap.SizeX, mCachedModel.Heightmap.SizeY];
                int[,] InitiatorLimitations = new int[mCachedModel.Heightmap.SizeX, mCachedModel.Heightmap.SizeY];

                foreach (Item StackItem in mItems.Values)
                {
                    if (StackItem.Id == Item.Id || StackItem.Definition.StackingBehavior == ItemStackingBehavior.Ignore)
                    {
                        continue; // skip - we do not process ourselves/ignores
                    }

                    Vector2 MatchedTile = null;
                    List<Vector2> ItemTiles = CalculateAffectedTiles(StackItem, StackItem.RoomPosition.GetVector2(), StackItem.RoomRotation);

                    foreach (Vector2 AffectedTile in AffectedTiles)
                    {
                        foreach (Vector2 ItemTile in ItemTiles)
                        {
                            if (ItemTile.X == AffectedTile.X && ItemTile.Y == AffectedTile.Y)
                            {
                                MatchedTile = AffectedTile;

                                if (StackItem.Definition.Behavior == ItemBehavior.Roller &&
                                    (Item.Definition.SizeX != 1 || Item.Definition.SizeY != 1))
                                {
                                    return -1;
                                }

                                double ItemTotalHeight = StackItem.RoomPosition.Z + StackItem.Definition.Height;

                                if (ItemTotalHeight >= TempStackHeights[MatchedTile.X, MatchedTile.Y])
                                {
                                    TempStackHeights[MatchedTile.X, MatchedTile.Y] = ItemTotalHeight;
                                    TempStackBehaviors[MatchedTile.X, MatchedTile.Y] = StackItem.Definition.StackingBehavior;
                                }

                                if (StackItem.Definition.StackingBehavior != ItemStackingBehavior.Ignore)
                                {
                                    InitiatorLimitations[MatchedTile.X, MatchedTile.Y]++;
                                }

                                if (ItemTotalHeight >= HighestStack)
                                {
                                    HighestStack = ItemTotalHeight;
                                }
                            }
                        }
                    }
                }

                if ((HighestStack + Item.Definition.Height) >= (int)ConfigManager.GetValue("rooms.limit.stacking"))
                {
                    return -1;
                }

                foreach (Vector2 AffectedTile in AffectedTiles)
                {
                    if (((Item.Definition.StackingBehavior == ItemStackingBehavior.Initiator || Item.Definition.StackingBehavior ==
                        ItemStackingBehavior.InitiateAndTerminate) && InitiatorLimitations[AffectedTile.X, AffectedTile.Y] > 0) ||
                        (TempStackBehaviors[AffectedTile.X, AffectedTile.Y] == ItemStackingBehavior.Terminator ||
                        TempStackBehaviors[AffectedTile.X, AffectedTile.Y] == ItemStackingBehavior.InitiateAndTerminate))
                    {
                        return -1;
                    }
                }

                return HighestStack;
            }
        }

        public bool IsValidItemRotation(int Rotation)
        {
            return (Rotation == 0 || Rotation == 2 || Rotation == 4 || Rotation == 6);
        }

        public List<Vector2> CalculateAffectedTiles(Item Item, Vector2 Position, int Rotation)
        {
            List<Vector2> Tiles = new List<Vector2>();
            Tiles.Add(Position);

            if (Item.Definition.SizeY > 0)
            {
                if (Rotation == 0 || Rotation == 4)
                {
                    for (int y = 1; y < Item.Definition.SizeY; y++)
                    {
                        Tiles.Add(new Vector2(Position.X, Position.Y + y));

                        for (int x = 1; x < Item.Definition.SizeX; x++)
                        {
                            Tiles.Add(new Vector2(Position.X + x, Position.Y + y));
                        }
                    }
                }
                else if (Rotation == 2 || Rotation == 6)
                {
                    for (int x = 1; x < Item.Definition.SizeY; x++)
                    {
                        Tiles.Add(new Vector2(Position.X + x, Position.Y));

                        for (int y = 1; y < Item.Definition.SizeX; y++)
                        {
                            Tiles.Add(new Vector2(Position.X + x, Position.Y + y));
                        }
                    }
                }
            }

            if (Item.Definition.SizeX > 0)
            {
                if (Rotation == 0 || Rotation == 4)
                {
                    for (int x = 1; x < Item.Definition.SizeX; x++)
                    {
                        Vector2 Vector = new Vector2(Position.X + x, Position.Y);

                        if (!Tiles.Contains(Vector))
                        {
                            Tiles.Add(Vector);
                        }

                        for (int y = 1; y < Item.Definition.SizeY; y++)
                        {
                            Vector2 _Vector = new Vector2(Position.X + x, Position.Y + y);

                            if (!Tiles.Contains(Vector))
                            {
                                Tiles.Add(_Vector);
                            }
                        }
                    }
                }
                else if (Rotation == 2 || Rotation == 6)
                {
                    for (int y = 1; y < Item.Definition.SizeX; y++)
                    {
                        Vector2 Vector = new Vector2(Position.X, Position.Y + y);

                        if (!Tiles.Contains(Vector))
                        {
                            Tiles.Add(Vector);
                        }

                        for (int x = 1; x < Item.Definition.SizeY; x++)
                        {
                            Vector2 _Vector = new Vector2(Position.X + x, Position.Y + y);

                            if (!Tiles.Contains(Vector))
                            {
                                Tiles.Add(Vector);
                            }
                        }
                    }
                }
            }

            return Tiles;
        }

        public string SetWallItem(Session Session, string[] Data, Item Item)
        {
            bool AlreadyContained = mItems.ContainsKey(Item.Id);
            int TotalLimitCount = AlreadyContained ? mItems.Count - 1 : mItems.Count;
            int SpecificLimitCount = mItemLimitCache.ContainsKey(Item.Definition.Behavior) ? (AlreadyContained ?
                mItemLimitCache[Item.Definition.Behavior] - 1 : mItemLimitCache[Item.Definition.Behavior]) : 0;

            if (Item.Definition.RoomLimit > 0 && SpecificLimitCount >= Item.Definition.RoomLimit)
            {
                Session.SendData(NotificationMessageComposer.Compose("This room cannot hold any more furniture of this type."));
                return string.Empty;
            }

            if (TotalLimitCount >= (int)ConfigManager.GetValue("rooms.limit.furni"))
            {
                Session.SendData(RoomItemPlacementErrorComposer.Compose(RoomItemPlacementErrorCode.FurniLimitReached));
                return string.Empty;
            }

            if (Data.Length != 3 || !Data[0].StartsWith(":w=") || !Data[1].StartsWith("l=") || (Data[2] != "r" &&
                Data[2] != "l"))
            {
                return string.Empty;
            }

            string wBit = Data[0].Substring(3, Data[0].Length - 3);
            string lBit = Data[1].Substring(2, Data[1].Length - 2);

            if (!wBit.Contains(",") || !lBit.Contains(","))
            {
                return string.Empty;
            }

            int w1 = 0;
            int w2 = 0;
            int l1 = 0;
            int l2 = 0;

            int.TryParse(wBit.Split(',')[0], out w1);
            int.TryParse(wBit.Split(',')[1], out w2);
            int.TryParse(lBit.Split(',')[0], out l1);
            int.TryParse(lBit.Split(',')[1], out l2);

            if (!Session.HasRight("hotel_admin") && (w1 < 0 || w2 < 0 || l1 < 0 || l2 < 0 || w1 > 200 || w2 > 200 || l1 > 200 || l2 > 200))
            {
                return string.Empty;
            }

            string WallPos = ":w=" + w1 + "," + w2 + " l=" + l1 + "," + l2 + " " + Data[2];

            lock (mItemSyncRoot)
            {
                if (!mItems.ContainsKey(Item.Id))
                {
                    mItems.Add(Item.Id, Item);
                    IncrecementFurniLimitCache(Item.Definition.Behavior);
                }
            }

            return WallPos;
        }

        public string SetWallItem(Session Session, string PlacementData, Item Item)
        {
            return SetWallItem(Session, PlacementData.Split(' '), Item);
        }

        public Vector3 SetFloorItem(Session Session, Item Item, Vector2 Position, int Rotation)
        {
            bool AlreadyContained = mItems.ContainsKey(Item.Id);
            int TotalLimitCount = AlreadyContained ? mItems.Count - 1 : mItems.Count;
            int SpecificLimitCount = mItemLimitCache.ContainsKey(Item.Definition.Behavior) ? (AlreadyContained ?
                mItemLimitCache[Item.Definition.Behavior] - 1 : mItemLimitCache[Item.Definition.Behavior]) : 0;

            if (Item.Definition.RoomLimit > 0 && SpecificLimitCount >= Item.Definition.RoomLimit)
            {
                Session.SendData(NotificationMessageComposer.Compose("This room cannot hold any more furniture of this type."));
                return null;
            }

            if (TotalLimitCount >= (int)ConfigManager.GetValue("rooms.limit.furni"))
            {
                Session.SendData(RoomItemPlacementErrorComposer.Compose(RoomItemPlacementErrorCode.FurniLimitReached));
                return null;
            }

            bool IsRotationOnly = (Item.RoomId == RoomId && Item.RoomPosition.X == Position.X &&
                Item.RoomPosition.Y == Position.Y && Rotation != Item.RoomRotation);

            if (!IsValidItemRotation(Rotation))
            {
                return null;
            }

            List<Vector2> AffectedTiles = CalculateAffectedTiles(Item, Position, Rotation);
            double PlacementHeight = GetItemPlacementHeight(Item, AffectedTiles, IsRotationOnly);

            if (PlacementHeight < 0)
            {
                return null;
            }

            lock (mItemSyncRoot)
            {
                if (!mItems.ContainsKey(Item.Id))
                {
                    mItems.Add(Item.Id, Item);
                    IncrecementFurniLimitCache(Item.Definition.Behavior);
                }
            }

            return new Vector3(Position.X, Position.Y, PlacementHeight);            
        }

        public bool TakeItem(uint ItemId)
        {
            Item Item = null;

            lock (mItemSyncRoot)
            {
                Item = GetItem(ItemId);

                if (Item == null)
                {
                    return false;
                }

                mItems.Remove(ItemId);
                DecrecementFurniLimitCache(Item.Definition.Behavior);
            }

            switch (Item.Definition.Type)
            {
                default:

                    BroadcastMessage(RoomFloorItemRemovedComposer.Compose(ItemId));
                    break;

                case ItemType.WallItem:

                    BroadcastMessage(RoomWallItemRemovedComposer.Compose(ItemId));
                    break;
            }

            return true;            
        }
    }
}
