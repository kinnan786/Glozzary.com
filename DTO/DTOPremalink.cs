using System;
using System.Collections.Generic;

namespace DTO
{
    /// <summary>
    /// Summary description for DTOPremalink
    /// </summary>
    public class DtoPremalink
    {
        public string SiteName { get; set; }

        public DateTime PublishedTime { get; set; }

        public long TagId { get; set; }

        public long WebsiteId { get; set; }

        public long PremalinkId { get; set; }

        public string TagName { get; set; }

        public string WebsiteName { get; set; }

        public string Link { get; set; }

        public long TagCount { get; set; }

        public string Image { get; set; }

        public string Description { get; set; }

        public string Title { get; set; }

        public string Type { get; set; }

        public string Keywords { get; set; }

        public string WebSiteUrl { get; set; }

        public bool TagCreated { get; set; }

        public List<DtoTag> Tag { get; set; }

        public int TotalRec { get; set; }

        public int TotalPage { get; set; }

        public DtoPremalink()
        {
            TagCreated = false;
            WebsiteName = "";
            WebSiteUrl = "";
            PremalinkId = 0;
            WebsiteId = 0;
            Link = "";
            TagCount = 0;
            Image = "";
            Description = "";
            Title = "";
            Type = "";
            Keywords = "";
            TagId = 0;
            SiteName = "";
            PublishedTime = DateTime.Now;
        }
    }
}