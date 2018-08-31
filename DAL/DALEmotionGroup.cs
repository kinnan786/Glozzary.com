using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    public class DALEmotionGroup : ConnectionClass
    {
        private DTOEmotionGroup _dtoemotions;
        private List<DTOEmotionGroup> _lstEmotions;

        public List<DTOEmotionGroup> GetRateableEmotion(long websiteId)
        {
            _lstEmotions = new List<DTOEmotionGroup>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@WebsiteId", websiteId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetRateableEmotion.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DTOEmotionGroup
                    {
                        Id = Convert.ToInt64(datareader["Id"]),
                        GroupName = datareader["GroupName"].ToString(),
                        WebsiteId = Convert.ToInt32(datareader["WebsiteId"])
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

        public List<DTOEmotionGroup> GetRateableemotionPlugin(string rateabletagId, string websiteName, string premalink, long currentUserId)
        {
            _lstEmotions = new List<DTOEmotionGroup>();

            try
            {
                sqlparameter = new SqlParameter[4];
                sqlparameter[0] = new SqlParameter("@RateabletagId", rateabletagId);
                sqlparameter[1] = new SqlParameter("@websiteName", websiteName);
                sqlparameter[2] = new SqlParameter("@Premalink", premalink);
                sqlparameter[3] = new SqlParameter("@CurrentUserId", currentUserId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.GetRateableemotionPlugin.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DTOEmotionGroup
                    {
                        Id = Convert.ToInt64(datareader["Id"]),
                        EmotionName = datareader["Name"].ToString(),
                        WebsiteId = Convert.ToInt32(datareader["Counts"]),
                        EmotionGroupId = Convert.ToInt32(datareader["flag"])
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

        public DTOEmotionGroup GetGenerateScript(long groupId,long userid)
        {
            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@GroupId ", groupId);
                sqlparameter[1] = new SqlParameter("@userId ", userid);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.GetGenerateScript.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DTOEmotionGroup
                    {
                        UniqueId = Guid.Parse(datareader["UniqueID"].ToString()),
                        EmotionName = datareader["Name"].ToString()
                    };

                    return _dtoemotions;
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
            return null;
        }


        public int AddRateableEmotion(string groupName, long userId, long emotiongroupid, string emotion)
        {
            _lstEmotions = new List<DTOEmotionGroup>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[4];
                sqlparameter[0] = new SqlParameter("@GroupName", groupName);
                sqlparameter[1] = new SqlParameter("@UserId", userId);
                sqlparameter[2] = new SqlParameter("@EmotionGroupId", emotiongroupid);
                sqlparameter[3] = new SqlParameter("@Emotion", emotion);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddRateableEmotion.ToString()));
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

        public int UpdateRateableEmotion(long emotionGroupId, string groupName)
        {
            _lstEmotions = new List<DTOEmotionGroup>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@EmotionGroupId", emotionGroupId);
                sqlparameter[1] = new SqlParameter("@GroupName", groupName);

                OpenConnection();
                returnvalue = Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spUpdateRateableEmotion.ToString()));
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                CloseConnection();
            }
            return returnvalue;
        }

        public List<DTOEmotionGroup> GetRateableEmotionByEmotionGroupId(long emotionGroupId)
        {
            _lstEmotions = new List<DTOEmotionGroup>();

            try
            {
                sqlparameter = new SqlParameter[1];
                sqlparameter[0] = new SqlParameter("@EmotionGroupId ", emotionGroupId);

                OpenConnection();
                datareader = ExecuteReader(StoredProcedure.Names.spGetRateableEmotionByEmotionGroupId.ToString());

                if (!datareader.HasRows)
                    return null;
                while (datareader.Read())
                {
                    _dtoemotions = new DTOEmotionGroup
                    {
                        Id = Convert.ToInt64(datareader["Id"]),
                        EmotionName = datareader["Name"].ToString(),
                        EmotionGroupId = Convert.ToInt64(datareader["EmotionGroupId"].ToString()),
                        GroupName = datareader["GroupName"].ToString()
                    };

                    _lstEmotions.Add(_dtoemotions);
                }
                return _lstEmotions;
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                CloseConnection();
            }
        }


        public int AddRateableEmotion_Emotion(long EmotionId, long EmotionGroupId)
        {
            _lstEmotions = new List<DTOEmotionGroup>();
            int returnvalue;

            try
            {
                sqlparameter = new SqlParameter[2];
                sqlparameter[0] = new SqlParameter("@EmotionGroupId", EmotionGroupId);
                sqlparameter[1] = new SqlParameter("@EmotionId", EmotionId);

                OpenConnection();
                returnvalue =
                    Convert.ToInt32(ExecuteScalar(StoredProcedure.Names.spAddRateableEmotion_Emotion.ToString()));
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
    }
}