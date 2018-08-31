using System;
using System.Collections.Generic;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    public class BLLEmotionGroup
    {
        private DALEmotionGroup _dalemotions;
        private List<DTOEmotionGroup> _lstemotion;


        public int UpdateRateableEmotion(long emotionGroupId, string groupName)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.UpdateRateableEmotion(emotionGroupId, groupName);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DTOEmotionGroup> GetRateableemotionPlugin(string rateabletagId, string websiteName, string premalink,
            long currentUserId)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.GetRateableemotionPlugin(rateabletagId, websiteName, premalink, currentUserId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
                return null;
            }
        }


        public List<DTOEmotionGroup> GetRateableEmotion(long websiteId)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.GetRateableEmotion(websiteId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public DTOEmotionGroup GetGenerateScript(long groupId, long userid)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.GetGenerateScript(groupId, userid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        public List<DTOEmotionGroup> GetRateableEmotionByEmotionGroupId(long emotionGroupId)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.GetRateableEmotionByEmotionGroupId(emotionGroupId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public int AddRateableEmotion(string groupName, long userId, long emotiongroupid, string emotion)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.AddRateableEmotion(groupName, userId, emotiongroupid, emotion);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }


        public int AddRateableEmotion_Emotion(long emotionId, long emotionGroupId)
        {
            try
            {
                _dalemotions = new DALEmotionGroup();
                return _dalemotions.AddRateableEmotion_Emotion(emotionId, emotionGroupId);
            }
            catch (Exception error)
            {
                throw;
            }
        }
    }
}