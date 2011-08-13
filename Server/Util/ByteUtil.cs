using System;

namespace Snowlight.Util
{
    public static class ByteUtil
    {
        public static byte[] Subbyte(byte[] Bytes, int Offset, int ByteCount)
        {
            int End = (Offset + ByteCount);

            if (End > Bytes.Length)
            {
                End = Bytes.Length;
            }

            int ChunkLength = End - ByteCount;

            if (ByteCount > Bytes.Length)
            {
                ByteCount = Bytes.Length;
            }

            if (ByteCount < 0)
            {
                ByteCount = 0;
            }

            byte[] Chunk = new byte[ByteCount];

            for (int x = 0; x < ByteCount; x++)
            {
                Chunk[x] = Bytes[Offset++];
            }

            return Chunk;
        }
    }
}
