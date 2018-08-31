using System;

namespace DTO
{
    public class DTOEmotionGroup
    {
        private Guid _uniqueId;

        public long Id { get; set; }

        public string GroupName { get; set; }

        public long WebsiteId { get; set; }

        public long EmotionId { get; set; }

        public long EmotionGroupId { get; set; }

        public string EmotionName { get; set; }

        public Guid UniqueId
        {
            get { return _uniqueId; }
            set { _uniqueId = value; }
        }
    }
}