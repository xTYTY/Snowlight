using System;
using System.Collections.Generic;

using Snowlight.Game.Navigation;

namespace Snowlight.Communication.Outgoing
{
    public static class NavigatorFlatCategoriesComposer
    {
        public static ServerMessage Compose(List<FlatCategory> Categories)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.NAVIGATOR_FLAT_CATEGORIES);
            Message.AppendInt32(Categories.Count);

            foreach (FlatCategory Category in Categories)
            {
                Message.AppendInt32(Category.Id);
                Message.AppendStringWithBreak(Category.Title);
                Message.AppendBoolean(Category.Visible);
            }

            return Message;
        }
    }
}
