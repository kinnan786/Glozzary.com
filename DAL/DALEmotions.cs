using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALEmotions
    /// </summary>
    public class DalEmotions : ConnectionClass
    {
        private DtoEmotions _dtoemotions;
        private List<DtoEmotions> _lstEmotions;


        public List<DtoEmotions> GetUserEmotionForProfile(long currentUserId, long loggedInUser)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@CurrentUserID", currentUserId);
                sqlparameter[1] = new SqlParameter("@LoggedInUser", loggedInUser);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetUserEmotion.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"])
                    };

                    if (Convert.ToInt32(datareader["LoggedUserEmotion"]) > 0)
                        _dtoemotions.IsActive = true;
                    else
                        _dtoemotions.IsActive = false;

                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public int AddEmotion(string emotionName, string premalink, int emotionId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[4];
                sqlparameter[0] = new SqlParameter("@EmotionName", emotionName);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@UserId", userId);
                sqlparameter[3] = new SqlParameter("@Link", premalink);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public List<DtoEmotions> RateableEmotionIntellisense(string prefixText)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@PrefixText", prefixText);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spRateableEmotionIntellisense.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["Id"]),
                        EmotionName = datareader["Name"].ToString(),
                    };

                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public List<DtoEmotions> GetPremalinkEmotions(string premalink, long? userId)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@Premalink", premalink);
                sqlparameter[1] = new SqlParameter("@UserId", userId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetPremalinkEmotions.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"])
                    };

                    if (Convert.ToInt32(datareader["UserEmotion"]) > 0)
                        _dtoemotions.IsActive = true;
                    else
                        _dtoemotions.IsActive = false;

                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public int IncrementEmotion(string premalink, int emotionId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@Premalink", premalink);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@UserId", userId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spIncrementEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int DecrementEmotion(string premalink, int emotionId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@Premalink", premalink);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@UserId", userId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spDecrementEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }


        public List<DtoEmotions> EmotionIntellisense(string premalink, string emotion)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@Premalink", premalink);
                sqlparameter[1] = new SqlParameter("@Emotion", emotion);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spEmotionIntellisense.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["Id"]),
                        EmotionName = datareader["Name"].ToString()
                    };

                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public List<DtoEmotions> GetEmotionByUser(long userId)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@UserID", userId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetEmotionByUser.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"])
                    };
                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public List<DtoEmotions> GetPremalinkEmotionsById(long id)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@PremaLinkID", id);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetPremalinkEmotionsById.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                    };
                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }


        public List<DtoEmotions> GetEmotionByWebsite(long websiteId)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@WebsiteId", websiteId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetEmotionByWebsite.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"])
                    };
                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public IEnumerable<DtoEmotions> GetUserEmotion(long currentUserId, long loggedInUser)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@CurrentUserID", currentUserId);
                sqlparameter[1] = new SqlParameter("@LoggedInUser", loggedInUser);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetUserEmotion.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"]),
                        EmotionUserId = Convert.ToInt64(datareader["EmotionUserId"]),
                        EmotionUser = Convert.ToInt64(datareader["LoggedUserEmotion"])
                    };
                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public IEnumerable<DtoEmotions> GetTaggedEmotion(long tagId, long loggedInUser)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@TagId", tagId);
                sqlparameter[1] = new SqlParameter("@LoggedInUser", loggedInUser);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetTaggedEmotion.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions();
                    _dtoemotions.Emotionid = Convert.ToInt64(datareader["EmotionId"]);
                    _dtoemotions.EmotionName = datareader["EmotionName"].ToString();
                    _dtoemotions.TotalCount = Convert.ToInt32(datareader["TotalCount"]);
                    _dtoemotions.EmotionUser = Convert.ToInt64(datareader["LoggedUserEmotion"]);
                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }

        public int IncrementUserEmotion(int emotionId, long currentUserProfileId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@CurrentUserID", currentUserProfileId);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@LoggedInUser", userId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spIncrementUserEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int IncrementTaggedEmotion(long tagId, int emotionId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[1] = new SqlParameter("@UserId", userId);
                sqlparameter[2] = new SqlParameter("@TagId", tagId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spIncrementTaggedEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int DecrementUserEmotion(int emotionId, long currentUserProfileId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue = 0;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@CurrentUserID", currentUserProfileId);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@LoggedInUser", userId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spDecrementUserEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int DecrementTaggedEmotion(long tagId, int emotionId, long userId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@TagId", tagId);
                sqlparameter[1] = new SqlParameter("@EmotionId", emotionId);
                sqlparameter[2] = new SqlParameter("@UserId", userId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteNonQuery(StoredProcedure.Names.spDecrementTaggedEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int AddUserEmotion(string emotionName, long userId, long profileuserId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@EmotionName", emotionName);
                sqlparameter[1] = new SqlParameter("@UserId", userId);
                sqlparameter[2] = new SqlParameter("@ProfileuserId", profileuserId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddUserEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public int AddTaggedEmotion(string emotionName, long userId, long tagId)
        {
            _lstEmotions = new List<DtoEmotions>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@EmotionName", emotionName);
                sqlparameter[1] = new SqlParameter("@UserId", userId);
                sqlparameter[2] = new SqlParameter("@TagId", tagId);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddTaggedEmotion.ToString()));
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public List<DtoEmotions> GetAllEmotion(string websitename, string premalink, long userid)
        {
            _lstEmotions = new List<DtoEmotions>();

            try
            {
                sqlparameter = new SqlParameter[3];
                sqlparameter[0] = new SqlParameter("@WebSiteName", websitename);
                sqlparameter[1] = new SqlParameter("@Premalink", premalink);
                sqlparameter[2] = new SqlParameter("@UserID", userid);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetAllEmotion.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DtoEmotions
                    {
                        Emotionid = Convert.ToInt64(datareader["EmotionId"]),
                        EmotionName = datareader["EmotionName"].ToString(),
                        TotalCount = Convert.ToInt32(datareader["TotalCount"])
                    };

                    if (Convert.ToInt32(datareader["LoggedUserEmotion"]) > 0)
                        _dtoemotions.IsActive = true;
                    else
                        _dtoemotions.IsActive = false;

                    _lstEmotions.Add(_dtoemotions);
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
            return _lstEmotions;
        }
    }
}