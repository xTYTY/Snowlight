using System;
using System.Text;
using System.Collections.Generic;
using System.Web;

namespace Snowlight.Communication.Outgoing
{
    public enum ChatType
    {
        Say = 0,
        Shout = 1,
        Whisper = 2
    }

    public static class RoomChatComposer
    {
        public static ServerMessage Compose(uint ActorId, string MessageText, int EmotionId, ChatType ChatType)
        {
            StringBuilder TextBuilder = new StringBuilder();
            Dictionary<int, string> LinkRefs = new Dictionary<int, string>();
            string[] Bits = MessageText.Split(' ');

            int i = 0;
            int j = 0;

            foreach (string Bit in Bits)
            {
                if (j > 0)
                {
                    TextBuilder.Append(' ');
                }

                if (Bit.StartsWith("http://"))
                {
                    LinkRefs.Add(i, Bit);
                    TextBuilder.Append("{" + i++ + "}");
                }
                else if (Bit.StartsWith("www."))
                {
                    LinkRefs.Add(i, Bit);
                    TextBuilder.Append("{" + i++ + "}");
                }
                else
                {
                    TextBuilder.Append(Bit);
                }

                j++;
            }

            ServerMessage Message = new ServerMessage(ChatType == ChatType.Say ? OpcodesOut.ROOM_CHAT_SAY : (ChatType ==
                ChatType.Whisper ? OpcodesOut.ROOM_CHAT_WHISPER : OpcodesOut.ROOM_CHAT_SHOUT));
            Message.AppendUInt32(ActorId);
            Message.AppendStringWithBreak(TextBuilder.ToString());
            Message.AppendInt32(EmotionId);
            Message.AppendInt32(LinkRefs.Count);   

            foreach (KeyValuePair<int, string> LinkedRef in LinkRefs)
            {
                string Url = LinkedRef.Value;

                if (!Url.StartsWith("http://"))
                {
                    Url = "http://" + Url;
                }

                Message.AppendStringWithBreak("/link_to.php?url=" + HttpUtility.UrlEncode(Url) + "&hash=xx");
                Message.AppendStringWithBreak(LinkedRef.Value);
                Message.AppendBoolean(true); // Trusted URL (instaopen)
            }

            Message.AppendInt32(0); // No idea
            return Message;
        }
    }
}
