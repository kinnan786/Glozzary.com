using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Tag
{
    public partial class TagViewer : BaseClass
    {
        private BllTag _blltag;
        private DtoTag _dtotag;
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        protected List<DtoTag> Lsttag;
        protected long Websiteid;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                if (!IsPostBack)
                {
                    var uId = GetUserId();
                    ViewState["tagid"] = 0;
                    //cookie = this.Request.Cookies["Tagged"];

                    _dtotag = new DtoTag();
                    _blltag = new BllTag();
                    //BtnTagFollow.Attributes.Add("onclick", "AddUserTagSubscription('" + tagid.ToString() + "')");

                    if (Request.QueryString["flow"] != null)
                    {
                        if (Request.QueryString["flow"].ToLower() == "explore")
                        {
                            ViewState["tagid"] = Convert.ToInt64(Request.QueryString["Id"]);
                            Lstdtonewsfeed = _blltag.GetTagNewsFeed(uId, Convert.ToInt64(ViewState["tagid"]), 1, 10);
                            _dtotag = _blltag.GetTagById(Convert.ToInt64(ViewState["tagid"]));
                            lbltagname.Text = _dtotag.TagName;
                        }
                        else if (Request.QueryString["flow"].ToLower() == "inlinecode")
                        {
                            ViewState["tagid"] = Convert.ToInt64(Request.QueryString["Id"]);
                            Websiteid = Convert.ToInt64(Request.QueryString["WebsiteId"]);
                            Lstdtonewsfeed = _blltag.GetTagNewsFeed(uId, Convert.ToInt64(ViewState["tagid"]), 1, 10);
                            _dtotag = _blltag.GetTagById(Convert.ToInt64(ViewState["tagid"]));
                            lbltagname.Text = _dtotag.TagName;
                            Lsttag = _blltag.GetWebsiteTags(Websiteid);
                        }
                    }
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

        //[WebMethod]
        //public static long voteTagged(long TagId, string vote, int UserID)
        //{
        //    BLLTag blltag = new BLLTag();
        //    DTOTag tag = new DTOTag();

        //    tag.TagId = TagId;
        //    tag.UserId = Convert.ToInt32(UserID);
        //    tag.VoteType = vote;
        //   // tag.TagCount = Convert.ToInt64(ViewState["tagid"]); // tagged on
        //    return blltag.VoteTagged(tag);
        //}

        //donot call these webservices outside this page
        //[WebMethod]
        //public static string GetTagged()
        //{
        //    BLLTag blltag = new BLLTag();
        //    //return blltag.GetTagged(tagid);
        //    return null;
        //}

        //[WebMethod]
        //public static string GetEmotion()
        //{
        //    HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
        //    BLLEmotions bllemo = new BLLEmotions();
        //    //return bllemo.GetTaggedEmotion(tagid, Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(cookie["d"])));
        //return null;
        //}

        //[WebMethod]
        //public static int RateTaggedEmotion(int EmotionId, string Rate)
        //{
        //    BLLEmotions bllemotion = new BLLEmotions();
        //    int returnvalue = 0;

        //    HttpCookie cookie;
        //    cookie = HttpContext.Current.Request.Cookies["Tagged"];

        //    //if (Rate == "plus")
        //    //    returnvalue = bllemotion.IncrementTaggedEmotion(tagid, EmotionId, Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(cookie["d"])));
        //    //else if (Rate == "minus")
        //    //    returnvalue = bllemotion.DecrementTaggedEmotion(tagid, EmotionId, Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(cookie["d"])));

        //    return returnvalue;
        //}

        [WebMethod(EnableSession = true)]
        public static void AddUserTagSubscription(string TagID)
        {
            try
            {
                var cookie = HttpContext.Current.Request.Cookies["Tagged"];
                if (cookie != null)
                {
                    var bllUserTagSubscription = new BllUserTagSubscription();
                    bllUserTagSubscription.AddUserTagSubscription(
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])), Convert.ToInt64(TagID));
                }
                else
                    HttpContext.Current.Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}