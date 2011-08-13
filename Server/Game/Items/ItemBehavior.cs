using System;

namespace Snowlight.Game.Items
{
    public enum ItemBehavior
    {
        StaticItem = 1,
        Wallpaper = 2,
        Floor = 3,
        Landscape = 4,
        Switchable = 5,
        Seat = 6,
        Bed = 7,
        Gate = 8,
        Teleporter = 9,
        OneWayGate = 10,
        TraxPlayer = 11,
        ExchangeItem = 12,
        Moodlight = 13,
        Roller = 14,
        AvatarEffectGenerator = 15,
        PrizeTrophy = 16,
        WiredTrigger = 17,
        WiredCondition = 18,
        WiredEffect = 19,
        TimedAlert = 20,
        StepSwitch = 21,
        Football = 22,
        Dice = 23,
        HoloDice = 24,
        SpinningBottle = 25,
        HabboWheel = 26,
        LoveShuffler = 27,
        StickyNote = 28,
        StickyPole = 29,
        Scoreboard = 30,
        Pet = 31,
        Dispenser = 32,
        Fireworks = 33,
        MusicDisk = 34,
        Rental = 35
    }

    public static class ItemBehaviorUtil
    {
        public static ItemBehavior FromString(string BehaviorString)
        {
            switch (BehaviorString.ToLower())
            {
                case "rental":

                    return ItemBehavior.Rental;

                case "musicdisk":

                    return ItemBehavior.MusicDisk;

                case "fireworks":

                    return ItemBehavior.Fireworks;

                case "dispenser":

                    return ItemBehavior.Dispenser;

                case "pet":

                    return ItemBehavior.Pet;

                case "scoreboard":

                    return ItemBehavior.Scoreboard;

                case "prizetrophy":

                    return ItemBehavior.PrizeTrophy;

                case "stickypole":

                    return ItemBehavior.StickyPole;

                case "stickynote":

                    return ItemBehavior.StickyNote;

                case "loveshuffler":

                    return ItemBehavior.LoveShuffler;

                case "spinningbottle":

                    return ItemBehavior.SpinningBottle;

                case "habbowheel":

                    return ItemBehavior.HabboWheel;

                case "dice":

                    return ItemBehavior.Dice;

                case "holodice":

                    return ItemBehavior.HoloDice;

                case "football":

                    return ItemBehavior.Football;

                case "autoswitch":

                    return ItemBehavior.StepSwitch;

                case "alert":

                    return ItemBehavior.TimedAlert;

                case "wiredeffect":

                    return ItemBehavior.WiredEffect;

                case "wiredcondition":

                    return ItemBehavior.WiredCondition;

                case "wiredtrigger":

                    return ItemBehavior.WiredTrigger;

                case "effectgenerator":

                    return ItemBehavior.AvatarEffectGenerator;

                case "roller":

                    return ItemBehavior.Roller;

                case "moodlight":

                    return ItemBehavior.Moodlight;

                case "traxplayer":

                    return ItemBehavior.TraxPlayer;

                case "onewaygate":

                    return ItemBehavior.OneWayGate;

                case "teleporter":

                    return ItemBehavior.Teleporter;

                case "gate":

                    return ItemBehavior.Gate;

                case "exchange":

                    return ItemBehavior.ExchangeItem;

                case "bed":

                    return ItemBehavior.Bed;

                case "seat":

                    return ItemBehavior.Seat;

                case "switch":

                    return ItemBehavior.Switchable;

                case "landscape":

                    return ItemBehavior.Landscape;

                case "floor":

                    return ItemBehavior.Floor;

                case "wallpaper":

                    return ItemBehavior.Wallpaper;

                default:

                    return ItemBehavior.StaticItem;
            }
        }
    }
}
