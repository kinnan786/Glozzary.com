using System;

namespace DTO
{
    /// <summary>
    /// Summary description for DTOSubscription
    /// </summary>
    public class DtoUserTagSubscription
    {
        public DtoUserTagSubscription()
        {
            UserId = 0;
            TagId = 0;
            UserSubscriptionId = 0;
            TagName = "";
        }

        public long UserId { get; set; }

        public long TagId { get; set; }

        public long UserSubscriptionId { get; set; }

        public string TagName { get; set; }
    }
}