using System;

using Snowlight.Game.Rooms;
using Snowlight.Util;

namespace Snowlight.Communication.Outgoing
{
    public static class RoomEditInfoComposer
    {
        public static ServerMessage Compose(RoomInstance Instance)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.ROOM_EDIT_INFO);
            Message.AppendUInt32(Instance.Info.Id);
            Message.AppendStringWithBreak(Instance.Info.Name);
            Message.AppendStringWithBreak(Instance.Info.Description);
            Message.AppendInt32((int)Instance.Info.AccessType);
            Message.AppendInt32(Instance.Info.CategoryId);
            Message.AppendInt32(Instance.Info.MaxUsers);
            Message.AppendInt32(Instance.Model.MaxUsers);
            Message.AppendInt32(Instance.Info.Tags.Count);

            foreach (string Tag in Instance.Info.Tags)
            {
                Message.AppendStringWithBreak(Tag);
            }

            Message.AppendInt32(Instance.UsersWithRights.Count);

            foreach (uint User in Instance.UsersWithRights)
            {
                Message.AppendUInt32(User);
                Message.AppendStringWithBreak(CharacterResolverCache.GetNameFromUid(User));
            }

            // GQjl~rkfasfs!qwHHQFQFHHHIHIHHH

            Message.AppendInt32(Instance.UsersWithRights.Count);
            Message.AppendBoolean(Instance.Info.AllowPets);
            Message.AppendBoolean(Instance.Info.AllowPetEating);
            Message.AppendBoolean(Instance.Info.DisableRoomBlocking);
            Message.AppendBoolean(Instance.Info.HideWalls);
            Message.AppendInt32(Instance.Info.WallThickness);
            Message.AppendInt32(Instance.Info.FloorThickness);
            return Message;
        }
    }
}
