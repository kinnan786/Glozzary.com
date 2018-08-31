using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using DTO;

namespace DAL
{
    /// <summary>
    ///     Summary description for DALTAG
    /// </summary>
    public class DalTag
    {
        private readonly SqlConnection _connection;
        private SqlCommand _command;
        private SqlDataReader _datareader;
        private List<DtoTag> _lsttag;
        private DtoTag _tag;

        public DalTag()
        {
            var connectionstring = ConfigurationManager.ConnectionStrings["TagConnectionString"].ConnectionString;
            _connection = new SqlConnection(connectionstring);
        }

        public List<DtoTag> GetWebsiteTags(long Id)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetWebsiteTags.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@Id", SqlDbType.BigInt);

                _command.Parameters[0].Value = Id;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                else
                {
                    while (_datareader.Read())
                    {
                        _tag = new DtoTag();
                        _tag.TagId = Convert.ToInt32(_datareader["Id"]);
                        _tag.TagName = _datareader["Name"].ToString();
                        _tag.TagCount = Convert.ToInt64(_datareader["Count"]);
                        _tag.WebsiteName = _datareader["WebsiteName"].ToString();
                        _lsttag.Add(_tag);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> GetAllTag(string WebSiteName, string Premalink, long userid)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetAllTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@WebSiteName", SqlDbType.VarChar);
                _command.Parameters.Add("@Premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);

                _command.Parameters[0].Value = WebSiteName;
                _command.Parameters[1].Value = Premalink;
                _command.Parameters[2].Value = userid;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                else
                {
                    while (_datareader.Read())
                    {
                        _tag = new DtoTag();
                        _tag.TagId = Convert.ToInt32(_datareader["Tagid"]);
                        _tag.TagName = _datareader["TagName"].ToString();
                        _tag.TagCount = Convert.ToInt64(_datareader["TotalVote"]);
                        _tag.MetaTagCheck = Convert.ToBoolean(_datareader["MetaTagCheck"]);
                        _tag.IsActive = Convert.ToBoolean(_datareader["IsActive"]);
                        _lsttag.Add(_tag);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> GetTag(string WebSiteName, string Premalink, string WebsiteURL, string tagtype)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@WebSiteName", SqlDbType.VarChar);
                _command.Parameters.Add("@Premalink", SqlDbType.VarChar);

                _command.Parameters[0].Value = WebSiteName;
                _command.Parameters[1].Value = Premalink;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                else
                {
                    while (_datareader.Read())
                    {
                        _tag = new DtoTag();
                        _tag.TagId = Convert.ToInt32(_datareader["Tagid"]);
                        _tag.TagName = _datareader["TagName"].ToString();
                        _tag.TagCount = Convert.ToInt64(_datareader["TotalVote"]);
                        _lsttag.Add(_tag);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public long AssociateTag(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAssociateTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.Int);
                _command.Parameters.Add("@Link", SqlDbType.VarChar);
                _command.Parameters.Add("@WebsiteName", SqlDbType.VarChar);
                _command.Parameters.Add("@TagType", SqlDbType.VarChar);

                _command.Parameters[0].Value = Tag.TagId;
                _command.Parameters[1].Value = Tag.Link;
                _command.Parameters[2].Value = Tag.WebsiteName;
                _command.Parameters[3].Value = Tag.TagType;

                _connection.Open();
                TagId = Convert.ToInt64(_command.ExecuteScalar().ToString());
            }
            catch (Exception error)
            {
            }
            finally
            {
                _connection.Close();
            }

            return TagId;
        }

        public long IncrementTag(DtoTag Tag)
        {
            long TagId = 0;
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.IncrementTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagID", SqlDbType.BigInt);
                _command.Parameters[0].Value = Tag.TagId;

                _connection.Open();
                TagId = _command.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public List<DtoTag> SearchTag(string TagName)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spSearchTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters[0].Value = TagName;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> GetAllTags(long UserID, string Tagname, int CurrentPage, int TotalRecord, string flow)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetAllTags.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@PageNo", SqlDbType.Int);
                _command.Parameters.Add("@PageSize", SqlDbType.Int);
                _command.Parameters.Add("@Flow", SqlDbType.VarChar);

                _command.Parameters[0].Value = UserID;
                _command.Parameters[1].Value = Tagname;
                _command.Parameters[2].Value = Convert.ToInt32(CurrentPage);
                _command.Parameters[3].Value = Convert.ToInt32(TotalRecord);
                _command.Parameters[4].Value = flow;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _tag.TotalPage = Convert.ToInt32(_datareader["TotalPage"]);
                    _tag.UserId = Convert.ToInt64(_datareader["UserId"]);
                    _tag.TagCount = Convert.ToInt64(_datareader["userFollow"]);
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public long VoteTag(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spVoteTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagID", SqlDbType.Int);
                _command.Parameters.Add("@Link", SqlDbType.VarChar);
                _command.Parameters.Add("@VoteType", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.Int);

                _command.Parameters[0].Value = Tag.TagId;
                _command.Parameters[1].Value = Tag.Link;
                _command.Parameters[2].Value = Tag.VoteType;
                _command.Parameters[3].Value = Tag.UserId;

                _connection.Open();
                TagId = Convert.ToInt64(_command.ExecuteScalar());
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public long VoteUserTag(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spVoteUserTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagID", SqlDbType.Int);
                _command.Parameters.Add("@VoteType", SqlDbType.VarChar);
                _command.Parameters.Add("@LoggedInUserId", SqlDbType.BigInt);
                _command.Parameters.Add("@ProfileUserId", SqlDbType.BigInt);

                _command.Parameters[0].Value = Tag.TagId;
                _command.Parameters[1].Value = Tag.VoteType;
                _command.Parameters[2].Value = Tag.UserId;
                _command.Parameters[3].Value = Tag.TagCount;

                _connection.Open();
                TagId = Convert.ToInt64(_command.ExecuteScalar());
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public long VoteTagged(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spVoteTagged.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters.Add("@VoteType", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@TaggedoneId", SqlDbType.BigInt);

                _command.Parameters[0].Value = Tag.TagCount;
                _command.Parameters[1].Value = Tag.VoteType;
                _command.Parameters[2].Value = Tag.UserId;
                _command.Parameters[3].Value = Tag.TagId;

                _connection.Open();
                TagId = Convert.ToInt64(_command.ExecuteScalar());
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public List<DtoTag> WhatTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spWhatTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> HowTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spHowTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> WhenTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spWhenTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> WhereTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spWhereTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> WhoTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spWhoTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public List<DtoTag> WhyTagIntellisense(string TagName, string premalink, string websitename)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spWhyTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@websitename", SqlDbType.VarChar);

                _command.Parameters[0].Value = TagName;
                _command.Parameters[1].Value = premalink;
                _command.Parameters[2].Value = websitename;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["TagId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _lsttag.Add(_tag);
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return _lsttag;
        }

        public long AddTag(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAddTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@Link", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);

                _command.Parameters[0].Value = Tag.TagName;
                _command.Parameters[1].Value = Tag.Link;
                _command.Parameters[2].Value = Tag.UserId;

                _connection.Open();
                TagId = _command.ExecuteNonQuery();
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public long AddTagged(DtoTag Tag)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAddTagged.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);

                _command.Parameters[0].Value = Tag.TagId;
                _command.Parameters[1].Value = Tag.TagName;
                _command.Parameters[2].Value = Tag.UserId;

                _connection.Open();
                TagId = _command.ExecuteNonQuery();
            }
            catch (Exception error)
            {
                throw;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public DtoTag GetTag(int tagid, int userid)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagId.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.Int);
                _command.Parameters.Add("@UserID", SqlDbType.Int);

                _command.Parameters[0].Value = tagid;
                _command.Parameters[1].Value = userid;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagName = _datareader["TagName"].ToString();
                    _tag.About = _datareader["About"].ToString();
                    return _tag;
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
            return _tag;
        }

        public List<DtoTag> TagIntellisense(string prefixText, string Premalink)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@Premalink", SqlDbType.VarChar);
                _command.Parameters.Add("@PrefixText", SqlDbType.VarChar);

                _command.Parameters[0].Value = Premalink;
                _command.Parameters[1].Value = prefixText;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["Id"].ToString());
                    _tag.TagName = _datareader["Name"].ToString();
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> TagIntellisense(string prefixText)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spTagIntellisense.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@PrefixText", SqlDbType.VarChar);

                _command.Parameters[0].Value = prefixText;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["Id"].ToString());
                    _tag.TagName = _datareader["Name"].ToString();
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> GetTagsbyPremalink(string Premalink)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagsbyPremalink.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@Premalink", SqlDbType.VarChar);
                _command.Parameters[0].Value = Premalink;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt32(_datareader["Tag_Id"].ToString());
                    _tag.VoteType = _datareader["TotalVote"].ToString();
                    _tag.TagName = _datareader["TagName"].ToString();

                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> GetTagByUser(Int64 UserID)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagByUser.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters[0].Value = UserID;
                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt64(_datareader["Tag_Id"].ToString());
                    _tag.TagCount = Convert.ToInt64(_datareader["Count"].ToString());
                    _tag.TagName = _datareader["Name"].ToString();
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> GetTagByWebsite(long websiteId)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagByWebsite.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@WebsiteId", SqlDbType.BigInt);
                _command.Parameters[0].Value = websiteId;
                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt64(_datareader["Tag_Id"].ToString());
                    _tag.TagCount = Convert.ToInt64(_datareader["Count"].ToString());
                    _tag.TagName = _datareader["Name"].ToString();
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public List<DtoTag> GetUserTags(long CurrentUserID, long LoggedInUser)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetUserTags.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@CurrentUserID", SqlDbType.BigInt);
                _command.Parameters.Add("@LoggedInUser", SqlDbType.BigInt);

                _command.Parameters[0].Value = CurrentUserID;
                _command.Parameters[1].Value = LoggedInUser;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt64(_datareader["TagID"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _tag.TagCount = Convert.ToInt64(_datareader["Count"].ToString());
                    _tag.UserId = Convert.ToInt64(_datareader["LoggedUserTag"]);
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public long AddUserTags(string Tagname, long CurrentUserID, long LoggedInUser)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spAddUserTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagName", SqlDbType.VarChar);
                _command.Parameters.Add("@LoggedInUserId", SqlDbType.BigInt);
                _command.Parameters.Add("@ProfileUserId", SqlDbType.BigInt);

                _command.Parameters[0].Value = Tagname;
                _command.Parameters[1].Value = LoggedInUser;
                _command.Parameters[2].Value = CurrentUserID;

                _connection.Open();
                return Convert.ToInt64(_command.ExecuteScalar());
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

        public long VoteContent(DtoNewsFeed news)
        {
            long TagId = 0;

            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spVoteContent.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@UserID", SqlDbType.BigInt);
                _command.Parameters.Add("@ContentID", SqlDbType.BigInt);
                _command.Parameters.Add("@TagID", SqlDbType.BigInt);
                _command.Parameters.Add("@VoteType", SqlDbType.VarChar);

                _command.Parameters[0].Value = news.UserId;
                _command.Parameters[1].Value = news.PremalinkId;
                _command.Parameters[2].Value = news.TagId;
                _command.Parameters[3].Value = news.Title;

                _connection.Open();
                TagId = Convert.ToInt64(_command.ExecuteScalar());
            }
            catch (Exception error)
            {
                throw error;
            }
            finally
            {
                _connection.Close();
            }
            return TagId;
        }

        public List<DtoTag> GetTagged(long tagId)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagged.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);

                _command.Parameters[0].Value = tagId;

                _lsttag = new List<DtoTag>();

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagId = Convert.ToInt64(_datareader["TaggedoneId"].ToString());
                    _tag.TagName = _datareader["TagName"].ToString();
                    _tag.TagCount = Convert.ToInt64(_datareader["TotalVote"].ToString());
                    _lsttag.Add(_tag);
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
            return _lsttag;
        }

        public DtoTag GetTagById(long tagId)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagById.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters[0].Value = tagId;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    _tag = new DtoTag();
                    _tag.TagName = _datareader["Name"].ToString();
                    _tag.About = _datareader["About"].ToString();
                    break;
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
            return _tag;
        }

        public List<DtoNewsFeed> GetTagNewsFeed(long UserID, long tagid, long PageNumber, long RowsPerPage)
        {
            var lstnewsfeed = new List<DtoNewsFeed>();
            var dtonewsfeed = new DtoNewsFeed();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetTagNewsFeed.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = tagid;
                _command.Parameters[1].Value = UserID;
                _command.Parameters[2].Value = PageNumber;
                _command.Parameters[3].Value = RowsPerPage;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    dtonewsfeed = new DtoNewsFeed();
                    dtonewsfeed.TagId = Convert.ToInt64(_datareader["Tag_Id"]);
                    dtonewsfeed.WebsiteId = Convert.ToInt64(_datareader["Website_Id"].ToString());
                    dtonewsfeed.WebsiteName = _datareader["WebsiteName"].ToString();
                    dtonewsfeed.PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString());
                    dtonewsfeed.TagName = _datareader["TagName"].ToString();
                    dtonewsfeed.UpVote = Convert.ToInt32(_datareader["UpVote"].ToString());
                    dtonewsfeed.DownVote = Convert.ToInt32(_datareader["DownVote"].ToString());
                    dtonewsfeed.TaggedByUser = Convert.ToBoolean(_datareader["TaggedByUser"].ToString());
                    dtonewsfeed.Link = _datareader["Link"].ToString();
                    dtonewsfeed.Title = _datareader["Title"].ToString();
                    dtonewsfeed.Description = _datareader["Description"].ToString();
                    dtonewsfeed.Image = _datareader["Image"].ToString();
                    dtonewsfeed.TotalVote = Convert.ToInt64(_datareader["TotalVote"].ToString());
                    dtonewsfeed.CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString());
                    dtonewsfeed.EmotionId = Convert.ToInt32(_datareader["EmotionId"]);
                    dtonewsfeed.EmotionName = _datareader["EmotionName"].ToString();
                    dtonewsfeed.TotalCount = Convert.ToInt64(_datareader["TotalCount"].ToString());
                    if (_datareader["UserEmotion"] != DBNull.Value)
                        dtonewsfeed.IsActive = (Convert.ToInt32(_datareader["UserEmotion"]) == 0) ? false : true;
                    dtonewsfeed.WebsiteImage = _datareader["WebsiteImage"].ToString();
                    lstnewsfeed.Add(dtonewsfeed);
                }
                return lstnewsfeed;
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

        public List<DtoNewsFeed> ExplorehNewsFeed(long UserID, string search, long PageNumber, long RowsPerPage)
        {
            var lstnewsfeed = new List<DtoNewsFeed>();
            var dtonewsfeed = new DtoNewsFeed();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spExplorehNewsFeed.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@Search", SqlDbType.VarChar);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = search;
                _command.Parameters[1].Value = UserID;
                _command.Parameters[2].Value = PageNumber;
                _command.Parameters[3].Value = RowsPerPage;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    dtonewsfeed = new DtoNewsFeed();
                    dtonewsfeed.TagId = Convert.ToInt64(_datareader["Tag_Id"]);
                    dtonewsfeed.WebsiteId = Convert.ToInt64(_datareader["Website_Id"].ToString());
                    dtonewsfeed.WebsiteName = _datareader["WebsiteName"].ToString();
                    dtonewsfeed.PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString());
                    dtonewsfeed.TagName = _datareader["TagName"].ToString();
                    dtonewsfeed.UpVote = Convert.ToInt32(_datareader["UpVote"].ToString());
                    dtonewsfeed.DownVote = Convert.ToInt32(_datareader["DownVote"].ToString());
                    dtonewsfeed.TaggedByUser = Convert.ToBoolean(_datareader["TaggedByUser"].ToString());
                    dtonewsfeed.Link = _datareader["Link"].ToString();
                    dtonewsfeed.Title = _datareader["Title"].ToString();
                    dtonewsfeed.Description = _datareader["Description"].ToString();
                    dtonewsfeed.Image = _datareader["Image"].ToString();
                    dtonewsfeed.TotalVote = Convert.ToInt64(_datareader["TotalVote"].ToString());
                    dtonewsfeed.CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString());
                    dtonewsfeed.EmotionId = Convert.ToInt32(_datareader["EmotionId"]);
                    dtonewsfeed.EmotionName = _datareader["EmotionName"].ToString();
                    dtonewsfeed.TotalCount = Convert.ToInt64(_datareader["TotalCount"].ToString());
                    if (_datareader["UserEmotion"] != DBNull.Value)
                        dtonewsfeed.IsActive = (Convert.ToInt32(_datareader["UserEmotion"]) == 0) ? false : true;
                    lstnewsfeed.Add(dtonewsfeed);
                }
                return lstnewsfeed;
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

