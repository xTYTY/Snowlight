using System;
using System.Collections.Generic;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class ModerationToolComposer
    {
        public static ServerMessage Compose(Session Session, List<string> UserMessagePresets,
            Dictionary<string, Dictionary<string, string>> UserActionPresets, List<string> RoomMessagePresets)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.MODERATION_TOOL_INIT);
            Message.AppendInt32(-1);
            Message.AppendInt32(UserMessagePresets.Count);

            foreach (string Preset in UserMessagePresets)
            {
                Message.AppendStringWithBreak(Preset);
            }

            Message.AppendInt32(UserActionPresets.Count);

            foreach (KeyValuePair<string, Dictionary<string, string>> PresetCategory in UserActionPresets)
            {
                Message.AppendStringWithBreak(PresetCategory.Key);
                Message.AppendInt32(PresetCategory.Value.Count);

                foreach (KeyValuePair<string, string> Preset in PresetCategory.Value)
                {
                    Message.AppendStringWithBreak(Preset.Key);
                    Message.AppendStringWithBreak(Preset.Value);
                }
            }

            Message.AppendBoolean(Session.HasRight("moderation_tickets")); // Tickets
            Message.AppendInt32(1); // Chatlogs
            Message.AppendInt32(1); // Message, user action, send caution
            Message.AppendInt32(1); // kick
            Message.AppendInt32(1); // ban
            Message.AppendInt32(1); // caution, message
            Message.AppendInt32(1); // ?

            Message.AppendInt32(RoomMessagePresets.Count);

            foreach (string Preset in RoomMessagePresets)
            {
                Message.AppendStringWithBreak(Preset);
            }

            return Message;
        }
    }
}
