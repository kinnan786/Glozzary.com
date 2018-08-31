using System;
using System.Collections.Generic;
using System.Linq;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    /// <summary>
    ///     Summary description for BLLPremalink
    /// </summary>
    public class BllPremalink
    {
        private DalPremalink _dalpremalink;
        private List<DtoPremalink> _lstpremalink;

        public long AddPremalinkimages(DtoPremalink premalink)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.AddPremalinkimages(premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }



        public List<DtoPremalink> GetUnParsedPremalik()
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.GetUnParsedPremalik();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

       
        public DtoPremalink GetPremalinkById(long PremalinkId)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.GetPremalinkById(PremalinkId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoPremalink> GetWebsitePremalink(DtoPremalink Premalink)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.GetWebsitePremalink(Premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoPremalink> SearchPremalink(string Premalink, long id)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.SearchPremalink(Premalink,id);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        

        public long DeactivateTagToWebsite(DtoPremalink Premalink)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.DeactivateTagToWebsite(Premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DtoTag> GetPremalinkTagsById(Int64 PremalinkID)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.GetPremalinkTagsById(PremalinkID);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoPremalink> GetWebSiteTaggedpremaLink(int Tag, int PageNumber, int RowsPerPage)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                _lstpremalink = new List<DtoPremalink>();

                var templstpremalink = new List<DtoPremalink>();

                DtoPremalink tempdtopremalink;

                _lstpremalink = _dalpremalink.GetTaggedpremaLink(Tag, PageNumber, RowsPerPage);

                if (_lstpremalink != null)
                {
                    if (_lstpremalink.Count > 0)
                    {
                        IEnumerable<long> premalinkid = (from dto in _lstpremalink
                            select dto.PremalinkId).Distinct();

                        foreach (Int64 id in premalinkid)
                        {
                            tempdtopremalink = new DtoPremalink();

                            DtoPremalink lst = (from dto in _lstpremalink
                                where dto.PremalinkId == id
                                select dto).FirstOrDefault();

                            List<string> tags = (from dto in _lstpremalink
                                where dto.PremalinkId == id
                                select dto.TagName).ToList();

                            string tagnames = "";

                            foreach (string tagname in tags)
                            {
                                tagnames += tagname + ",";
                            }

                            tempdtopremalink.TagName = tagnames;
                            tempdtopremalink.Link = lst.Link;
                            tempdtopremalink.TagId = lst.TagId;
                            tempdtopremalink.PremalinkId = lst.PremalinkId;
                            tempdtopremalink.WebsiteId = lst.WebsiteId;
                            tempdtopremalink.Image = lst.Image;
                            tempdtopremalink.Description = lst.Description;
                            tempdtopremalink.Type = lst.Type;
                            tempdtopremalink.Title = lst.Title;

                            templstpremalink.Add(tempdtopremalink);
                        }
                    }
                }
                return templstpremalink;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public Int64 AddPremalink(DtoPremalink premalink)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.AddPremalink(premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public Int64 AddPremalinkMetaChar(DtoMeta dtometa)
        {
            try
            {
                _dalpremalink = new DalPremalink();
                return _dalpremalink.AddPremalinkMetaChar(dtometa);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DtoPremalink> GetUserNewsFeed(int UserID, int CurrentPage, int TotalRec)
        {
            try
            {
                var finalpremalink = new List<DtoPremalink>();
                _lstpremalink = new List<DtoPremalink>();
                _dalpremalink = new DalPremalink();
                _lstpremalink = _dalpremalink.GetUserNewsFeed(UserID, CurrentPage, TotalRec);

                return _lstpremalink;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
            //if (lstpremalink != null)
            //{
            //    var premalinkid = (from p in lstpremalink select p.PremalinkID).Distinct();

            //    foreach (Int64 id in premalinkid)
            //    {
            //        DTOPremalink premalink = new DTOPremalink();
            //        List<DTOPremalink> lstprema = new List<DTOPremalink>();
            //        List<DTOTag> lsttags = new List<DTOTag>();

            //        premalink = (DTOPremalink)(from p in lstpremalink
            //                                   where p.PremalinkID == id
            //                                   select p).FirstOrDefault();

            //        lstprema = (from premalinktags in lstpremalink
            //                    where premalinktags.PremalinkID == id
            //                    select premalinktags).ToList();

            //        foreach (DTOPremalink dtop in lstprema)
            //        {
            //            DTOTag tag = new DTOTag();
            //            tag.TagId = dtop.TagID;
            //            tag.TagName = dtop.TagName;
            //            lsttags.Add(tag);
            //        }

            //        premalink.Tag = lsttags;
            //        finalpremalink.Add(premalink);
            //    }
            //    return finalpremalink;
            //}
            //else
            //    return null;
        }

        public List<DtoPremalink> SearchTags(string SearchQuery, int CurrentPage, int TotalRec)
        {
            try
            {
                var finalpremalink = new List<DtoPremalink>();
                _lstpremalink = new List<DtoPremalink>();
                _dalpremalink = new DalPremalink();
                _lstpremalink = _dalpremalink.SearchTags(SearchQuery, CurrentPage, TotalRec);

                return _lstpremalink;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}