using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALPremalink
    /// </summary>
    public class DalPremalink
    {
        private readonly SqlConnection _connection;
        private SqlCommand _command;
        private SqlDataReader _datareader;
        private DtoTag _dtotag;
        private List<DtoPremalink> _lstpremalink;
        private List<DtoTag> _lsttag;
        private DtoPremalink _premalink;

        public DalPremalink()
        {
            string connectionstring = ConfigurationManager.ConnectionStrings["TagConnectionString"].ConnectionString;
            _connection = new SqlConnection(connectionstring);
        }

        public List<DtoPremalink> GetWebsitePremalink(DtoPremalink premalink)
        {
            _command = new SqlCommand(StoredProcedure.Names.spGetWebsitePremalink.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@WebSiteID", SqlDbType.BigInt);
            _command.Parameters.Add("@Link", SqlDbType.VarChar);

            _command.Parameters[0].Value = premalink.WebsiteId;
            _command.Parameters[1].Value = premalink.Link;

            _lstpremalink = new List<DtoPremalink>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _premalink = new DtoPremalink
                {
                    PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                    TagCount = Convert.ToInt64(_datareader["TagCount"]),
                    Link = _datareader["Link"].ToString()
                };
                _lstpremalink.Add(_premalink);
            }
            _connection.Close();
            return _lstpremalink;
        }

        public List<DtoPremalink> SearchPremalink(string premalink, long id)
        {
            _command = new SqlCommand(StoredProcedure.Names.spSearchPremalink.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@WebSiteID", SqlDbType.BigInt);
            _command.Parameters.Add("@Link", SqlDbType.VarChar);

            _command.Parameters[0].Value = id;
            _command.Parameters[1].Value = premalink;

            _lstpremalink = new List<DtoPremalink>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _premalink = new DtoPremalink
                {
                    PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                    TagCount = Convert.ToInt64(_datareader["TagCount"]),
                    Link = _datareader["Link"].ToString()
                };
                _lstpremalink.Add(_premalink);
            }
            _connection.Close();
            return _lstpremalink;
        }


        public long DeactivateTagToWebsite(DtoPremalink premalink)
        {
            _command = new SqlCommand(StoredProcedure.Names.DeactivateTagToWebsite.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@PremaLinkID", SqlDbType.BigInt);
            _command.Parameters.Add("@Link", SqlDbType.VarChar);
            _command.Parameters.Add("@TagID", SqlDbType.BigInt);

            _command.Parameters[0].Value = premalink.PremalinkId;
            _command.Parameters[1].Value = premalink.Link;
            _command.Parameters[2].Value = premalink.TagId;

            _connection.Open();
            long tagId = Convert.ToInt64(_command.ExecuteScalar().ToString());
            _connection.Close();

            return tagId;
        }

        public List<DtoTag> GetPremalinkTagsById(Int64 premalinkId)
        {
            _command = new SqlCommand(StoredProcedure.Names.spGetPremalinkTagsById.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@PremaLinkID", SqlDbType.BigInt);

            _command.Parameters[0].Value = premalinkId;

            _lsttag = new List<DtoTag>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _dtotag = new DtoTag
                {
                    TagId = Convert.ToInt64(_datareader["TagID"]),
                    TagName = _datareader["TagName"].ToString()
                };
                _lsttag.Add(_dtotag);
            }
            _connection.Close();
            return _lsttag;
        }

       
        public List<DtoPremalink> GetTaggedpremaLink(int tagId, int pageNumber, int rowsPerPage)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTaggedpremaLink.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _command.Parameters.Add("@TagID", SqlDbType.Int);
                _command.Parameters.Add("@PageNumber", SqlDbType.Int);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.Int);

                _command.Parameters[0].Value = tagId;
                _command.Parameters[1].Value = pageNumber;
                _command.Parameters[2].Value = rowsPerPage;

                _lstpremalink = new List<DtoPremalink>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _premalink = new DtoPremalink
                    {
                        PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                        TagName = _datareader["TagName"].ToString(),
                        TagId = Convert.ToInt64(_datareader["TagID"]),
                        Link = _datareader["Link"].ToString(),
                        Image = _datareader["Image"].ToString(),
                        Title = _datareader["Title"].ToString(),
                        SiteName = _datareader["Site_name"].ToString(),
                        Description = _datareader["Description"].ToString()
                    };

                    //   if (datareader["Published_time"] != null && datareader["Published_time"].ToString() != "")
                    //     premalink.PublishedTime = Convert.ToDateTime(datareader["Published_time"].ToString());

                    _lstpremalink.Add(_premalink);
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }

            return _lstpremalink;
        }

        public List<DtoPremalink> GetUnParsedPremalik()
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUnParsedPremalik.ToString(), _connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                _lstpremalink = new List<DtoPremalink>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _premalink = new DtoPremalink
                    {
                        PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                        Link = _datareader["Link"].ToString(),
                        SiteName = _datareader["Site_name"].ToString(),
                        WebsiteId = Convert.ToInt64(_datareader["Website_Id"])
                    };
                    _lstpremalink.Add(_premalink);
                }
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }

            return _lstpremalink;
        }

        public long AddPremalink(DtoPremalink premalink)
        {
            _command = new SqlCommand(StoredProcedure.Names.spAddPremalink.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@Description", SqlDbType.VarChar);
            _command.Parameters.Add("@Link", SqlDbType.VarChar);
            _command.Parameters.Add("@Image", SqlDbType.VarChar);
            _command.Parameters.Add("@Title", SqlDbType.VarChar);
            _command.Parameters.Add("@Keywords", SqlDbType.VarChar);
            _command.Parameters.Add("@Site_name", SqlDbType.VarChar);
            _command.Parameters.Add("@Published_time", SqlDbType.DateTime);
            _command.Parameters.Add("@WebSiteName", SqlDbType.VarChar);
            _command.Parameters.Add("@WebSiteURL", SqlDbType.VarChar);

            _command.Parameters[0].Value = premalink.Description;
            _command.Parameters[1].Value = premalink.Link;
            _command.Parameters[2].Value = premalink.Image;
            _command.Parameters[3].Value = premalink.Title;
            _command.Parameters[4].Value = premalink.Keywords;
            _command.Parameters[5].Value = premalink.SiteName;
            _command.Parameters[6].Value = premalink.PublishedTime;
            _command.Parameters[7].Value = premalink.WebsiteName;
            _command.Parameters[8].Value = premalink.WebSiteUrl;

            _connection.Open();
            long premalinkId = Convert.ToInt64(_command.ExecuteScalar().ToString());
            _connection.Close();

            return premalinkId;
        }

        public long AddPremalinkimages(DtoPremalink premalink)
        {
            _command = new SqlCommand(StoredProcedure.Names.spAddPremalinkimages.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@premalink", SqlDbType.VarChar);
            _command.Parameters.Add("@imageurl", SqlDbType.VarChar);

            _command.Parameters[0].Value = premalink.Link;
            _command.Parameters[1].Value = premalink.Image;

            _connection.Open();
            long premalinkId = Convert.ToInt64(_command.ExecuteScalar().ToString());
            _connection.Close();

            return premalinkId;
        }

        public long AddPremalinkMetaChar(DtoMeta dtometa)
        {
            _command = new SqlCommand(StoredProcedure.Names.spAddPremalinkMetaChar.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@description", SqlDbType.VarChar);
            _command.Parameters.Add("@url", SqlDbType.VarChar);
            _command.Parameters.Add("@image", SqlDbType.VarChar);
            _command.Parameters.Add("@title", SqlDbType.VarChar);
            _command.Parameters.Add("@keywords", SqlDbType.VarChar);
            _command.Parameters.Add("@site_name", SqlDbType.VarChar);
            _command.Parameters.Add("@published_time", SqlDbType.VarChar);
            _command.Parameters.Add("@emotion", SqlDbType.VarChar);
            _command.Parameters.Add("@type", SqlDbType.VarChar);
            _command.Parameters.Add("@pricecurrency", SqlDbType.VarChar);
            _command.Parameters.Add("@availability", SqlDbType.VarChar);
            _command.Parameters.Add("@priceamount", SqlDbType.VarChar);
            _command.Parameters.Add("@rating", SqlDbType.VarChar);
            _command.Parameters.Add("@gender", SqlDbType.VarChar);
            _command.Parameters.Add("@pricestartdate", SqlDbType.VarChar);
            _command.Parameters.Add("@priceenddate", SqlDbType.VarChar);
            _command.Parameters.Add("@ingredients", SqlDbType.VarChar);
            _command.Parameters.Add("@avilabilitydestinations", SqlDbType.VarChar);
            _command.Parameters.Add("@cooktime", SqlDbType.VarChar);
            _command.Parameters.Add("@preptime", SqlDbType.VarChar);
            _command.Parameters.Add("@totaltime", SqlDbType.VarChar);
            _command.Parameters.Add("@recipeyield", SqlDbType.VarChar);
            _command.Parameters.Add("@aggregaterating", SqlDbType.VarChar);
            _command.Parameters.Add("@duration", SqlDbType.VarChar);
            _command.Parameters.Add("@genre", SqlDbType.VarChar);
            _command.Parameters.Add("@actor", SqlDbType.VarChar);
            _command.Parameters.Add("@director", SqlDbType.VarChar);
            _command.Parameters.Add("@contentrating", SqlDbType.VarChar);
            _command.Parameters.Add("@author", SqlDbType.VarChar);
            _command.Parameters.Add("@section", SqlDbType.VarChar);
            _command.Parameters.Add("@locationlatitude", SqlDbType.VarChar);
            _command.Parameters.Add("@locationlongitude", SqlDbType.VarChar);
            _command.Parameters.Add("@street_address", SqlDbType.VarChar);
            _command.Parameters.Add("@locality", SqlDbType.VarChar);
            _command.Parameters.Add("@region", SqlDbType.VarChar);
            _command.Parameters.Add("@postal_code", SqlDbType.VarChar);
            _command.Parameters.Add("@brand", SqlDbType.VarChar);
            _command.Parameters.Add("@AllMetachar_Link", SqlDbType.VarChar);
            _command.Parameters.Add("@WebsiteUrl", SqlDbType.VarChar);
            _command.Parameters.Add("@WebsiteLogo", SqlDbType.VarChar);

            _command.Parameters[0].Value = dtometa.Ogdescription;
            _command.Parameters[1].Value = dtometa.Ogurl;
            _command.Parameters[2].Value = dtometa.Ogimage;
            _command.Parameters[3].Value = dtometa.Ogtitle;
            _command.Parameters[4].Value = dtometa.Ogkeywords;
            _command.Parameters[5].Value = dtometa.OgsiteName;
            _command.Parameters[6].Value = dtometa.OgpublishedTime;
            _command.Parameters[7].Value = dtometa.Ogemotion;
            _command.Parameters[8].Value = dtometa.Ogtype;
            _command.Parameters[9].Value = dtometa.Ogpricecurrency;
            _command.Parameters[10].Value = dtometa.Ogavailability;
            _command.Parameters[11].Value = dtometa.Ogpriceamount;
            _command.Parameters[12].Value = dtometa.Ograting;
            _command.Parameters[13].Value = dtometa.Oggender;
            _command.Parameters[14].Value = dtometa.Ogpricestartdate;
            _command.Parameters[15].Value = dtometa.Ogpriceenddate;
            _command.Parameters[16].Value = dtometa.Ogingredients;
            _command.Parameters[17].Value = dtometa.Ogavilabilitydestinations;
            _command.Parameters[18].Value = dtometa.Ogcooktime;
            _command.Parameters[19].Value = dtometa.Ogpreptime;
            _command.Parameters[20].Value = dtometa.Ogtotaltime;
            _command.Parameters[21].Value = dtometa.Ogrecipeyield;
            _command.Parameters[22].Value = dtometa.Ogaggregaterating;
            _command.Parameters[23].Value = dtometa.Ogduration;
            _command.Parameters[24].Value = dtometa.Oggenre;
            _command.Parameters[25].Value = dtometa.Ogactor;
            _command.Parameters[26].Value = dtometa.Ogdirector;
            _command.Parameters[27].Value = dtometa.Ogcontentrating;
            _command.Parameters[28].Value = dtometa.Ogauthor;
            _command.Parameters[29].Value = dtometa.Ogsection;
            _command.Parameters[30].Value = dtometa.Oglocationlatitude;
            _command.Parameters[31].Value = dtometa.Oglocationlongitude;
            _command.Parameters[32].Value = dtometa.OgstreetAddress;
            _command.Parameters[33].Value = dtometa.Oglocality;
            _command.Parameters[34].Value = dtometa.Ogregion;
            _command.Parameters[35].Value = dtometa.OgpostalCode;
            _command.Parameters[36].Value = dtometa.Ogbrand;
            _command.Parameters[37].Value = dtometa.AllMetachars;
            _command.Parameters[38].Value = dtometa.WebsiteUrl;
            _command.Parameters[39].Value = dtometa.WebsiteLogo;

            _connection.Open();
            long premalinkId = Convert.ToInt64(_command.ExecuteScalar().ToString());
            _connection.Close();

            return premalinkId;
        }

        public List<DtoPremalink> GetUserNewsFeed(int userId, int currentPage, int totalRec)
        {
            _command = new SqlCommand(StoredProcedure.Names.GetUserNewsFeed.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@UserID", SqlDbType.BigInt);
            _command.Parameters.Add("@pageno", SqlDbType.Int);
            _command.Parameters.Add("@pagesize", SqlDbType.Int);

            _command.Parameters[0].Value = userId;
            _command.Parameters[1].Value = currentPage;
            _command.Parameters[2].Value = totalRec;

            _lstpremalink = new List<DtoPremalink>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _premalink = new DtoPremalink
                {
                    PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                    TagName = _datareader["TagName"].ToString(),
                    WebsiteId = Convert.ToInt64(_datareader["WebsiteID"]),
                    Link = _datareader["Link"].ToString(),
                    Image = _datareader["Image"].ToString(),
                    Keywords = _datareader["Keywords"].ToString(),
                    Title = _datareader["Title"].ToString(),
                    Type = _datareader["Type"].ToString(),
                    Description = _datareader["Description"].ToString(),
                    TotalRec = Convert.ToInt32(_datareader["TotalRec"]),
                    TotalPage = Convert.ToInt32(_datareader["TotalPage"])
                };
                //premalink.TagID = Convert.ToInt64(datareader["TagID"]);
                _lstpremalink.Add(_premalink);
            }
            _connection.Close();

            return _lstpremalink;
        }

        public List<DtoPremalink> SearchTags(string searchQuery, int currentPage, int totalRec)
        {
            _command = new SqlCommand(StoredProcedure.Names.SearchTags.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@Query", SqlDbType.VarChar);
            _command.Parameters.Add("@pageno", SqlDbType.Int);
            _command.Parameters.Add("@pagesize", SqlDbType.Int);

            _command.Parameters[0].Value = searchQuery;
            _command.Parameters[1].Value = currentPage;
            _command.Parameters[2].Value = totalRec;

            _lstpremalink = new List<DtoPremalink>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _premalink = new DtoPremalink
                {
                    PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                    TagName = _datareader["TagName"].ToString(),
                    WebsiteId = Convert.ToInt64(_datareader["WebsiteID"]),
                    Link = _datareader["Link"].ToString(),
                    Image = _datareader["Image"].ToString(),
                    Keywords = _datareader["Keywords"].ToString(),
                    Title = _datareader["Title"].ToString(),
                    Type = _datareader["Type"].ToString(),
                    Description = _datareader["Description"].ToString(),
                    TotalRec = Convert.ToInt32(_datareader["TotalRec"]),
                    TotalPage = Convert.ToInt32(_datareader["TotalPage"])
                };
                _lstpremalink.Add(_premalink);
            }
            _connection.Close();

            return _lstpremalink;
        }

        public DtoPremalink GetPremalinkById(long premalinkId)
        {
            _command = new SqlCommand(StoredProcedure.Names.spGetPremalinkById.ToString(), _connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            _command.Parameters.Add("@PremalinkId", SqlDbType.BigInt);
            _command.Parameters[0].Value = premalinkId;

            _lstpremalink = new List<DtoPremalink>();

            _connection.Open();
            _datareader = _command.ExecuteReader();

            if (!_datareader.HasRows)
                return null;
            while (_datareader.Read())
            {
                _premalink = new DtoPremalink
                {
                    PremalinkId = Convert.ToInt64(_datareader["PremalinkID"]),
                    WebsiteId = Convert.ToInt64(_datareader["Website_Id"]),
                    Link = _datareader["Link"].ToString(),
                    WebsiteName = _datareader["Site_Name"].ToString(),
                    Image = _datareader["Image"].ToString(),
                    Title = _datareader["Title"].ToString(),
                    Type = _datareader["Type"].ToString(),
                    Description = _datareader["Description"].ToString(),
                    PublishedTime = Convert.ToDateTime(_datareader["CreatedOn"].ToString())
                };
            }
            _connection.Close();

            return _premalink;
        }
    }
}