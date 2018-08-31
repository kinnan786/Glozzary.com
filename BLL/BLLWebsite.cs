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
    ///     Summary description for BLLWebsite
    /// </summary>
    public class BllWebsite
    {
        private DalWebsite _dalwebsite;
        private List<DtoWebsite> _lstdtowebsite;

        public IEnumerable SearchWebsite(string prefixText)
        {
            try
            {
                _lstdtowebsite = new List<DtoWebsite>();
                _dalwebsite = new DalWebsite();
                IEnumerable query = "";
                _lstdtowebsite = _dalwebsite.SearchWebsite(prefixText);

                if (_lstdtowebsite != null)
                {
                    query = from c in _lstdtowebsite
                        select new
                        {
                            Value = c.WebsiteId.ToString(),
                            Name = c.WebSiteName
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

        public List<DtoNewsFeed> GetWebsiteFeed(long userId, long websiteId, string tagid, string emoId, long pageNumber,
            long rowsPerPage)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetWebsiteFeed(userId, websiteId, tagid, emoId, pageNumber, rowsPerPage);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoWebsite> GetAllWebsite(long pageNumber, long rowsPerPage, string searchText)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetAllWebsite(pageNumber, rowsPerPage, searchText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public DtoWebsite GetWebsiteByName(string name)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetWebsiteByName(name);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public long RegisterWebsite(DtoWebsite dtowebsite)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.RegisterWebsite(dtowebsite);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long RegisterWebsiteAndUser(DtoWebsite dtowebsite)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.RegisterWebsiteAndUser(dtowebsite);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }



        public List<DtoWebsite> GetWebsiteType()
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetWebsiteType();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoWebsite> GetUserWebsite(Int64 userId)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetUserWebsite(userId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public DtoWebsite GetWebsiteById(Int64 websiteId)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.GetWebsiteById(websiteId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public Int64 UpdateWebsite(DtoWebsite dtowebsite)
        {
            try
            {
                _dalwebsite = new DalWebsite();
                return _dalwebsite.UpdateWebsite(dtowebsite);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }
    }
}