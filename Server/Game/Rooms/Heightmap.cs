using System;
using System.Text.RegularExpressions;
using System.Text;

namespace Snowlight.Game.Rooms
{
    public enum TileState
    {
        Open = 0,
        Blocked = 1,
        Door = 2
    }

    public class Heightmap
    {
        private TileState[,] mTileStates;
        private int[,] mFloorHeight;
        private int mSizeX;
        private int mSizeY;

        public TileState[,] TileStates
        {
            get
            {
                return mTileStates;
            }
        }

        public int[,] FloorHeight
        {
            get
            {
                return mFloorHeight;
            }
        }

        public int SizeX
        {
            get
            {
                return mSizeX;
            }
        }

        public int SizeY
        {
            get
            {
                return mSizeY;
            }
        }

        public Heightmap(string HeightmapData)
        {
            string[] Lines = Regex.Split(HeightmapData, "\r\n");

            mSizeX = Lines[0].Length;
            mSizeY = Lines.Length;

            mTileStates = new TileState[SizeX, SizeY];
            mFloorHeight = new int[SizeX, SizeY];

            for (int y = 0; y < SizeY; y++)
            {
                for (int x = 0; x < SizeX; x++)
                {
                    string Value = Lines[y][x].ToString().ToLower();

                    mTileStates[x, y] = (Value == "x" ? TileState.Blocked : TileState.Open);
                    mFloorHeight[x, y] = (Value == "x" ? 0 : int.Parse(Value));
                }
            }
        }

        public override string ToString()
        {
            StringBuilder Sb = new StringBuilder();

            for (int y = 0; y < SizeY; y++)
            {
                for (int x = 0; x < SizeX; x++)
                {
                    Sb.Append(mTileStates[x, y] == TileState.Blocked ? "x" : mFloorHeight[x, y].ToString());
                }

                Sb.Append(Convert.ToChar(13));
            }

            return Sb.ToString();
        }
    }
}
