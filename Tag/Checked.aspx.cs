using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag
{
    public partial class Checked : Page
    {
        private BllEmotions _bllemo = new BllEmotions();
        private BllWebsite _bllwebsite = new BllWebsite();
        private BllTag _bltag = new BllTag();
        private HttpCookie _cookie;
        private DtoWebsite _dtowebsite = new DtoWebsite();
        private List<DtoEmotions> _lstemo = new List<DtoEmotions>();
        private List<DtoTag> _lsttag = new List<DtoTag>();
        private bool _metaTagCheck;
        private long _userId;
        private Uri _websiteurl;
        protected bool Emotionflag;
        protected string Premalink = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    ViewState["websiteName"] = "";
                    ViewState["websiteid"] = 0;
                    ViewState["addEmotion"] = false;
                    ViewState["addTag"] = false;
                    ViewState["rateTag"] = false;

                    if (Request.QueryString["url"] != null && Request.QueryString["Websitename"] != null)
                    {
                        Premalink = Request.QueryString["url"];
                        ViewState["websiteName"] = Request.QueryString["Websitename"];

                        if (Request.QueryString["RateabletagId"] != null && Request.QueryString["RateabletagId"] != "")
                        {
                            ViewState["RateabletagId"] = Request.QueryString["RateabletagId"];
                        }
                    }

                    hdntag.Value = GetTag(ViewState["websiteName"].ToString(), Premalink);
                    hdnemo.Value = GetEmotion(ViewState["websiteName"].ToString(), Premalink);
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod(EnableSession = true)]
        public static int RateEmotion(string premalink, int EmotionId, string Rate)
        {
            try
            {
                var bllemotion = new BllEmotions();
                var returnvalue = 0;

                HttpCookie cookie;
                cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (Rate == "plus")
                    returnvalue = bllemotion.IncrementEmotion(premalink, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                else if (Rate == "minus")
                    returnvalue = bllemotion.DecrementEmotion(premalink, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));

                return returnvalue;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        private int GetCookie()
        {
            _cookie = Request.Cookies["Tagged"];
            if (_cookie != null)
                _userId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));

            return 0;
        }

        public string GetEmotion(string websitename, string premalink)
        {
            try
            {
                _websiteurl = new Uri(premalink);

                GetCookie();
                _bltag = new BllTag();
                _bllemo = new BllEmotions();
                _bllwebsite = new BllWebsite();
                _lsttag = new List<DtoTag>();
                _lstemo = new List<DtoEmotions>();
                _dtowebsite = new DtoWebsite();

                _lstemo = _bllemo.GetAllEmotion(websitename, premalink, _userId);
                _dtowebsite = _bllwebsite.GetWebsiteByName(websitename);

                if (_dtowebsite != null)
                {
                    ViewState["websiteid"] = _dtowebsite.WebsiteId;
                    ViewState["addEmotion"] = _dtowebsite.AddEmotion;
                    Emotionflag = _dtowebsite.Emotion;

                    if (Emotionflag)
                    {
                        if (Convert.ToBoolean(ViewState["addEmotion"]))
                        {
                            deleteemoanchor.Style.Add("display", "inline");
                            addemoanchor.Style.Add("display", "inline");
                        }
                        else
                        {
                            deleteemoanchor.Style.Add("display", "none");
                            addemoanchor.Style.Add("display", "none");
                        }
                    }
                }

                var emotion = "";
                if (_lstemo != null)
                {
                    foreach (var emo in _lstemo)
                        emotion += "|" + emo.EmotionName + "," + emo.Emotionid + "," + emo.TotalCount + "," +
                                   emo.IsActive;
                }
                return emotion;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        public string GetTag(string websitename, string premalink)
        {
            try
            {
                _websiteurl = new Uri(premalink);
                _bltag = new BllTag();
                _bllwebsite = new BllWebsite();
                _lsttag = new List<DtoTag>();
                _dtowebsite = new DtoWebsite();

                _lsttag = _bltag.GetAllTag(websitename, premalink, _userId);
                _dtowebsite = _bllwebsite.GetWebsiteByName(websitename);

                if (_dtowebsite != null)
                {
                    ViewState["websiteid"] = _dtowebsite.WebsiteId;
                    ViewState["addTag"] = _dtowebsite.AddTag;
                    ViewState["rateTag"] = _dtowebsite.RateTag;
                    ViewState["addEmotion"] = _dtowebsite.AddEmotion;

                    if (Convert.ToBoolean(ViewState["addTag"]))
                    {
                        Minusanchor.Style.Add("display", "inline");
                        addanchor.Style.Add("display", "inline");
                    }
                    else
                    {
                        Minusanchor.Style.Add("display", "none");
                        addanchor.Style.Add("display", "none");
                    }
                }

                var tags = "";
                if (_lsttag != null)
                {
                    foreach (var tag in _lsttag)
                        tags += "|" + tag.TagName + "," + tag.TagId + "," + tag.TagCount + "," + tag.IsActive;
                }
                _metaTagCheck = _lsttag != null && _lsttag[0].MetaTagCheck;
                return tags;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod(EnableSession = true)]
        public static long voteTag(string premalink, long TagId, string vote)
        {
            try
            {
                var blltag = new BllTag();
                var tag = new DtoTag();

                var cookie1 = HttpContext.Current.Request.Cookies["Tagged"];
                if (cookie1 != null)
                {
                    tag.TagId = TagId;
                    tag.UserId = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie1["d"]));
                    tag.VoteType = vote;
                    tag.Link = premalink;
                    return blltag.VoteTag(tag);
                }
                return -2;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }
    }
}