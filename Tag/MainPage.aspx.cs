using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;

namespace Tag
{
    public partial class MainPage : BaseClass
    {
        private BllTag _blltag;
        private BllUser _blluser;
        private long _tagId;
        protected string Flow;
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        private long UserID;
        protected string Webimageurl = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debugger.Launch();
                IsUser();
                UserID = GetUserId();
                _blluser = new BllUser();
                _blltag = new BllTag();
                Lstdtonewsfeed = new List<DtoNewsFeed>();

                if (Request.QueryString["flow"] != null)
                {
                    Flow = Request.QueryString["flow"];
                    if (Request.QueryString["flow"].ToLower() == "userprofile")
                    {
                        if (Request.QueryString["TagID"] != null && Request.QueryString["EmoID"] != null)
                        {
                            _tagId = Convert.ToInt64(Request.QueryString["EmoID"]);
                            Lstdtonewsfeed = _blltag.GetEmoNewsFeed(UserID, Convert.ToInt32(_tagId), 1, 10);
                        }
                        else if (Request.QueryString["TagID"] != null)
                        {
                            _tagId = Convert.ToInt64(Request.QueryString["TagID"]);
                            Lstdtonewsfeed = _blltag.GetTagNewsFeed(UserID, _tagId, 1, 10);
                        }
                    }
                    else if (Request.QueryString["flow"].ToLower() == "explore")
                    {
                        _tagId = Convert.ToInt64(Request.QueryString["TagID"]);
                        Lstdtonewsfeed = _blltag.GetTagNewsFeed(UserID, _tagId, 1, 10);
                    }
                    else if (Request.QueryString["flow"].ToLower() == "search")
                    {
                        _tagId = Convert.ToInt64(Request.QueryString["search"]);
                        Lstdtonewsfeed = _blltag.GetTagNewsFeed(UserID, _tagId, 1, 10);
                    }
                }
                else
                {
                    Lstdtonewsfeed = _blluser.GetUserNewsFeed(UserID, 1, 40);
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static string voteTag(long premalinkId, long TagId, string vote)
        {
            try
            {
                var cookie = HttpContext.Current.Request.Cookies["Tagged"];

                long result;

                if (cookie != null && Int64.TryParse(UtilityClass.DecryptStringAES(cookie["d"]), out result))
                {
                    if (result > 0)
                    {
                        var blltag = new BllTag();
                        var news = new DtoNewsFeed
                        {
                            TagId = TagId,
                            UserId = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])),
                            Title = vote,
                            PremalinkId = premalinkId
                        };

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
                var returnvalue = 0;

                var cookie = HttpContext.Current.Request.Cookies["Tagged"];

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
    }
}