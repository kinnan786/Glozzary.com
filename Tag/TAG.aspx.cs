using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;
using Newtonsoft.Json.Linq;

namespace Tag
{
    public partial class TAG : Page
    {
        private HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debugger.Launch();
                GetCookie();
                if (!IsPostBack)
                {
                    ViewState["flow"] = 0;
                    ViewState["ProfileUserID"] = 0;
                    ViewState["WebsiteName"] = "";
                    ViewState["Premalink"] = "";

                    if (Request.QueryString["flow"] != null)
                        ViewState["flow"] = Request.QueryString["flow"];

                    if (Request.QueryString["Id"] != null)
                        ViewState["ProfileUserID"] = Convert.ToInt64(Request.QueryString["Id"]);

                    if (Request.QueryString["WebsiteName"] != null)
                        ViewState["WebsiteName"] = Request.QueryString["WebsiteName"];

                    if (ViewState["flow"].ToString().ToLower() == "userprofile")
                    {
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartUserProfileTags()</script>");
                    }
                    else if (ViewState["flow"].ToString().ToLower() == "wall")
                    {
                        ViewState["Premalink"] = Request.QueryString["Link"];
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartcontentTags()</script>");
                    }
                    else if (ViewState["flow"].ToString().ToLower() == "tagged")
                    {
                        ViewState["TagId"] = Convert.ToInt64(Request.QueryString["TagId"]);
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartTaggedTags()</script>");
                    }
                    else if (ViewState["flow"].ToString().ToLower() == "inlinecode")
                    {
                        ViewState["Premalink"] = Request.QueryString["Premalink"];
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartinlineTags()</script>");
                    }
                    else if (ViewState["flow"].ToString().ToLower() == "bookmarklet")
                    {
                        ViewState["Premalink"] = Request.QueryString["Premalink"];
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartBookmarkletTags();</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void GetCookie()
        {
            try
            {
                cookie = Request.Cookies["Tagged"];

                if (cookie != null)
                {
                    ViewState["UserID"] = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"]));
                }
                else
                    Response.Redirect("~/Default.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static string GetUserTags(long profileUserId)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];

                var blltag = new BllTag();
                return blltag.GetUserTags(profileUserId, Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return "";
        }

        [WebMethod]
        public static void voteTag(string premalink, long tagId, string vote, string flow, long TagId,
            long profileUserId)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];

                var blltag = new BllTag();
                var tag = new DtoTag();

                tag.TagId = tagId;
                tag.UserId = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"]));
                tag.VoteType = vote;
                tag.Link = premalink;

                if (flow.ToLower() == "userprofile")
                {
                    tag.UserId = profileUserId;
                    blltag.VoteUserTag(tag);
                }
                else if (flow.ToLower() == "tagged")
                {
                    tag.TagId = tagId;
                    tag.TagCount = TagId;
                    blltag.VoteTagged(tag);
                }
                else
                    blltag.VoteTag(tag);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static string GetTagsbyPremalink(string Premalink)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
                JObject o;

                if (cookie != null)
                {
                    var blltag = new BllTag();
                    var lsttag = new List<DtoTag>();
                    lsttag = blltag.GetTagsbyPremalink(Premalink);

                    if (lsttag != null && lsttag.Count > 0)
                    {
                        o = JObject.FromObject(new
                        {
                            Tag = new
                            {
                                Item =
                                    from p in lsttag
                                    select new
                                    {
                                        Id = p.TagId,
                                        Vote = p.VoteType,
                                        p.TagName
                                    }
                            }
                        });

                        return o.ToString();
                    }
                }
                else
                    return null;

                return null;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetwallTags(string Premalink)
        {
            try
            {
                var blltag = new BllTag();

                JObject o = JObject.FromObject(new
                {
                    Tag = new
                    {
                        Item =
                            from p in blltag.GetTagsbyPremalink(Premalink)
                            select new
                            {
                                Id = p.TagId,
                                Vote = p.VoteType,
                                p.TagName
                            }
                    }
                });

                return o.ToString();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debugger.Launch();
                var blltag = new BllTag();
                string tag = hdntag.Value;
                string[] level1 = tag.Split('|');

                if (ViewState["flow"].ToString().ToLower() == "userprofile")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "1")
                        {
                            blltag.AddUserTags(level2[0], Convert.ToInt64(ViewState["ProfileUserID"]),
                                Convert.ToInt64(ViewState["UserID"]));
                        }
                    }
                }
                else if (ViewState["flow"].ToString().ToLower() == "tagged")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "1")
                        {
                            blltag.AddTagged(new DtoTag
                            {
                                TagName = level2[0],
                                TagId = Convert.ToInt64(ViewState["TagId"]),
                                UserId = Convert.ToInt64(ViewState["UserID"])
                            });
                        }
                    }
                }
                else if (ViewState["flow"].ToString().ToLower() == "inlinecode")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "1")
                        {
                            if (ViewState["WebsiteName"].ToString() == "")
                            {
                                var u = new Uri(ViewState["Premalink"].ToString());
                                ViewState["WebsiteName"] = u.Host;
                            }
                            blltag.AddTag(new DtoTag
                            {
                                TagName = level2[0],
                                Link = ViewState["Premalink"].ToString(),
                                WebsiteName = ViewState["WebsiteName"].ToString(),
                                TagType = "0",
                                UserId = Convert.ToInt64(ViewState["UserID"])
                            });
                        }
                    }
                }
                else if (ViewState["flow"].ToString().ToLower() == "bookmarklet")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "1")
                        {
                            blltag.AddTag(new DtoTag
                            {
                                TagName = level2[0],
                                Link = ViewState["Premalink"].ToString(),
                                TagType = "0",
                                UserId = Convert.ToInt64(ViewState["UserID"])
                            });
                        }
                    }
                }
                else
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "1")
                        {
                            if (ViewState["WebsiteName"].ToString() == "")
                            {
                                var u = new Uri(ViewState["Premalink"].ToString());
                                ViewState["WebsiteName"] = u.Host;
                            }
                            blltag.AddTag(new DtoTag
                            {
                                TagName = level2[0],
                                Link = ViewState["Premalink"].ToString(),
                                WebsiteName = ViewState["WebsiteName"].ToString(),
                                TagType = "0",
                                UserId = Convert.ToInt64(ViewState["UserID"])
                            });
                        }
                    }
                }
                Response.Redirect(Request.RawUrl);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable TagIntellisense(string PrefixText, string Premalink)
        {
            try
            {
                var bllbtag = new BllTag();
                return bllbtag.TagIntellisense(PrefixText, Premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable TagIntellisense(string prefixText)
        {
            System.Diagnostics.Debugger.Launch();
            try
            {
                //var bllbtag = new BllTag();
                //return bllbtag.TagIntellisense(prefixText);
                return null;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        public static string GetTagged(long tagId)
        {
            try
            {
                var blltag = new BllTag();
                return blltag.GetTagged(tagId);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}