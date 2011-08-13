using System;

namespace Snowlight.Util
{
    /// <remarks>Original code by unknown author.</remarks>
    public class Base64Encoding
    {
        public const byte NEGATIVE = 64;
        public const byte POSITIVE = 65;

        public static byte[] EncodeInt32(Int32 i, int numBytes)
        {
            byte[] bzRes = new byte[numBytes];

            for (int j = 1; j <= numBytes; j++)
            {
                int k = ((numBytes - j) * 6);
                bzRes[j - 1] = (byte)(0x40 + ((i >> k) & 0x3f));
            }

            return bzRes;
        }

        public static byte[] EncodeUint32(uint i, int numBytes)
        {
            return EncodeInt32((Int32)i, numBytes);
        }

        public static Int32 DecodeInt32(byte[] bzData)
        {
            int i = 0;
            int j = 0;

            for (int k = bzData.Length - 1; k >= 0; k--)
            {
                int x = bzData[k] - 0x40;

                if (j > 0)
                {
                    x *= (int)Math.Pow(64.0, (double)j);
                }

                i += x;
                j++;
            }

            return i;
        }

        public static uint DecodeUInt32(byte[] bzData)
        {
            return (uint)DecodeInt32(bzData);
        }
    }
}
