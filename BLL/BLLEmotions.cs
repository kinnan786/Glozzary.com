using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    /// <summary>
    ///     Summary description for BLLEmotions
    /// </summary>
    public class BllEmotions
    {
        private DalEmotions _dalemotions;
        private List<DtoEmotions> _lstemotion;

        public List<DtoEmotions> GetAllEmotion(string websitename, string premalink, long userid)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.GetAllEmotion(websitename, premalink, userid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoEmotions> RateableEmotionIntellisense(string prefixText)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.RateableEmotionIntellisense(prefixText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoEmotions> GetUserEmotionForProfile(long currentUserId, long loggedInUser)
        {
            try
            {
                _lstemotion = new List<DtoEmotions>();
                _dalemotions = new DalEmotions();

                _lstemotion = _dalemotions.GetUserEmotionForProfile(currentUserId, loggedInUser);
                return _lstemotion;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoEmotions> GetPremalinkEmotions(string premalink, long? userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.GetPremalinkEmotions(premalink, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        public List<DtoEmotions> GetPremalinkEmotionsById(long id)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.GetPremalinkEmotionsById(id);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        public IEnumerable EmotionIntellisense(string premalink, string emotion)
        {
            try
            {
                _dalemotions = new DalEmotions();
                _lstemotion = new List<DtoEmotions>();
                IEnumerable query = "";
                _lstemotion = _dalemotions.EmotionIntellisense(premalink, emotion);

                if (_lstemotion != null)
                {
                    query = from c in _lstemotion
                        select new
                        {
                            Value = c.Emotionid.ToString(),
                            Name = c.EmotionName
                        };
                }
                return query;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public int IncrementEmotion(string premalink, int emotionId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.IncrementEmotion(premalink, emotionId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int IncrementTaggedEmotion(long tagId, int emotionId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.IncrementTaggedEmotion(tagId, emotionId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int IncrementUserEmotion(int emotionId, long currentUserProfileId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.IncrementUserEmotion(emotionId, currentUserProfileId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int DecrementUserEmotion(int emotionId, long currentUserProfileId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.DecrementUserEmotion(emotionId, currentUserProfileId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int DecrementEmotion(string premalink, int emotionId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.DecrementEmotion(premalink, emotionId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int DecrementTaggedEmotion(long tagId, int emotionId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.DecrementTaggedEmotion(tagId, emotionId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int AddEmotion(string emotionName, string premalink, int emotionId, long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.AddEmotion(emotionName, premalink, emotionId, userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int AddUserEmotion(string emotionName, long userId, long profileuserId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.AddUserEmotion(emotionName, userId, profileuserId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public int AddTaggedEmotion(string emotionName, long userId, long tagId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.AddTaggedEmotion(emotionName, userId, tagId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DtoEmotions> spGetEmotionByUser(long userId)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.GetEmotionByUser(userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoEmotions> GetEmotionByWebsite(long websiteid)
        {
            try
            {
                _dalemotions = new DalEmotions();
                return _dalemotions.GetEmotionByWebsite(websiteid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetUserEmotion(long currentUserId, long loggedInUser)
        {
            try
            {
                _dalemotions = new DalEmotions();

                IEnumerable<DtoEmotions> lstemo = _dalemotions.GetUserEmotion(currentUserId, loggedInUser);

                string emos = "";

                emos = "";
                if (lstemo == null) return emos;
                foreach (DtoEmotions emotions in lstemo)
                    emos += "|" + emotions.EmotionName + "," + emotions.Emotionid + "," + emotions.TotalCount + "," +
                            (emotions.EmotionUser == 1 ? "true" : "false");

                return emos;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetTaggedEmotion(long tagId, long loggedInUser)
        {
            try
            {
                _dalemotions = new DalEmotions();

                IEnumerable<DtoEmotions> lstemo = _dalemotions.GetTaggedEmotion(tagId, loggedInUser);

                string emos = "";

                emos = "";
                if (lstemo == null) return emos;
                foreach (DtoEmotions emotions in lstemo)
                    emos += "|" + emotions.EmotionName + "," + emotions.Emotionid + "," + emotions.TotalCount + "," +
                            (emotions.EmotionUser == 1 ? "true" : "false");

                return emos;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}