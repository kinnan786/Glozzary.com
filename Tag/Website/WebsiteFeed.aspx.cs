using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Website
{
    public partial class WebsiteFeed : Page
    {
        protected string EmoId = "";
        protected string Imageurl = "";
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        protected List<DtoEmotions> Lstemotions;
        protected List<DtoTag> Lsttag;
        protected string TagId = "";
        protected long Websiteid;
        private BllEmotions _bllemotion;
        private BllTag _blltag;
        private BllWebsite _bllwebsite;
        private HttpCookie _cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetCookie();

                _bllwebsite = new BllWebsite();
                _blltag = new BllTag();
                _bllemotion = new BllEmotions();
                Lstdtonewsfeed = new List<DtoNewsFeed>();
                string[] items;


                if (!IsPostBack)
                    ViewState["UserID"] = 0;

                if (Request.QueryString["WebsiteId"] != null)
                {
                    Websiteid = Convert.ToInt64(Request.QueryString["WebsiteId"]);

                    if (Request.QueryString["TagId"] != null)
                    {
                        string tagarray = Request.QueryString["TagId"];
                        if (tagarray.Split(',').Length > 0)
                        {
                            items = tagarray.Split(',');
                            for (int i = 0; i < (items.Length - 1); i++)
                            {
                                if (!(Convert.ToInt64(items[i]) > 0))
                                {
                                    TagId = ""; // error SQL injection
                                    break;
                                }
                            }
                            TagId = Request.QueryString["TagId"];
                        }
                        else
                            TagId = Request.QueryString["TagId"];
                    }
                    else
                        TagId = "";

                    if (Request.QueryString["EmoId"] != null)
                    {
                        string emoarray = Request.QueryString["EmoId"];

                        if (emoarray.Split(',').Length > 0)
                        {
                            items = emoarray.Split(',');
                            for (int i = 0; i < (items.Length - 1); i++)
                            {
                                if (!(Convert.ToInt64(items[i]) > 0))
                                {
                                    EmoId = ""; // error SQL injection
                                    break;
                                }
                            }
                            EmoId = Request.QueryString["EmoId"];
                        }
                        else
                            EmoId = Request.QueryString["EmoId"];
                    }
                    else
                        EmoId = "";

                    if (EmoId.Length > 0)
                        EmoId = EmoId.Remove(EmoId.Length - 1, 1);
                    if (TagId.Length > 0)
                        TagId = TagId.Remove(TagId.Length - 1, 1);

                    Lstdtonewsfeed = _bllwebsite.GetWebsiteFeed(Convert.ToInt64(ViewState["UserID"]), Websiteid, TagId,
                        EmoId, 1, 10);
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void GetCookie()
        {
            _cookie = Request.Cookies["Tagged"];

            if (_cookie != null)
            {
                ViewState["UserID"] = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));
            }
            else
                Response.Redirect("~/Default.aspx");
        }

        [WebMethod]
        public static string voteTag(long premalinkId, long TagId, string vote)
        {
            try
            {
                HttpCookie _cookie;
                _cookie = HttpContext.Current.Request.Cookies["Tagged"];

                long result;

                if (_cookie != null && Int64.TryParse(UtilityClass.DecryptStringAES(_cookie["d"]), out result))
                {
                    if (result > 0)
                    {
                        var blltag = new BllTag();
                        var news = new DtoNewsFeed();

                        news.TagId = TagId;
                        news.UserId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));
                        news.Title = vote;
                        news.PremalinkId = premalinkId;
                        blltag.VoteContent(news);
                        return "1";
                    }
                    return null;
                }
                return null;
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

                HttpCookie _cookie;
                _cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (Rate == "plus")
                    returnvalue = bllemotion.IncrementEmotion(premalink, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"])));
                else if (Rate == "minus")
                    returnvalue = bllemotion.DecrementEmotion(premalink, EmotionId,
                        Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"])));
                return returnvalue;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }
    }
}