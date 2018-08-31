using System;

namespace DTO
{
    /// <summary>
    /// Summary description for DTOUser
    /// </summary>
    public class DtoUser
    {
        public string CoverPhoto { get; set; }

        public long UserId { get; set; }

        public string NewPassword { get; set; }

        public string Email { get; set; }

        public string Password { get; set; }

        public string UserName { get; set; }

        public string FirstName { get; set; }

        public string Lastname { get; set; }

        public bool Emailverified { get; set; }

        public string Guid { get; set; }

        public bool FaceBookAuthentication { get; set; }

        public string ImageUrl { get; set; }

        public bool IsUser { get; set; }

        public DtoUser()
        {
            ImageUrl = "";
            UserId = 0;
            Password = "";
            UserName = "";
            Email = "";
            Emailverified = false;
            Guid = "";
            CoverPhoto = "";
        }
    }
}