using System;
using System.Collections.Generic;

using Snowlight.Game.Catalog;
using Snowlight.Game.Sessions;

namespace Snowlight.Communication.Outgoing
{
    public static class CatalogIndexComposer
    {
        public static ServerMessage Compose(Session Session, Dictionary<int, CatalogPage> Pages)
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_INDEX);
            SerializePage(Message, Pages[-1], CalcTreeSize(Session, Pages, -1));

            foreach (CatalogPage Page in Pages.Values)
            {
                if (Page.ParentId != -1 || (Page.RequiredRight.Length > 0 && !Session.HasRight(Page.RequiredRight)))
                {
                    continue;
                }

                SerializePage(Message, Page, CalcTreeSize(Session, Pages, Page.Id));

                foreach (CatalogPage ChildPage in Pages.Values)
                {
                    if (ChildPage.ParentId != Page.Id || (ChildPage.RequiredRight.Length > 0 && !Session.HasRight(ChildPage.RequiredRight)))
                    {
                        continue;
                    }

                    SerializePage(Message, ChildPage, 0);
                }
            }

            return Message;
        }

        public static ServerMessage ComposeTextIndex()
        {
            ServerMessage Message = new ServerMessage(OpcodesOut.CATALOG_INDEX);
            Message.AppendInt32(1);
            Message.AppendInt32(0);
            Message.AppendInt32(0);
            Message.AppendInt32(-1);
            Message.AppendStringWithBreak(string.Empty);
            Message.AppendInt32(130);

            for (int i = 0; i < 130; i++)
            {
                Message.AppendBoolean(true);
                Message.AppendInt32(i);
                Message.AppendInt32(i);
                Message.AppendInt32(i);
                Message.AppendStringWithBreak("#" + i);
                Message.AppendInt32(0);
            }

            return Message;
        }

        private static void SerializePage(ServerMessage Message, CatalogPage Page, int TreeSize)
        {
            Message.AppendBoolean(Page.Visible);
            Message.AppendInt32(Page.Color);
            Message.AppendInt32(Page.Icon);
            Message.AppendInt32(Page.Id);
            Message.AppendStringWithBreak(Page.Caption + (Page.RequiredRight.Length > 0 ? "*" : string.Empty));
            Message.AppendInt32(TreeSize);
        }

        private static int CalcTreeSize(Session Session, Dictionary<int, CatalogPage> Pages, int ParentId)
        {
            int Num = 0;

            foreach (CatalogPage Page in Pages.Values)
            {
                if (Page.RequiredRight.Length > 0 && !Session.HasRight(Page.RequiredRight))
                {
                    continue;
                }

                if (Page.ParentId == ParentId)
                {
                    Num++;
                }
            }

            return Num;
        }
    }
}
