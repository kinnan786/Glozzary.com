using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag
{
    public partial class RateableTag : Page
    {
        protected string Premalink = "";
        private BLLEmotionGroup _bllEmotionGroup;
        private HttpCookie _cookie;
        private List<DTOEmotionGroup> _lstEmotionGroup;
        private long _userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            Debugger.Launch();
            GetCookie();
            try
            {
                if (!IsPostBack)
                {
                    //if (Request.QueryString["url"] != null && Request.QueryString["Websitename"] != null &&
                    //    Request.QueryString["RateabletagId"] != null)
                    //{
                    //    if (Request.QueryString["url"] != "" && Request.QueryString["Websitename"] != "" &&
                    //        Request.QueryString["RateabletagId"] != "")
                    //    {
                    Premalink = "http://work4sale.tumblr.com/post/87523490471"; //Request.QueryString["url"];
                    ViewState["Websitename"] = "KinnanNawaz"; //Request.QueryString["Websitename"];
                    ViewState["RateabletagId"] = "6167e365-0b7b-4436-b46d-76b67b9775c6";
                        //Request.QueryString["RateabletagId"];

                    hdnrateabletag.Value = GetRateableemotionPlugin(ViewState["RateabletagId"].ToString(),
                        ViewState["Websitename"].ToString(), Premalink, _userId);
                    //}
                    //}
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private string GetRateableemotionPlugin(string rateabletagId, string websiteName, string premalink,
            long currentUserId)
        {
            try
            {
                _bllEmotionGroup = new BLLEmotionGroup();
                _lstEmotionGroup = new List<DTOEmotionGroup>();

                _lstEmotionGroup = _bllEmotionGroup.GetRateableemotionPlugin(rateabletagId, websiteName, premalink,
                    currentUserId);

                var tags = "";
                if (_lstEmotionGroup != null)
                {
                    foreach (DTOEmotionGroup tag in _lstEmotionGroup)
                        tags += "|" + tag.EmotionName + "," + tag.Id + "," + tag.WebsiteId + "," +
                                tag.EmotionGroupId;
                }

                return tags;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }


        private int GetCookie()
        {
            _cookie = Request.Cookies["Tagged"];
            if (_cookie != null)
                _userId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));

            return 0;
        }

        [WebMethod(EnableSession = true)]
        public static int VoteTag(string premalink, int tagid, string vote)
        {
            System.Diagnostics.Debugger.Launch();
            try
            {
                HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];

                if (cookie == null)
                    return -2;

                var bllemotion = new BllEmotions();
                int returnvalue = 0;

                switch (vote)
                {
                    case "UpVote":
                        returnvalue = bllemotion.IncrementEmotion(premalink, tagid,
                            Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                        break;
                    case "DownVote":
                        returnvalue = bllemotion.DecrementEmotion(premalink, tagid,
                            Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])));
                        break;
                }

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