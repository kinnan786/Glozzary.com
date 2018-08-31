namespace DTO
{
    /// <summary>
    /// Summary description for DTOPremalinkTag
    /// </summary>
    public class DtoPremalinkTag
    {
        public DtoPremalinkTag()
        {
            Id = 0;
            PremalinkId = 0;
            TagId = 0;
            TotalVote = 0;
            UpVote = 0;
            DownVote = 0;
        }

        public int Id { get; set; }

        public int PremalinkId { get; set; }

        public int TagId { get; set; }

        public int TotalVote { get; set; }

        public int UpVote { get; set; }

        public int DownVote { get; set; }
    }
}