        public List<DtoNewsFeed> GetEmoNewsFeed(long UserID, int emoid, long PageNumber, long RowsPerPage)
        {
            var lstnewsfeed = new List<DtoNewsFeed>();
            var dtonewsfeed = new DtoNewsFeed();
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spGetEmoNewsFeed.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@EmoId", SqlDbType.BigInt);
                _command.Parameters.Add("@UserId", SqlDbType.BigInt);
                _command.Parameters.Add("@PageNumber", SqlDbType.BigInt);
                _command.Parameters.Add("@RowsPerPage", SqlDbType.BigInt);

                _command.Parameters[0].Value = emoid;
                _command.Parameters[1].Value = UserID;
                _command.Parameters[2].Value = PageNumber;
                _command.Parameters[3].Value = RowsPerPage;

                _connection.Open();
                _datareader = _command.ExecuteReader();

                if (!_datareader.HasRows)
                    return null;
                while (_datareader.Read())
                {
                    dtonewsfeed = new DtoNewsFeed();
                    dtonewsfeed.TagId = Convert.ToInt64(_datareader["Tag_Id"]);
                    dtonewsfeed.WebsiteId = Convert.ToInt64(_datareader["Website_Id"].ToString());
                    dtonewsfeed.WebsiteName = _datareader["WebsiteName"].ToString();
                    dtonewsfeed.PremalinkId = Convert.ToInt64(_datareader["PremalinkId"].ToString());
                    dtonewsfeed.TagName = _datareader["TagName"].ToString();
                    dtonewsfeed.UpVote = Convert.ToInt32(_datareader["UpVote"].ToString());
                    dtonewsfeed.DownVote = Convert.ToInt32(_datareader["DownVote"].ToString());
                    dtonewsfeed.TaggedByUser = Convert.ToBoolean(_datareader["TaggedByUser"].ToString());
                    dtonewsfeed.Link = _datareader["Link"].ToString();
                    dtonewsfeed.Title = _datareader["Title"].ToString();
                    dtonewsfeed.Description = _datareader["Description"].ToString();
                    dtonewsfeed.Image = _datareader["Image"].ToString();
                    dtonewsfeed.TotalVote = Convert.ToInt64(_datareader["TotalVote"].ToString());
                    dtonewsfeed.CreatedOn = Convert.ToDateTime(_datareader["CreatedOn"].ToString());
                    dtonewsfeed.EmotionId = Convert.ToInt32(_datareader["EmotionId"]);
                    dtonewsfeed.EmotionName = _datareader["EmotionName"].ToString();
                    dtonewsfeed.TotalCount = Convert.ToInt64(_datareader["TotalCount"].ToString());
                    if (_datareader["UserEmotion"] != DBNull.Value)
                        dtonewsfeed.IsActive = (Convert.ToInt32(_datareader["UserEmotion"]) == 0) ? false : true;
                    lstnewsfeed.Add(dtonewsfeed);
                }
                return lstnewsfeed;
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

        public void DeleteTag(long premalinkid, long tagid)
        {
            try
            {
                _command = new SqlCommand(StoredProcedure.Names.spDeleteTag.ToString(), _connection);
                _command.CommandType = CommandType.StoredProcedure;

                _command.Parameters.Add("@TagId", SqlDbType.BigInt);
                _command.Parameters.Add("@PremalinkId", SqlDbType.BigInt);

                _command.Parameters[0].Value = tagid;
                _command.Parameters[1].Value = premalinkid;

                _connection.Open();
                _command.ExecuteScalar();
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
    }
}