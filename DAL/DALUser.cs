using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALUser
    /// </summary>
    public class DalUser
    {
        private readonly SqlConnection _connection;
        private SqlCommand _command;
        private SqlDataReader _datareader;
        private DtoNewsFeed _dtonewsfeed;
        private List<DtoUser> _lstuser;
        private DtoUser _user;

        public DalUser()
        {
            var connectionstring = ConfigurationManager.ConnectionStrings["TagConnectionString"].ConnectionString;
            _connection = new SqlConnection(connectionstring);
        }

        public long RegisterUser(DtoUser dtouser)
        {
            _command = new SqlCommand(StoredProcedure.Names.spRegisterUser.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@Email", SqlDbType.VarChar);
            _command.Parameters.Add("@Password", SqlDbType.VarChar);
            _command.Parameters.Add("@VerificationCode", SqlDbType.VarChar);
            _command.Parameters.Add("@isUser", SqlDbType.Bit);


            _command.Parameters[0].Value = dtouser.Email;
            _command.Parameters[1].Value = dtouser.Password;
            _command.Parameters[2].Value = dtouser.Guid;
            _command.Parameters[3].Value = dtouser.IsUser;

            _connection.Open();
            long id = Convert.ToInt64(_command.ExecuteScalar());
            _connection.Close();

            return id;
        }

        public Int64 AuthenticateUser(DtoUser dtouser)
        {
            _command = new SqlCommand(StoredProcedure.Names.spAuthenticateUser.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            _lstuser = new List<DtoUser>();

            _command.Parameters.Add("@Email", SqlDbType.VarChar);
            _command.Parameters.Add("@Password", SqlDbType.VarChar);
            _command.Parameters.Add("@IsUser", SqlDbType.Bit);

            _command.Parameters[0].Value = dtouser.Email;
            _command.Parameters[1].Value = dtouser.Password;
            _command.Parameters[2].Value = dtouser.IsUser;

            _connection.Open();
            var userid = Convert.ToInt64(_command.ExecuteScalar());
            _connection.Close();

            return userid;
        }

        public DtoUser GetUserGeneralInfo(Int64 userId)
        {
            _command = new SqlCommand(StoredProcedure.Names.spGetUserGeneralInfo.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@UserID", SqlDbType.BigInt);
            _command.Parameters[0].Value = userId;
            _user = new DtoUser();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _user = new DtoUser();
                _user.UserId = Convert.ToInt64(_datareader["UserID"].ToString());
                _user.Email = _datareader["Email"].ToString();
                _user.Lastname = _datareader["Lastname"].ToString();
                _user.FirstName = _datareader["FirstName"].ToString();
                _user.ImageUrl = _datareader["ProfileImage"].ToString();
                _user.CoverPhoto = _datareader["CoverPhoto"].ToString();
            }
            _connection.Close();
            return _user;
        }

        public Int64 UpdateUser(DtoUser dtouser)
        {
            long userid;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spUpdateUser.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                _lstuser = new List<DtoUser>();

                _command.Parameters.Add("@FirstName", SqlDbType.VarChar);
                _command.Parameters.Add("@LastName", SqlDbType.VarChar);
                _command.Parameters.Add("@Email", SqlDbType.VarChar);
                _command.Parameters.Add("@UserID", SqlDbType.BigInt);

                _command.Parameters[0].Value = dtouser.FirstName;
                _command.Parameters[1].Value = dtouser.Lastname;
                _command.Parameters[2].Value = dtouser.Email;
                _command.Parameters[3].Value = dtouser.UserId;

                _connection.Open();
                userid = Convert.ToInt64(_command.ExecuteNonQuery());
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return userid;
        }

        public Int64 UpdatePassword(DtoUser dtouser)
        {
            _command = new SqlCommand(StoredProcedure.Names.spUpdatePassword.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            _lstuser = new List<DtoUser>();

            _command.Parameters.Add("@OldPassword", SqlDbType.VarChar);
            _command.Parameters.Add("@NewPassword", SqlDbType.VarChar);
            _command.Parameters.Add("@UserID", SqlDbType.BigInt);

            _command.Parameters[0].Value = dtouser.Password;
            _command.Parameters[1].Value = dtouser.NewPassword;
            _command.Parameters[2].Value = dtouser.UserId;

            long userid = 0;

            _connection.Open();
            userid = Convert.ToInt64(_command.ExecuteScalar());
            _connection.Close();

            return userid;
        }

        public Int64 VerifyEmail(DtoUser dtouser)
        {
            long userid;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spVerifyEmail.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                _lstuser = new List<DtoUser>();

                _command.Parameters.Add("@VerificationCode", SqlDbType.VarChar);
                _command.Parameters.Add("@Email", SqlDbType.VarChar);

                _command.Parameters[0].Value = dtouser.Guid;
                _command.Parameters[1].Value = dtouser.Email;

                _connection.Open();
                userid = Convert.ToInt64(_command.ExecuteScalar());
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return userid;
        }

        public long FacebookAuthentication(string email, string firstname, string lastname, string Id,
            string verificationCode, string profileimage)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spFacebookAuthentication.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;
                _lstuser = new List<DtoUser>();
                var outputparameter = new SqlParameter("@return", SqlDbType.Int);
                outputparameter.Direction = ParameterDirection.Output;

                _command.Parameters.Add("@Email", SqlDbType.VarChar);
                _command.Parameters.Add("@FirstName", SqlDbType.VarChar);
                _command.Parameters.Add("@LastName", SqlDbType.VarChar);
                _command.Parameters.Add("@Id", SqlDbType.VarChar);
                _command.Parameters.Add("@VerificationCode", SqlDbType.VarChar);
                _command.Parameters.Add("@ProfileImage", SqlDbType.VarChar);

                _command.Parameters[0].Value = email;
                _command.Parameters[1].Value = firstname;
                _command.Parameters[2].Value = lastname;
                _command.Parameters[3].Value = Id;
                _command.Parameters[4].Value = verificationCode;
                _command.Parameters[5].Value = profileimage;

                _connection.Open();
                long returnvalue = Convert.ToInt64(_command.ExecuteScalar());

                return returnvalue;
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string GetUserPassword(string email)
        {
            try
            {
                string password = "";

                _command = new SqlCommand(StoredProcedure.Names.spGetUserPassword.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@Email", SqlDbType.VarChar);
                _command.Parameters[0].Value = email;

                _connection.Open();
                password = _command.ExecuteScalar().ToString();

                return password;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string AddUserImage(long userId, string imageurl)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAddUserImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@ImageUrl", SqlDbType.VarChar);

                _command.Parameters[0].Value = userId;
                _command.Parameters[1].Value = imageurl;

                string status = "";

                _connection.Open();
                status = _command.ExecuteScalar().ToString();

                return status;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string AddUserCoverImage(long userId, string imageurl)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAddUserCoverImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@ImageUrl", SqlDbType.VarChar);

                _command.Parameters[0].Value = userId;
                _command.Parameters[1].Value = imageurl;

                string status = "";

                _connection.Open();
                status = _command.ExecuteScalar().ToString();

                return status;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string UpdateUserImage(long userid, string imageurl)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spUpdateUserProfileImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@ImageUrl", SqlDbType.VarChar);

                _command.Parameters[0].Value = userid;
                _command.Parameters[1].Value = imageurl;

                var status = "";

                _connection.Open();
                status = _command.ExecuteScalar().ToString();

                return status;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string UpdateUsercoverphoto(long userid, string imageurl)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spUpdateUsercoverphoto.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@ImageUrl", SqlDbType.VarChar);

                _command.Parameters[0].Value = userid;
                _command.Parameters[1].Value = imageurl;

                var status = "";

                _connection.Open();
                status = _command.ExecuteScalar().ToString();

                return status;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string DeleteUserImage(long userId)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spDeleteUserImage.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters[0].Value = userId;

                string status = "";

                _connection.Open();
                status = _command.ExecuteScalar().ToString();

                return status;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public string GetUserImage(long userId)
        {
            string userimage = "";
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters[0].Value = userId;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    userimage = _datareader["ProfileImage"].ToString();
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return userimage;
        }

        public string GetCoverImage(long userId)
        {
            var imageurl = "";

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters[0].Value = userId;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    imageurl = _datareader["CoverPhoto"].ToString();
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return imageurl;
        }

        public Dictionary<string, string> GetUserImage(long userId, long imageid)
        {
            var lststring = new Dictionary<string, string>();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserImage.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@ImageID", SqlDbType.BigInt);

                _command.Parameters[0].Value = userId;
                _command.Parameters[1].Value = imageid;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    lststring.Add(_datareader["Id"].ToString(), _datareader["Image"].ToString());
                }
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return lststring;
        }

        public List<DtoNewsFeed> GetUserNewsFeed(long userId, long pageNumber, long rowsPerPage)
        {
            // System.Diagnostics.Debugger.Launch();
            var lstnewsfeed = new List<DtoNewsFeed>();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserNewsFeed.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = userId;
                _command.Parameters[1].Value = pageNumber;
                _command.Parameters[2].Value = rowsPerPage;

                _dtonewsfeed = new DtoNewsFeed();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _dtonewsfeed = new DtoNewsFeed();
                    _dtonewsfeed.TagId = Convert.ToInt64(_datareader["Tag_Id"]);
                    _dtonewsfeed.WebsiteId = Convert.ToInt64(_datareader["Website_Id"].ToString());
                    _dtonewsfeed.PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString());
                    _dtonewsfeed.TagName = _datareader["TagName"].ToString();
                    _dtonewsfeed.UpVote = Convert.ToInt32(_datareader["UpVote"].ToString());
                    _dtonewsfeed.DownVote = Convert.ToInt32(_datareader["DownVote"].ToString());
                    if (_datareader["TaggedByUser"] != null)
                        _dtonewsfeed.TaggedByUser = Convert.ToBoolean(_datareader["TaggedByUser"].ToString());
                    _dtonewsfeed.Link = _datareader["Link"].ToString();
                    _dtonewsfeed.Title = _datareader["Title"].ToString();
                    _dtonewsfeed.Description = _datareader["Description"].ToString();
                    _dtonewsfeed.Image = _datareader["Image"].ToString();
                    _dtonewsfeed.TotalVote = Convert.ToInt64(_datareader["TotalVote"].ToString());
                    _dtonewsfeed.CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString());
                    _dtonewsfeed.WebsiteId = Convert.ToInt64(_datareader["WebsiteId"]);
                    _dtonewsfeed.WebsiteName = _datareader["WebsiteName"].ToString();
                    _dtonewsfeed.WebSiteURL = _datareader["WebsiteUrl"].ToString();
                    _dtonewsfeed.WebsiteImage = _datareader["WebsiteImage"].ToString();
                    lstnewsfeed.Add(_dtonewsfeed);
                }
                return lstnewsfeed;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public List<DtoNewsFeed> GetUserTagFeed(long userId, string tagId, string emoId, long pageNumber, long rowsPerPage)
        {
            List<DtoNewsFeed> lstnewsfeed;
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserTagFeed.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@TagId", SqlDbType.VarChar);
                _command.Parameters.Add("@EmoId", SqlDbType.VarChar);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = userId;
                _command.Parameters[1].Value = tagId;
                _command.Parameters[2].Value = emoId;
                _command.Parameters[3].Value = pageNumber;
                _command.Parameters[4].Value = rowsPerPage;

                lstnewsfeed = new List<DtoNewsFeed>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _dtonewsfeed = new DtoNewsFeed
                    {
                        EmotionString = _datareader["EmoString"].ToString(),
                        Tagstring = _datareader["TagString"].ToString(),
                        PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString()),
                        Link = _datareader["Link"].ToString(),
                        Title = _datareader["Title"].ToString(),
                        Description = _datareader["Description"].ToString(),
                        Image = _datareader["Image"].ToString(),
                        CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString()),
                        WebsiteId = Convert.ToInt64(_datareader["WebsiteId"]),
                        WebsiteName = _datareader["WebsiteName"].ToString(),
                        WebSiteURL = _datareader["WebsiteUrl"].ToString(),
                        WebsiteImage = _datareader["WebsiteImage"].ToString()
                    };
                    lstnewsfeed.Add(_dtonewsfeed);
                }
                return lstnewsfeed;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }

        public List<DtoNewsFeed> GetExploreNewsFeed(long userId, long tagid, long pageNumber, long rowsPerPage)
        {
            var lstnewsfeed = new List<DtoNewsFeed>();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetExploreNewsFeed.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = tagid;
                _command.Parameters[1].Value = userId;
                _command.Parameters[2].Value = pageNumber;
                _command.Parameters[3].Value = rowsPerPage;

                _dtonewsfeed = new DtoNewsFeed();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _dtonewsfeed = new DtoNewsFeed
                    {
                        TagId = Convert.ToInt64(_datareader["Tag_Id"]),
                        WebsiteId = Convert.ToInt64(_datareader["Website_Id"].ToString()),
                        PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString()),
                        TagName = _datareader["TagName"].ToString(),
                        UpVote = Convert.ToInt32(_datareader["UpVote"].ToString()),
                        DownVote = Convert.ToInt32(_datareader["DownVote"].ToString()),
                        TaggedByUser = Convert.ToBoolean(_datareader["TaggedByUser"].ToString()),
                        Link = _datareader["Link"].ToString(),
                        Title = _datareader["Title"].ToString(),
                        Description = _datareader["Description"].ToString(),
                        Image = _datareader["Image"].ToString(),
                        TotalVote = Convert.ToInt64(_datareader["TotalVote"].ToString()),
                        CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString())
                    };
                    lstnewsfeed.Add(_dtonewsfeed);
                }
                return lstnewsfeed;
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
        }
    }
}