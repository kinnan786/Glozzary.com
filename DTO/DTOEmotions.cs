using System;

namespace DTO
{
    /// <summary>
    /// Summary description for DTOEmotions
    /// </summary>
    public class DtoEmotions
    {
        public long EmotionUserId { get; set; }

        public long Emotionid { get; set; }

        public string EmotionName { get; set; }

        public bool IsActive { get; set; }

        public long TotalCount { get; set; }



        public DtoEmotions()
        {
            Emotionid = 0;
            EmotionName = "";
            IsActive = false;
            TotalCount = 0;
        }

        public long EmotionUser { get; set; }
    }
}