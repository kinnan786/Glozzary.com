using System;

namespace DTO
{
    /// <summary>
    /// Summary description for Tag
    /// </summary>
    public class DtoTag
    {
        public bool IsActive { get; set; }

        public long UserId { get; set; }

        public string About { get; set; }

        public string VoteType { get; set; }

        public long TagId { get; set; }

        public string TagName { get; set; }

        public long TagCount { get; set; }

        public string WebsiteName { get; set; }

        public string Link { get; set; }

        public int TotalRec { get; set; }

        public int TotalPage { get; set; }

        public string TagType { get; set; }

        public bool MetaTagCheck { get; set; }

        public DtoTag()
        {
            TagId = 0;
            TagName = "";
            Link = "";
            WebsiteName = "";
            IsActive = false;
        }
    }
}