using System;
using System.Collections.Generic;
using System.Linq;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    /// <summary>
    ///     Summary description for BLLUser
    /// </summary>
    public class BllUser
    {
        private DalUser _daluser;

        public long FaceBookAuthetication(string id, string Email, string FirstName, string LastName)
        {
            try
            {
                _daluser = new DalUser();
                string profilePic = "http://graph.facebook.com/" + id + "/picture?type=large";
                string verificationCode = Guid.NewGuid().ToString();

                return _daluser.FacebookAuthentication(Email, FirstName, LastName, id, verificationCode, profilePic);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DtoNewsFeed> GetExploreNewsFeed(long UserId, long tagId, long PageNumber, long RowsPerPage)
        {
            try
            {
                var dalemotion = new DalEmotions();

                var lstdtonewsfeed = new List<DtoNewsFeed>();
                var newlstdtonewsfeed = new List<DtoNewsFeed>();
                var lstemotion = new List<DtoEmotions>();

                _daluser = new DalUser();

                lstdtonewsfeed = _daluser.GetExploreNewsFeed(UserId, tagId, PageNumber, RowsPerPage);

                IEnumerable<long> query = (from ca in lstdtonewsfeed
                    select ca.PremalinkId).Distinct();

                foreach (long item in query)
                {
                    IEnumerable<DtoNewsFeed> query2 = from ca in lstdtonewsfeed
                        where ca.PremalinkId == item
                        select ca;
                    string str = "";
                    int index = 0;
                    foreach (DtoNewsFeed dto in query2)
                    {
                        str += "|" + dto.TagId + "," + dto.TagName + "," + dto.TotalVote + "," + dto.UpVote + "," +
                               dto.DownVote +
                               "," + dto.TaggedByUser + ",";
                        index += 1;

                        if (index == query2.Count())
                            newlstdtonewsfeed.Add(new DtoNewsFeed
                            {
                                PremalinkId = dto.PremalinkId,
                                Title = dto.Title,
                                Description = dto.Description,
                                Image = dto.Image,
                                CreatedOn = dto.CreatedOn,
                                Tagstring = str,
                                Link = dto.Link
                            });
                    }
                }

                foreach (DtoNewsFeed newaa in newlstdtonewsfeed)
                {
                    lstemotion = dalemotion.GetPremalinkEmotions(newaa.Link, UserId);

                    string str1 = "";

                    if (lstemotion != null)
                    {
                        foreach (DtoEmotions dto in lstemotion)
                            str1 += "|" + dto.Emotionid + "," + dto.EmotionName + "," + dto.TotalCount + "," +
                                    dto.IsActive;

                        newaa.EmotionString = str1;
                    }
                }
                return newlstdtonewsfeed;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoNewsFeed> GetUserNewsFeed(long UserID, long PageNumber, long RowsPerPage)
        {
            try
            {
                long? userId = UserID;

                var dalemotion = new DalEmotions();

                var newlstdtonewsfeed = new List<DtoNewsFeed>();

                _daluser = new DalUser();

                List<DtoNewsFeed> lstdtonewsfeed = _daluser.GetUserNewsFeed(UserID, PageNumber, RowsPerPage);

                if (lstdtonewsfeed != null)
                {
                    IEnumerable<long> query = (from ca in lstdtonewsfeed
                        select ca.PremalinkId).Distinct();

                    foreach (long item in query)
                    {
                        IEnumerable<DtoNewsFeed> query2 = from ca in lstdtonewsfeed
                            where ca.PremalinkId == item
                            select ca;
                        string str = "";
                        int index = 0;
                        foreach (DtoNewsFeed dto in query2)
                        {
                            str += "|" + dto.TagId + "," + dto.TagName + "," + dto.TotalVote + "," + dto.UpVote + "," +
                                   dto.DownVote + "," + dto.TaggedByUser + ",";
                            index += 1;

                            if (index == query2.Count())
                                newlstdtonewsfeed.Add(new DtoNewsFeed
                                {
                                    WebsiteId = dto.WebsiteId,
                                    WebsiteImage = dto.WebsiteImage,
                                    WebsiteName = dto.WebsiteName,
                                    WebSiteURL = dto.WebSiteURL,
                                    PremalinkId = dto.PremalinkId,
                                    Title = dto.Title,
                                    Description = dto.Description,
                                    Image = dto.Image,
                                    CreatedOn = dto.CreatedOn,
                                    Tagstring = str,
                                    Link = dto.Link
                                });
                        }
                    }

                    foreach (DtoNewsFeed newaa in newlstdtonewsfeed)
                    {
                        List<DtoEmotions> lstemotion = dalemotion.GetPremalinkEmotions(newaa.Link, userId);

                        string str1 = "";

                        if (lstemotion != null)
                        {
                            foreach (DtoEmotions dto in lstemotion)
                                str1 += "|" + dto.Emotionid + "," + dto.EmotionName + "," + dto.TotalCount + "," +
                                        dto.IsActive;

                            newaa.EmotionString = str1;
                        }
                    }
                }
                return newlstdtonewsfeed;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoNewsFeed> GetUserTagFeed(long UserID, string tagid, string EmoId, long PageNumber,
            long RowsPerPage)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.GetUserTagFeed(UserID, tagid, EmoId, PageNumber, RowsPerPage);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public long RegisterUser(DtoUser dtouser)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.RegisterUser(dtouser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long Registerwebsite(DtoUser dtouser)
        {
            try
            {
                long flag = 0;
                _daluser = new DalUser();

                flag = _daluser.RegisterUser(dtouser);

                if (flag > 0)
                {
                    var dalwebsite = new DalWebsite();
                
                    dalwebsite.RegisterWebsite(new DtoWebsite
                    {
                        WebSiteName = dtouser.FirstName,
                        WebsiteUrl = dtouser.ImageUrl,
                        UserId = flag
                    });
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }


        public Int64 AuthenticateUser(DtoUser dtouser)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.AuthenticateUser(dtouser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public DtoUser GetUserGeneralInfo(Int64 userId)
        {
            try
            {
                _daluser = new DalUser();
                DtoUser dtouser = _daluser.GetUserGeneralInfo(userId);
                return dtouser;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public Int64 UpdateUser(DtoUser dtouser)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.UpdateUser(dtouser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public Int64 UpdatePassword(DtoUser dtouser)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.UpdatePassword(dtouser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public Int64 VerifyEmail(DtoUser dtouser)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.VerifyEmail(dtouser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public string GetUserPassword(string email)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.GetUserPassword(email);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string AddUserImage(long userId, string imageurl)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.AddUserImage(userId, imageurl);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string AddUserCoverImage(long userId, string imageurl)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.AddUserCoverImage(userId, imageurl);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string UpdateUserImage(long userId, string imageurl)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.UpdateUserImage(userId, imageurl);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string UpdateUsercoverphoto(long userId, string imageurl)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.UpdateUsercoverphoto(userId, imageurl);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string DeleteUserImage(long imageid)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.DeleteUserImage(imageid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetUserImage(Int64 userId)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.GetUserImage(userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetCoverImage(Int64 userId)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.GetCoverImage(userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public Dictionary<string, string> GetUserImage(Int64 userId, long imageid)
        {
            try
            {
                _daluser = new DalUser();
                return _daluser.GetUserImage(userId, imageid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}