using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALWebsite
    /// </summary>
    public class DalWebsite : ConnectionClass
    {
        private DtoNewsFeed _dtonewsfeed;
        private List<DtoWebsite> _lstwebsite;
        private DtoWebsite _website;


        public List<DtoWebsite> SearchWebsite(string prefixText)
        {
            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@PrefixText", prefixText);

                _lstwebsite = new List<DtoWebsite>();

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spSearchWebsite.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website = new DtoWebsite
                    {
                        WebsiteId = Convert.ToInt64(datareader["Id"]),
                        WebSiteName = datareader["Name"].ToString()
                    };
                    _lstwebsite.Add(_website);
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return _lstwebsite;
        }


        public List<DtoNewsFeed> GetWebsiteFeed(long userId, long websiteId, string tagId, string emoId, long pageNumber,
            long rowsPerPage)
        {
            var lstnewsfeed = new List<DtoNewsFeed>();
            try
            {
                sqlparameter = new SqlParameter[6];
                sqlparameter[0] = new SqlParameter("@WebsiteID", websiteId);
                sqlparameter[1] = new SqlParameter("@TagId", tagId);
                sqlparameter[2] = new SqlParameter("@EmoId", emoId);
                sqlparameter[3] = new SqlParameter("@PageNumber", pageNumber);
                sqlparameter[4] = new SqlParameter("@RowsPerPage", rowsPerPage);
                sqlparameter[5] = new SqlParameter("@UserID", userId);

                _dtonewsfeed = new DtoNewsFeed();

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetWebsiteFeed.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtonewsfeed = new DtoNewsFeed
                    {
                        EmotionString = datareader["EmoString"].ToString(),
                        Tagstring = datareader["TagString"].ToString(),
                        PremalinkId = Convert.ToInt64(datareader["PremalinkId"].ToString()),
                        Link = datareader["Link"].ToString(),
                        Title = datareader["Title"].ToString(),
                        Description = datareader["Description"].ToString(),
                        Image = datareader["Image"].ToString(),
                        CreatedOn = Convert.ToDateTime(datareader["CreatedOn"].ToString()),
                        WebsiteName = datareader["WebsiteName"].ToString(),
                        WebSiteURL = datareader["WebsiteUrl"].ToString(),
                        WebsiteImage = datareader["WebsiteImage"].ToString(),
                        WebsiteId = websiteId
                    };

                    lstnewsfeed.Add(_dtonewsfeed);
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return lstnewsfeed;
        }

        public long RegisterWebsite(DtoWebsite dtowebsite)
        {
            long userid = 0;

            try
            {
                sqlparameter = new SqlParameter[10];
                sqlparameter[0] = new SqlParameter("@WebSiteName", dtowebsite.WebSiteName);
                sqlparameter[1] = new SqlParameter("@WebsiteURL", dtowebsite.WebsiteUrl);
                sqlparameter[2] = new SqlParameter("@WebsiteType", dtowebsite.WebsiteType);
                sqlparameter[3] = new SqlParameter("@UserID", dtowebsite.UserId);
                sqlparameter[4] = new SqlParameter("@AddTag", dtowebsite.AddTag);
                sqlparameter[5] = new SqlParameter("@RateTag", dtowebsite.RateTag);
                sqlparameter[6] = new SqlParameter("@AddEmotion", dtowebsite.AddEmotion);
                sqlparameter[7] = new SqlParameter("@Emotion", dtowebsite.Emotion);
                sqlparameter[8] = new SqlParameter("@Tag", dtowebsite.Tag);
                sqlparameter[9] = new SqlParameter("@Image", dtowebsite.WebsiteLogo);

                OpenConnection();
                userid = Convert.ToInt64(ExecuteScalar(StoredProcedure.Names.spRegisterWebsite.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return userid;
        }

        public long RegisterWebsiteAndUser(DtoWebsite dtowebsite)
        {
            long userid = 0;

            try
            {
                sqlparameter = new SqlParameter[10];
                sqlparameter[0] = new SqlParameter("@WebSiteName", dtowebsite.WebSiteName);
                sqlparameter[1] = new SqlParameter("@WebsiteURL", dtowebsite.WebsiteUrl);
                sqlparameter[2] = new SqlParameter("@Email", dtowebsite.WebsiteLogo);
                sqlparameter[3] = new SqlParameter("@Password", dtowebsite.Image);
                sqlparameter[4] = new SqlParameter("@VerificationCode", dtowebsite.WebsiteType);
                sqlparameter[5] = new SqlParameter("@isUser", dtowebsite.RateTag);
                
                OpenConnection();
                userid = Convert.ToInt64(ExecuteScalar(StoredProcedure.Names.spRegisterWebsiteAndUser.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return userid;
        }
        public List<DtoWebsite> GetUserWebsite(Int64 userId)
        {
            _lstwebsite = new List<DtoWebsite>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@UserID", userId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetUserWebsite.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website = new DtoWebsite
                    {
                        WebsiteId = Convert.ToInt64(datareader["WebsiteID"].ToString()),
                        WebSiteName = datareader["WebSiteName"].ToString(),
                        WebsiteUrl = datareader["WebsiteURL"].ToString(),
                        UserId = Convert.ToInt64(datareader["UserID"].ToString()),
                        AddTag = Convert.ToBoolean(datareader["AddTag"].ToString()),
                        AddEmotion = Convert.ToBoolean(datareader["AddEmotion"].ToString()),
                        RateTag = Convert.ToBoolean(datareader["RateTag"].ToString()),
                        Tag = Convert.ToBoolean(datareader["Tag"].ToString()),
                        Emotion = Convert.ToBoolean(datareader["Emotion"].ToString()),
                        WebsiteLogo = datareader["Image"].ToString()
                    };

                    _lstwebsite.Add(_website);
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return _lstwebsite;
        }

        public DtoWebsite GetWebsiteById(Int64 websiteId)
        {
            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@WebsiteID", websiteId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetWebsiteById.ToString());

                _website = new DtoWebsite();
                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website.WebsiteId = Convert.ToInt64(datareader["WebsiteID"].ToString());
                    _website.WebSiteName = datareader["WebSiteName"].ToString();
                    _website.WebsiteUrl = datareader["WebsiteURL"].ToString();
                    _website.UserId = Convert.ToInt64(datareader["UserID"].ToString());
                    _website.AddTag = Convert.ToBoolean(datareader["AddTag"].ToString());
                    _website.AddEmotion = Convert.ToBoolean(datareader["AddEmotion"].ToString());
                    _website.RateTag = Convert.ToBoolean(datareader["RateTag"].ToString());
                    _website.Emotion = Convert.ToBoolean(datareader["Emotion"].ToString());
                    _website.Tag = Convert.ToBoolean(datareader["Tag"].ToString());
                    _website.WebsiteType = datareader["Type"].ToString();
                    _website.WebsiteLogo = datareader["Image"].ToString();
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return _website;
        }

        public DtoWebsite GetWebsiteByName(string name)
        {
            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@WebsiteName", name);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetWebsiteByName.ToString());

                _website = new DtoWebsite();
                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website.WebsiteId = Convert.ToInt64(datareader["Id"].ToString());
                    _website.AddTag = Convert.ToBoolean(datareader["AddTag"].ToString());
                    _website.AddEmotion = Convert.ToBoolean(datareader["AddEmotion"].ToString());
                    _website.RateTag = Convert.ToBoolean(datareader["RateTag"].ToString());
                    _website.Emotion = Convert.ToBoolean(datareader["Emotion"].ToString());
                    _website.Tag = Convert.ToBoolean(datareader["Tag"].ToString());
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return _website;
        }

        public Int64 UpdateWebsite(DtoWebsite dtowebsite)
        {
            Int64 userid;

            try
            {
                sqlparameter = new SqlParameter[11];
                sqlparameter[0] = new SqlParameter("@WebSiteName", dtowebsite.WebSiteName);
                sqlparameter[1] = new SqlParameter("@WebsiteURL", dtowebsite.WebsiteUrl);
                sqlparameter[2] = new SqlParameter("@WebsiteID", dtowebsite.WebsiteId);
                sqlparameter[3] = new SqlParameter("@UserID", dtowebsite.UserId);
                sqlparameter[4] = new SqlParameter("@AddTag", dtowebsite.AddTag);
                sqlparameter[5] = new SqlParameter("@RateTag", dtowebsite.RateTag);
                sqlparameter[6] = new SqlParameter("@AddEmotion", dtowebsite.AddEmotion);
                sqlparameter[7] = new SqlParameter("@Tag", dtowebsite.Tag);
                sqlparameter[8] = new SqlParameter("@Emotion", dtowebsite.Emotion);
                sqlparameter[9] = new SqlParameter("@WebsiteType", dtowebsite.WebsiteType);
                sqlparameter[10] = new SqlParameter("@Image", dtowebsite.WebsiteLogo);

                OpenConnection();
                userid = Convert.ToInt64(ExecuteScalar(StoredProcedure.Names.spUpdateWebsite.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return userid;
        }

        public List<DtoWebsite> GetAllWebsite(long pageNumber, long rowsPerPage, string searchText)
        {
            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@PageNumber", pageNumber);
                sqlparameter[1] = new SqlParameter("@RowsPerPage", rowsPerPage);
                sqlparameter[2] = new SqlParameter("@SearchText", searchText);

                _lstwebsite = new List<DtoWebsite>();
                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetAllWebSite.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website = new DtoWebsite
                    {
                        WebsiteId = Convert.ToInt64(datareader["Id"].ToString()),
                        WebSiteName = datareader["Name"].ToString(),
                        Image = datareader["Image"].ToString()
                    };
                    _lstwebsite.Add(_website);
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return _lstwebsite;
        }

        public List<DtoWebsite> GetWebsiteType()
        {
            try
            {
                _lstwebsite = new List<DtoWebsite>();
                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetWebsiteType.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _website = new DtoWebsite
                    {
                        WebsiteId = Convert.ToInt64(datareader["Id"].ToString()),
                        WebSiteName = datareader["Type"].ToString()
                    };
                    _lstwebsite.Add(_website);
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                CloseConnection();
            }
            return _lstwebsite;
        }
    }
}