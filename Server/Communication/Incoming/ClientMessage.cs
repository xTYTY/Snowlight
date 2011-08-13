using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Snowlight.Util;
using Snowlight.Config;

namespace Snowlight.Communication
{
    public class ClientMessage
    {
        private uint mMessageId;
        private byte[] mBody;
        private int mPointer;

        public uint Id
        {
            get
            {
                return mMessageId;
            }
        }

        public int Length
        {
            get
            {
                return mBody.Length;
            }
        }

        public int RemainingLength
        {
            get
            {
                return mBody.Length - mPointer;
            }
        }

        public string HeaderString
        {
            get
            {
                return Constants.DefaultEncoding.GetString(Base64Encoding.EncodeUint32(mMessageId, 2));
            }
        }

        public ClientMessage(uint MessageId, byte[] Body)
        {
            if (Body == null)
            {
                Body = new byte[0];
            }

            mMessageId = MessageId;
            mBody = Body;
            mPointer = 0;
        }

        public override string ToString()
        {
            return HeaderString + BodyToString();
        }

        public void ResetPointer()
        {
            mPointer = 0;
        }

        private void AdvancePointer(int i)
        {
            mPointer += i;
        }

        public string BodyToString()
        {
            return Constants.DefaultEncoding.GetString(mBody);
        }

        public byte[] ReadBytes(int Bytes)
        {
            if (Bytes > this.RemainingLength)
            {
                Bytes = this.RemainingLength;
            }

            byte[] data = new byte[Bytes];

            for (int i = 0; i < Bytes; i++)
            {
                data[i] = mBody[mPointer++];
            }

            return data;
        }

        public byte[] PlainReadBytes(int Bytes)
        {
            if (Bytes > RemainingLength)
            {
                Bytes = RemainingLength;
            }

            byte[] data = new byte[Bytes];

            for (int x = 0, y = mPointer; x < Bytes; x++, y++)
            {
                data[x] = mBody[y];
            }

            return data;
        }

        public byte[] ReadFixedValue()
        {
            int len = Base64Encoding.DecodeInt32(ReadBytes(2));
            return ReadBytes(len);
        }

        public Boolean PopBase64Boolean()
        {
            if (RemainingLength > 0 && mBody[mPointer++] == Base64Encoding.POSITIVE)
            {
                return true;
            }

            return false;
        }

        public Int32 PopInt32()
        {
            return Base64Encoding.DecodeInt32(ReadBytes(2));
        }

        public UInt32 PopUInt32()
        {
            return (UInt32)PopInt32();
        }

        public string PopString()
        {
            return PopString(Constants.DefaultEncoding);
        }

        public string PopString(Encoding Encoding)
        {
            return Encoding.GetString(ReadFixedValue());
        }

        public Int32 PopFixedInt32()
        {
            Int32 i = 0;
            string s = PopString(Encoding.ASCII);
            Int32.TryParse(s, out i);
            return i;
        }

        public UInt32 PopFixedUInt32()
        {
            uint j = 0;
            uint.TryParse(PopFixedInt32().ToString(), out j);
            return j;
        }

        public Boolean PopWiredBoolean()
        {
            if (this.RemainingLength > 0 && mBody[mPointer++] == WireEncoding.POSITIVE)
            {
                return true;
            }

            return false;
        }

        public Int32 PopWiredInt32()
        {
            if (RemainingLength < 1)
            {
                return 0;
            }

            byte[] Data = PlainReadBytes(WireEncoding.MAX_INTEGER_BYTE_AMOUNT);

            Int32 TotalBytes = 0;
            Int32 i = WireEncoding.DecodeInt32(Data, out TotalBytes);

            mPointer += TotalBytes;

            return i;
        }

        public UInt32 PopWiredUInt32()
        {
            uint j = 0;
            uint.TryParse(PopWiredInt32().ToString(), out j);
            return j;
        }
    }
}
