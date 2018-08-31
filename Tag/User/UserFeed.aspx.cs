using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.User
{
    public partial class UserFeed : BaseClass
    {
        protected DtoUser Dtouser;
        protected string Imageurl = "";
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        protected List<DtoEmotions> Lstemotions;
        protected List<DtoTag> Lsttag;
        protected string Type;               
        private BllUser _blluser;            

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debugger.Launch();
                IsUser();
                if (!IsPostBack)
                {
                    ViewState["TagId"] = 0;
                    ViewState["EmoId"] = 0;

                    _blluser = new BllUser();       
                    Lstdtonewsfeed = new List<DtoNewsFeed>();
                    string[] items;

                    if (Request.QueryString["TagId"] != null)
                    {
                        var tagarray = Request.QueryString["TagId"];
                        if (tagarray.Split(',').Length > 0)
                        {
                            items = tagarray.Split(',');
                            for (int i = 0; i < (items.Length - 1); i++)
                            {
                                if (!(Convert.ToInt64(items[i]) > 0))
                                {
                                    ViewState["TagId"] = ""; // error SQL injection
                                    break;
                                }
                            }
                            ViewState["TagId"] = Request.QueryString["TagId"];
                        }
                        else
                            ViewState["TagId"] = Request.QueryString["TagId"];
                    }
                    else
                        ViewState["TagId"] = "";

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
                                    ViewState["EmoId"] = ""; // error SQL injection
                                    break;
                                }
                            }
                            ViewState["EmoId"] = Request.QueryString["EmoId"];
                        }
                        else
                            ViewState["EmoId"] = Request.QueryString["EmoId"];
                    }
                    else
                        ViewState["EmoId"] = "";

                    if (ViewState["EmoId"].ToString().Length > 0)
                        ViewState["EmoId"] =
                            ViewState["EmoId"].ToString().Remove(ViewState["EmoId"].ToString().Length - 1, 1);
                    if (ViewState["TagId"].ToString().Length > 0)
                        ViewState["TagId"] =
                            ViewState["TagId"].ToString().Remove(ViewState["TagId"].ToString().Length - 1, 1);

                    Lstdtonewsfeed = _blluser.GetUserTagFeed(UserId, ViewState["TagId"].ToString(),
                        ViewState["EmoId"].ToString(), 1, 10);
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

        //[WebMethod]
        //public static long voteUserTag(long TagId, string vote, int UserID)
        //{
        //    BLLTag blltag = new BLLTag();
        //    DTOTag tag = new DTOTag();

        //    tag.TagId = TagId;
        //    tag.UserId = Convert.ToInt32(UserID);
        //    tag.VoteType = vote;
        //    tag.TagCount = CurrentUserProfileID;
        //    return blltag.VoteUserTag(tag);
        //}

        [WebMethod(EnableSession = true)]
        public static int RateEmotion(string premalink, int EmotionId, string Rate)
        {
            try
            {
                var bllemotion = new BllEmotions();
                int returnvalue = 0;

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
    }
}