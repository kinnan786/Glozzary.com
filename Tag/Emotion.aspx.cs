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
    public partial class Emotion : Page
    {
        private string _flow;
        private string _websiteName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // System.Diagnostics.Debugger.Launch();

                if (!IsPostBack)
                {
                    ViewState["TagId"] = 0;
                    ViewState["premalink"] = 0;
                }


                if (Request.QueryString["Premalink"] != null)
                {
                    if (Request.QueryString["Premalink"] != "")
                        ViewState["premalink"] = Request.QueryString["Premalink"];
                }

                if (Request.QueryString["WebsiteName"] != null)
                    _websiteName = Request.QueryString["WebsiteName"];

                if (Request.QueryString["Id"] != null)
                    ViewState["ProfileUserID"] = Convert.ToInt64(Request.QueryString["Id"]);


                if (Request.QueryString["flow"] != null)
                {
                    _flow = Request.QueryString["flow"];

                    if (_flow.ToLower() == "userprofile")
                    {
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartUserProfileEmotion()</script>");
                    }
                    else if (_flow == "wall")
                    {
                        ViewState["premalink"] = Request.QueryString["Link"];
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartcontentEmotion()</script>");
                    }
                    else if (_flow == "tagged")
                    {
                        ViewState["TagId"] = Convert.ToInt64(Request.QueryString["TagId"]);
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartTaggedEmotion()</script>");
                    }
                    else if (_flow == "inlinecode")
                    {
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartInlinecodeEmotion();</script>");
                    }
                    else if (_flow.ToLower() == "bookmarklet")
                    {
                        Page.ClientScript.RegisterClientScriptBlock(GetType(), "Start",
                            "<script type='text/javascript'>StartBookmarkletEmotion();</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod(EnableSession = true)]
        public static IEnumerable EmotionIntellisense(string PrefixText, string Premalink)
        {
            try
            {
                var bllemotion = new BllEmotions();
                return bllemotion.EmotionIntellisense(Premalink, PrefixText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetEmotionbyPremalink(string Premalink, string UserID)
        {
            try
            {
                var bllemotion = new BllEmotions();

                JObject o = JObject.FromObject(new
                {
                    Emotion = new
                    {
                        Item =
                            from p in bllemotion.GetPremalinkEmotions(Premalink, Convert.ToInt64(UserID))
                            select new
                            {
                                Id = p.Emotionid,
                                p.TotalCount,
                                p.EmotionName
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

        [WebMethod]
        public static string GetEmotion(long tagId)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
                var bllemo = new BllEmotions();
                return bllemo.GetTaggedEmotion(tagId, Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        public static int RateTaggedEmotion(int EmotionId, string Rate, long tagid)
        {
            try
            {
                var bllemotion = new BllEmotions();
                int returnvalue = 0;

                HttpCookie cookie;
                cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (Rate == "plus")
                    returnvalue = bllemotion.IncrementTaggedEmotion(tagid, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                else if (Rate == "minus")
                    returnvalue = bllemotion.DecrementTaggedEmotion(tagid, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));

                return returnvalue;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        [WebMethod(EnableSession = true)]
        public static string GetPremalinkEmotions(string Premalink)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
                JObject o;

                if (cookie != null)
                {
                    var bllemotion = new BllEmotions();
                    var lstemotion = new List<DtoEmotions>();
                    lstemotion = bllemotion.GetPremalinkEmotions(Premalink,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));

                    if (lstemotion != null && lstemotion.Count > 0)
                    {
                        o = JObject.FromObject(new
                        {
                            Emotion = new
                            {
                                Item =
                                    from E in lstemotion
                                    select new
                                    {
                                        Id = E.Emotionid,
                                        Vote = E.TotalCount,
                                        Name = E.EmotionName,
                                        UserEmotion = E.IsActive
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
        public static string GetUserEmotion(long profileUserId)
        {
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
                var bllemo = new BllEmotions();
                return bllemo.GetUserEmotion(profileUserId, Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod(EnableSession = true)]
        public static int RateEmotion(string premalink, int EmotionId, string Rate)
        {
            try
            {
                var bllemotion = new BllEmotions();
                int returnvalue = 0;

                HttpCookie cookie;
                cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (cookie != null)
                {
                    if (cookie["d"] != null && cookie["d"] != "")
                    {
                        if (Rate == "plus")
                            returnvalue = bllemotion.IncrementEmotion(premalink, EmotionId,
                                Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                        else if (Rate == "minus")
                            returnvalue = bllemotion.DecrementEmotion(premalink, EmotionId,
                                Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));

                        return returnvalue;
                    }
                }
                return -1;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        [WebMethod(EnableSession = true)]
        public static int RateUserEmotion(int EmotionId, string Rate, long profileUserId)
        {
            try
            {
                var bllemotion = new BllEmotions();
                int returnvalue = 0;

                HttpCookie cookie;
                cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (Rate == "plus")
                    returnvalue = bllemotion.IncrementUserEmotion(EmotionId, profileUserId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                else if (Rate == "minus")
                    returnvalue = bllemotion.DecrementUserEmotion(EmotionId, profileUserId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));

                return returnvalue;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                var bllemotion = new BllEmotions();
                HttpCookie cookie = Request.Cookies["Tagged"];
                long userId = 0;

                if (cookie != null)
                    userId = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"]));

                string tag = hdnemo.Value;
                string[] level1 = tag.Split('|');

                if (_flow.ToLower() == "userprofile")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "new")
                        {
                            bllemotion.AddUserEmotion(level2[0], userId, Convert.ToInt64(ViewState["ProfileUserID"]));
                        }
                    }
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "Hidepopup",
                        "<script type='text/javascript'>HidePopup()</script>");
                }
                else if (_flow.ToLower() == "tagged")
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "new")
                        {
                            bllemotion.AddTaggedEmotion(level2[0], userId, Convert.ToInt64(ViewState["TagId"]));
                        }
                    }
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "Hidepopup",
                        "<script type='text/javascript'>HidePopup()</script>");
                }
                else
                {
                    for (int i = 1; i < level1.Length; i++)
                    {
                        string[] level2 = level1[i].Split(',');
                        if (level2[3] == "new")
                        {
                            bllemotion.AddEmotion(level2[0], ViewState["premalink"].ToString(),
                                Convert.ToInt32(level2[1]), userId);
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
    }
}