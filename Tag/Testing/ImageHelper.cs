using System;
using System.IO;
using System.Linq;
using System.Net;

namespace Tag.Testing
{
    public static class ImageHelper
    {
        public static int[] GetImageSize(string url)
        {
            string imageUrl = url;
            byte[] pngSignature = new byte[] { 137, 80, 78, 71, 13, 10, 26, 10 };
            byte[] jpgSignature = new byte[] { 255, 216, 255, 224, 0, 16, 74, 70 };

            HttpWebRequest wReq = (HttpWebRequest)WebRequest.Create(imageUrl);
            wReq.AddRange(0, 30);
            WebResponse wRes;
            try
            {
                wRes = wReq.GetResponse();
            }
            catch
            {
                return null;
            }

            byte[] buffer = new byte[30];
            int width = 0;
            int height = 0;

            using (Stream stream = wRes.GetResponseStream())
            {
                stream.Read(buffer, 0, 30);
            }

            // Check for Png
            // 8 byte - Signature
            // 4 byte - Chunk length
            // 4 byte - Chunk type - IDHR (Image Header)
            // 4 byte - Width
            // 4 byte - Height
            // Other stuff we don't care about
            if (buffer.Take(8).SequenceEqual(pngSignature))
            {
                var idhr = buffer.Skip(12);
                width = BitConverter.ToInt32(idhr.Skip(4).Take(4).Reverse().ToArray(), 0);
                height = BitConverter.ToInt32(idhr.Skip(8).Take(4).Reverse().ToArray(), 0);
            }
            //Check for Jpg
            else if (buffer.Take(8).SequenceEqual(jpgSignature))
            {
                var idhr = buffer.Skip(12);
                width = BitConverter.ToInt32(idhr.Skip(4).Take(4).Reverse().ToArray(), 0);
                height = BitConverter.ToInt32(idhr.Skip(8).Take(4).Reverse().ToArray(), 0);
            }
            // Check for Gif
            //else if (etc...

            Int32[] arr = new Int32[2];
            arr[0] = width;
            arr[1] = height;
            return arr;

            //Console.WriteLine("Width: " + width);
            //Console.WriteLine("Height: " + height);
            //Console.ReadKey();
        }
    }
}