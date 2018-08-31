using System;
using System.Collections.Generic;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    /// <summary>
    ///     Summary description for BLLSubscription
    /// </summary>
    public class BllUserTagSubscription
    {
        private DALUserTagSubscription _dalUserTagSubscription;

        public List<DtoUserTagSubscription> GetUserTagSubscription(Int64 UserID, string TagName)
        {
            try
            {
                _dalUserTagSubscription = new DALUserTagSubscription();
                return _dalUserTagSubscription.GetUserTagSubscription(UserID, TagName);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public Int64 AddUserTagSubscription(Int64 UserID, Int64 TagID)
        {
            try
            {
                _dalUserTagSubscription = new DALUserTagSubscription();
                return _dalUserTagSubscription.AddUserTagSubscription(UserID, TagID);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public Int64 DeleteUserTagSubscription(Int64 UserID, Int64 TagID)
        {
            try
            {
                _dalUserTagSubscription = new DALUserTagSubscription();
                return _dalUserTagSubscription.DeleteUserTagSubscription(UserID, TagID);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }
    }
}