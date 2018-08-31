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
    public partial class Explore : Page
    {
        private BllTag _blltag;
        private HttpCookie _cookie;
        private long _pageNo;
        private string _search;
        private long _userId;
        protected string Flow;
        protected List<DtoNewsFeed> Lstdtonewsfeed;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    GetCookie();
                    _blltag = new BllTag();
                    Lstdtonewsfeed = new List<DtoNewsFeed>();

                    if (Request.QueryString["flow"] != null && Request.QueryString["flow"].ToLower() == "search")
                    {
                        _search = Request.QueryString["search"];
                        _pageNo = Convert.ToInt32(Request.QueryString["PageNo"]);
                        Lstdtonewsfeed = _blltag.ExplorehNewsFeed(_userId, _search, _pageNo, 10);
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static void voteTag(long premalinkId, long TagId, string vote, int UserID)
        {
            try
            {
                var blltag = new BllTag();
                var news = new DtoNewsFeed
                {
                    TagId = TagId,
                    UserId = Convert.ToInt32(UserID),
                    Title = vote,
                    PremalinkId = premalinkId
                };

                news.UserId = UserID;
                blltag.VoteContent(news);
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

                var cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (Rate == "plus")
                {
                    if (cookie != null)
                        returnvalue = bllemotion.IncrementEmotion(premalink, EmotionId,
                            Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                }
                else if (Rate == "minus")
                    if (cookie != null)
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
            {
                _userId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));
            }
            return 0;
        }
    }
}