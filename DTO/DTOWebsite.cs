using System;

namespace DTO
{
    /// <summary>
    /// Summary description for DTOWebsite
    /// </summary>
    public class DtoWebsite
    {
        public bool Tag { get; set; }

        public string WebsiteLogo { get; set; }


        public string Image { get; set; }

        public bool Emotion { get; set; }

        public long UserId { get; set; }

        public long WebsiteId { get; set; }

        public string WebSiteName { get; set; }

        public string WebsiteUrl { get; set; }

        public string WebsiteType { get; set; }

        public bool AddTag { get; set; }

        public bool RateTag { get; set; }

        public bool AddEmotion { get; set; }

        public DtoWebsite()
        {
            AddTag = false;
            AddEmotion = false;
            RateTag = false;
            WebsiteId = 0;
            UserId = 0;
            WebSiteName = "";
            WebsiteUrl = "";
            WebsiteType = "";
            Tag = false;
            Emotion = false;
        }
    }
}