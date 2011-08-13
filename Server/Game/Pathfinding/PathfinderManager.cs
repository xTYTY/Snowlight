using System;
using System.Collections.Generic;

using Snowlight.Config;

namespace Snowlight.Game.Pathfinding
{
    public static class PathfinderManager
    {
        public static Pathfinder CreatePathfinderInstance()
        {
            switch (ConfigManager.GetValue("pathfinder.mode").ToString().ToLower())
            {
                default:
                case "simple":

                    return new SimplePathfinder();
            }
        }
    }
}
