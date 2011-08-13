using System;
using System.Collections.Generic;

using Snowlight.Game.Items;
using Snowlight.Game.Misc;

namespace Snowlight.Communication.Outgoing
{
    public static class MoodlightDataComposer
    {
        public static ServerMessage Compose(MoodlightData Data)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MOODLIGHT_DATA);
            Message.AppendInt32(Data.Presets.Count);
            Message.AppendInt32(Data.CurrentPreset);

            foreach (KeyValuePair<int, MoodlightPreset> Preset in Data.Presets)
            {
                Message.AppendInt32(Preset.Key);
                Message.AppendInt32(Preset.Value.BackgroundOnly ? 2 : 1);
                Message.AppendStringWithBreak(Preset.Value.ColorCode);
                Message.AppendInt32(Preset.Value.ColorIntensity);
            }

            return Message;
        }
    }
}
