using System;
using System.Collections.Generic;
using System.Text;

using Snowlight.Util;
using Snowlight.Config;

namespace Snowlight.Communication
{
    public class ServerMessage
    {
        private uint mMessageId;
        private List<byte> mBody;

        public uint Id
        {
            get
            {
                return mMessageId;
            }
        }

        public string HeaderString
        {
            get
            {
                return Constants.DefaultEncoding.GetString(Base64Encoding.EncodeUint32(mMessageId, 2));
            }
        }

        public int Length
        {
            get
            {
                return mBody.Count;
            }
        }

        public ServerMessage(uint MessageId)
        {
            mMessageId = MessageId;
            mBody = new List<byte>();
        }

        public override string ToString()
        {
            return HeaderString + Constants.DefaultEncoding.GetString(mBody.ToArray());
        }

        public string BodyToString()
        {
            return Constants.DefaultEncoding.GetString(mBody.ToArray());
        }

        public void ClearBody()
        {
            mBody.Clear();
        }

        public void AppendByte(byte b)
        {
            mBody.Add(b);
        }

        public void AppendBytes(byte[] Data)
        {
            if (Data == null || Data.Length == 0)
            {
                return;
            }

            mBody.AddRange(Data);
        }

        public void AppendRawString(string String)
        {
            AppendRawString(String, Constants.DefaultEncoding);
        }

        public void AppendRawString(string String, Encoding Encoding)
        {
            if (String == null || String.Length == 0)
            {
                return;
            }

            AppendBytes(Encoding.GetBytes(String));
        }

        public void AppendRawDouble(double Double)
        {
            string Raw = Math.Round(Double, 1).ToString();

            if (Raw.Length == 1)
            {
                Raw += ".0";
            }

            AppendStringWithBreak(Raw.Replace(',', '.'));
        }

        public void AppendStringWithBreak(string String)
        {
            AppendStringWithBreak(String, 2);
        }

        public void AppendStringWithBreak(string s, byte BreakChar)
        {
            AppendRawString(s);
            AppendByte(BreakChar);
        }

        public void AppendInt32(Int32 i)
        {
            AppendBytes(WireEncoding.EncodeInt32(i));
        }

        public void AppendRawInt32(Int32 i)
        {
            AppendRawString(i.ToString(), Encoding.ASCII);
        }

        public void AppendUInt32(uint i)
        {
            Int32 _i = (Int32)i;
            AppendInt32(_i);
        }

        public void AppendRawUInt32(uint i)
        {
            Int32 _i = (Int32)i;
            AppendRawInt32(_i);
        }

        public void AppendBoolean(bool Bool)
        {
            if (Bool)
            {
                mBody.Add(WireEncoding.POSITIVE);
                return;
            }

            mBody.Add(WireEncoding.NEGATIVE);
        }

        public byte[] GetBytes()
        {
            byte[] Data = new byte[Length + 3];
            byte[] Header = Base64Encoding.EncodeUint32(mMessageId, 2);

            Data[0] = Header[0];
            Data[1] = Header[1];

            for (int i = 0; i < Length; i++)
            {
                Data[i + 2] = mBody[i];
            }

            Data[Data.Length - 1] = 1;

            return Data;
        }
    }
}
