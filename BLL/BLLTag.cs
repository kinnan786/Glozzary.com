using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using DAL;
using DTO;
using Exceptionless;

namespace BLL
{
    public class BllTag
    {
        private DalTag _daltag;
        private List<DtoTag> _lsttag = new List<DtoTag>();


        public void DeleteTag(long premalinkid, long tagid)
        {
            try
            {
                _daltag = new DalTag();
                _daltag.DeleteTag(premalinkid, tagid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        public long AddUserTags(string Tagname, long CurrentUserID, long LoggedInUser)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.AddUserTags(Tagname, CurrentUserID, LoggedInUser);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long AssociateTag(DtoTag tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.AssociateTag(tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public List<DtoTag> GetTagsbyPremalink(string Premalink)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTagsbyPremalink(Premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoTag> GetTag(string WebSiteName, string premalink, string WebsiteURL, string tagtype)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTag(WebSiteName, premalink, WebsiteURL, tagtype);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoTag> GetWebsiteTags(long Id)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetWebsiteTags(Id);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoTag> GetAllTag(string WebSiteName, string premalink, long userid)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetAllTag(WebSiteName, premalink, userid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public long AddTag(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.AddTag(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long AddTagged(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.AddTagged(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public Int64 IncrementTag(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.IncrementTag(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public IEnumerable ExploreTag(string prefixText)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.SearchTag(prefixText);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        //public IEnumerable SearchTagIntellisense(string TagName, string premalink, string websitename)
        //{
        //    lsttag = new List<DTOTag>();
        //    daltag = new DALTag();
        //    IEnumerable query = "" ;
        //    lsttag = daltag.SearchTagIntellisense(TagName, premalink, websitename);

        //    if (lsttag != null)
        //    {
        //        query = from c in lsttag
        //                    select new
        //                    {
        //                        Value = c.TagId.ToString(),
        //                        Name = c.TagName
        //                    };
        //    }
        //    return query;
        //}

        public IEnumerable WhatTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.WhatTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable TagIntellisense(string prefixText, string premalink)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.TagIntellisense(prefixText, premalink);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable SearchTag(string prefixText)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.SearchTag(prefixText);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable HowTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.HowTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable WhenTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.WhenTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable WhereTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.WhereTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable WhoTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.WhoTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public IEnumerable WhyTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                IEnumerable query = "";
                _lsttag = _daltag.WhyTagIntellisense(TagName, premalink, websitename);

                if (_lsttag != null)
                {
                    query = from c in _lsttag
                        select new
                        {
                            Value = c.TagId.ToString(),
                            Name = c.TagName
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

        public List<DtoTag> GetAllTags(long UserID, string Tagname, int CurrentPage, int TotalRecord, string flow)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetAllTags(UserID, Tagname, CurrentPage, TotalRecord, flow);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public long VoteTag(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.VoteTag(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long VoteUserTag(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.VoteUserTag(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long VoteTagged(DtoTag Tag)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.VoteTagged(Tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public long VoteContent(DtoNewsFeed news)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.VoteContent(news);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        public DtoTag GetTag(int tagid, int userid)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTag(tagid, userid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoTag> GetTagByUser(long UserID)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTagByUser(UserID);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoTag> GetTagByWebsite(long Websiteid)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTagByWebsite(Websiteid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        public List<DtoTag> GetUserTagForProfile(long CurrentUserID, long LoggedInUser)
        {
            try
            {
                var lsttag = new List<DtoTag>();
                _daltag = new DalTag();
                lsttag = _daltag.GetUserTags(CurrentUserID, LoggedInUser);
                return lsttag;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetUserTags(long CurrentUserID, long LoggedInUser)
        {
            try
            {
                var lsttag = new List<DtoTag>();
                _daltag = new DalTag();

                lsttag = _daltag.GetUserTags(CurrentUserID, LoggedInUser);

                string tags = "";

                tags = "";
                if (lsttag != null)
                {
                    foreach (DtoTag tag in lsttag)
                        tags += "|" + tag.TagName + "," + tag.TagId + "," + tag.TagCount + ",0";
                }

                return tags;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetTagged(long tagId)
        {
            try
            {
                var lsttag = new List<DtoTag>();
                _daltag = new DalTag();

                lsttag = _daltag.GetTagged(tagId);

                string tags = "";

                tags = "";
                if (lsttag != null)
                {
                    foreach (DtoTag tag in lsttag)
                        tags += "|" + tag.TagName + "," + tag.TagId + "," +
                                (tag.TagCount == 0 ? "1" : tag.TagCount.ToString()) +
                                ",0";
                }
                return tags;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public DtoTag GetTagById(long tagId)
        {
            try
            {
                _daltag = new DalTag();
                return _daltag.GetTagById(tagId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public List<DtoNewsFeed> GetEmoNewsFeed(long UserId, int emoId, long PageNumber, long RowsPerPage)
        {
            try
            {
                var dalemotion = new DalEmotions();

                var lstdtonewsfeed = new List<DtoNewsFeed>();
                var newlstdtonewsfeed = new List<DtoNewsFeed>();
                var lstemotion = new List<DtoEmotions>();

                _daltag = new DalTag();

                lstdtonewsfeed = _daltag.GetEmoNewsFeed(UserId, emoId, PageNumber, RowsPerPage);

                if (lstdtonewsfeed != null)
                {
                    IEnumerable<long> query = (from ca in lstdtonewsfeed
                        select ca.PremalinkId).Distinct();

                    if (query != null)
                    {
                        foreach (long item in query)
                        {
                            IEnumerable<long> uniquetagid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item
                                select ca.TagId).Distinct();

                            IEnumerable<long> uniqueemoid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item
                                select ca.EmotionId).Distinct();
                            string tagstr = "";
                            int index = 0;
                            foreach (int str in uniquetagid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.TagId == str
                                    select ca).FirstOrDefault();

                                tagstr += "|" + dto.TagId + "," + dto.TagName + "," + dto.TotalVote + "," + dto.UpVote +
                                          "," +
                                          dto.DownVote + "," + dto.TaggedByUser + ",";
                                index += 1;

                                if (index == uniquetagid.Count())
                                    newlstdtonewsfeed.Add(new DtoNewsFeed
                                    {
                                        PremalinkId = dto.PremalinkId,
                                        Title = dto.Title,
                                        Description = dto.Description,
                                        Image = dto.Image,
                                        CreatedOn = dto.CreatedOn,
                                        Tagstring = tagstr,
                                        Link = dto.Link,
                                        WebsiteName = dto.WebsiteName,
                                        WebsiteImage = dto.WebsiteImage
                                    });
                            }

                            string emostr = "";
                            index = 0;
                            foreach (int str in uniqueemoid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.EmotionId == str
                                    select ca).FirstOrDefault();
                                index += 1;
                                emostr += "|" + dto.EmotionId + "," + dto.EmotionName + "," + dto.TotalCount + "," +
                                          dto.IsActive;

                                if (index == uniqueemoid.Count())
                                {
                                    DtoNewsFeed q = (from c in newlstdtonewsfeed
                                        where c.PremalinkId == dto.PremalinkId
                                        select c).FirstOrDefault();
                                    q.EmotionString = emostr;
                                }
                            }
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

        public List<DtoNewsFeed> ExplorehNewsFeed(long UserID, string search, long PageNumber, long RowsPerPage)
        {
            try
            {
                var dalemotion = new DalEmotions();

                var lstdtonewsfeed = new List<DtoNewsFeed>();
                var newlstdtonewsfeed = new List<DtoNewsFeed>();
                var lstemotion = new List<DtoEmotions>();

                _daltag = new DalTag();

                lstdtonewsfeed = _daltag.ExplorehNewsFeed(UserID, search, PageNumber, RowsPerPage);

                if (lstdtonewsfeed != null)
                {
                    IEnumerable<long> query = (from ca in lstdtonewsfeed
                        select ca.PremalinkId).Distinct();

                    if (query != null)
                    {
                        foreach (long item in query)
                        {
                            IEnumerable<long> uniquetagid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item && ca.TagId != 0
                                select ca.TagId).Distinct();

                            IEnumerable<long> uniqueemoid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item && ca.EmotionId != 0
                                select ca.EmotionId).Distinct();
                            string tagstr = "";
                            int index = 0;
                            foreach (int str in uniquetagid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.TagId == str
                                    select ca).FirstOrDefault();

                                tagstr += "|" + dto.TagId + "," + dto.TagName + "," + dto.TotalVote + "," + dto.UpVote +
                                          "," +
                                          dto.DownVote + "," + dto.TaggedByUser + ",";
                                index += 1;

                                if (index == uniquetagid.Count())
                                    newlstdtonewsfeed.Add(new DtoNewsFeed
                                    {
                                        PremalinkId = dto.PremalinkId,
                                        Title = dto.Title,
                                        Description = dto.Description,
                                        Image = dto.Image,
                                        CreatedOn = dto.CreatedOn,
                                        Tagstring = tagstr,
                                        Link = dto.Link,
                                        WebsiteName = dto.WebsiteName
                                    });
                            }

                            string emostr = "";
                            index = 0;

                            foreach (int str in uniqueemoid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.EmotionId == str
                                    select ca).FirstOrDefault();
                                index += 1;
                                emostr += "|" + dto.EmotionId + "," + dto.EmotionName + "," + dto.TotalCount + "," +
                                          dto.IsActive;

                                if (index == uniqueemoid.Count())
                                {
                                    DtoNewsFeed q = (from c in newlstdtonewsfeed
                                        where c.PremalinkId == dto.PremalinkId
                                        select c).FirstOrDefault();
                                    q.EmotionString = emostr;
                                    emostr = "";
                                }
                            }
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

        public List<DtoNewsFeed> GetTagNewsFeed(long UserId, long tagId, long PageNumber, long RowsPerPage)
        {
            try
            {
                var dalemotion = new DalEmotions();

                var newlstdtonewsfeed = new List<DtoNewsFeed>();
                var lstemotion = new List<DtoEmotions>();

                _daltag = new DalTag();

                List<DtoNewsFeed> lstdtonewsfeed = _daltag.GetTagNewsFeed(UserId, tagId, PageNumber, RowsPerPage);

                if (lstdtonewsfeed != null)
                {
                    IEnumerable<long> query = (from ca in lstdtonewsfeed
                        select ca.PremalinkId).Distinct();

                    if (query != null)
                    {
                        foreach (long item in query)
                        {
                            IEnumerable<long> uniquetagid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item && ca.TagId != 0
                                select ca.TagId).Distinct();

                            IEnumerable<long> uniqueemoid = (from ca in lstdtonewsfeed
                                where ca.PremalinkId == item && ca.EmotionId != 0
                                select ca.EmotionId).Distinct();
                            string tagstr = "";
                            int index = 0;
                            foreach (int str in uniquetagid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.TagId == str
                                    select ca).FirstOrDefault();

                                tagstr += "|" + dto.TagId + "," + dto.TagName + "," + dto.TotalVote + "," + dto.UpVote +
                                          "," +
                                          dto.DownVote + "," + dto.TaggedByUser + ",";
                                index += 1;

                                if (index == uniquetagid.Count())
                                    newlstdtonewsfeed.Add(new DtoNewsFeed
                                    {
                                        PremalinkId = dto.PremalinkId,
                                        Title = dto.Title,
                                        Description = dto.Description,
                                        Image = dto.Image,
                                        CreatedOn = dto.CreatedOn,
                                        Tagstring = tagstr,
                                        Link = dto.Link,
                                        WebsiteName = dto.WebsiteName,
                                        WebsiteId = dto.WebsiteId,
                                        WebsiteImage = dto.WebsiteImage
                                    });
                            }

                            string emostr = "";
                            index = 0;

                            foreach (long str in uniqueemoid)
                            {
                                DtoNewsFeed dto = (from ca in lstdtonewsfeed
                                    where ca.PremalinkId == item
                                          && ca.EmotionId == str
                                    select ca).FirstOrDefault();
                                index += 1;
                                emostr += "|" + dto.EmotionId + "," + dto.EmotionName + "," + dto.TotalCount + "," +
                                          dto.IsActive;

                                if (index == uniqueemoid.Count())
                                {
                                    DtoNewsFeed q = (from c in newlstdtonewsfeed
                                        where c.PremalinkId == dto.PremalinkId
                                        select c).FirstOrDefault();
                                    q.EmotionString = emostr;
                                    emostr = "";
                                }
                            }
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
    }
}