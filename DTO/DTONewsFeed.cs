using System;

namespace DTO
{
    public class DtoNewsFeed
    {
        public string Tagstring { get; set; }

        public string WebsiteImage { get; set; }

        public long EmotionId { get; set; }

        public string EmotionName { get; set; }

        public long TotalCount { get; set; }

        public bool IsActive { get; set; }

        public long UserId { get; set; }

        public long TagId { get; set; }

        public string TagName { get; set; }

        public long TotalVote { get; set; }

        public int UpVote { get; set; }

        public int DownVote { get; set; }

        public string WebsiteName { get; set; }

        public string Link { get; set; }

        public string SiteName { get; set; }

        private DateTime publishedTime { get; set; }

        public string Image { get; set; }

        public string Description { get; set; }

        public string Title { get; set; }

        public string WebSiteURL { get; set; }

        public bool TaggedByUser { get; set; }

        public long PremalinkId { get; set; }

        public long WebsiteId { get; set; }

        public DateTime CreatedOn { get; set; }

        private string emotionString;

        public string EmotionString
        {
            get { return emotionString; }
            set { emotionString = value; }
        }

        public DtoNewsFeed()
        {
            emotionString = "";
            TagId = 0;
            TagName = "";
            TaggedByUser = false;
            WebSiteURL = "";
            WebsiteName = "";
            Title = "";
            UpVote = 0;
            TotalVote = 0;
            DownVote = 0;
            Link = "";
            Description = "";
            Image = "";
            WebsiteId = 0;
            EmotionId = 0;
            EmotionName = "";
            IsActive = false;
            TotalCount = 0;
            Tagstring = "";
        }
    }
}