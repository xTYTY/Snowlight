using System;
using System.Collections.Generic;

using Snowlight.Game.Moderation;

namespace Snowlight.Communication.Outgoing
{
    public static class HelpCategoryListComposer
    {
        public static ServerMessage Compose(Dictionary<uint, HelpCategory> CategoryList)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.HELP_CATEGORY_LIST);
            Message.AppendInt32(CategoryList.Count);

            foreach (HelpCategory Category in CategoryList.Values)
            {
                Message.AppendUInt32(Category.Id);
                Message.AppendStringWithBreak(Category.Name);
                Message.AppendInt32(Category.ArticleCount);
            }

            return Message;
        }
    }
}
