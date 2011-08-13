using System;

using Snowlight.Game.Rooms;
using Snowlight.Game.Sessions;
using System.Collections.Generic;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomInfoComposer
    { 
        public static ServerMessage Compose(RoomInfo Info, bool IsLoading = true, bool CheckEntry = false)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_INFO);
            Message.AppendBoolean(IsLoading); // UPDATE=FALSE, DURINGLOAD=TRUE, STALKING=FALSE
            Message.AppendUInt32(Info.Id);
            Message.AppendInt32(0); // Nothing else has ever been logged
            Message.AppendStringWithBreak(Info.Name);
            Message.AppendStringWithBreak(Info.OwnerName);
            Message.AppendInt32((int)Info.AccessType);
            Message.AppendInt32(Info.CurrentUsers);
            Message.AppendInt32(Info.MaxUsers);
            Message.AppendStringWithBreak(Info.Description);
            Message.AppendInt32(0); // Nothing else has ever been logged
            Message.AppendBoolean(Info.CanTrade); // Allow trading
            Message.AppendInt32(0); // Nothing else has ever been logged
            Message.AppendInt32(Info.CategoryId);
            Message.AppendStringWithBreak(string.Empty); // Nothing else has ever been logged
            Message.AppendInt32(Info.Tags.Count);

            foreach (string Tag in Info.Tags)
            {
                Message.AppendStringWithBreak(Tag);
            }

            Message.AppendInt32(Info.Icon.BackgroundImageId);
            Message.AppendInt32(Info.Icon.OverlayImageId);
            Message.AppendInt32(Info.Icon.Objects.Count);

            foreach (KeyValuePair<int, int> Object in Info.Icon.Objects)
            {
                Message.AppendInt32(Object.Key);
                Message.AppendInt32(Object.Value);
            }

            Message.AppendBoolean(Info.AllowPets);
            Message.AppendBoolean(true); // Always
            Message.AppendBoolean(CheckEntry); // stuff
            Message.AppendBoolean(false); // Always
            return Message;
        }
    }
}
