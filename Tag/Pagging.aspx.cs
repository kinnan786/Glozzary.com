using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag
{
    public partial class Pagging : Page
    {
        private BllTag _blltag;
        private BllUser _blluser;
        private BllWebsite _bllwebsite;
        private HttpCookie _cookie;
        private int _pageNumber = 1;
        private long _userId;
        protected int EmoId;
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        protected List<DtoTag> Lsttag;
        protected string Type;
        protected long Websiteid;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                GetCookie();

                if (!IsPostBack)
                {
                    ViewState["tagid"] = 0;

                    _bllwebsite = new BllWebsite();

                    _blltag = new BllTag();
                    _blluser = new BllUser();

                    if (Request.QueryString["PageNo"] != null)
                        _pageNumber = Convert.ToInt32(Request.QueryString["PageNo"]);

                    if (Request.QueryString["flow"] == "inlinecode")
                    {
                        if (Request.QueryString["Id"] != null)
                            ViewState["tagid"] = Convert.ToInt64(Request.QueryString["Id"]);
                        Lstdtonewsfeed = _blltag.GetTagNewsFeed(_userId, Convert.ToInt64(ViewState["tagid"]),
                            _pageNumber, 40);
                    }
                    else if (Request.QueryString["flow"] == "wall")
                        Lstdtonewsfeed = _blluser.GetUserNewsFeed(_userId, _pageNumber, 40);
                    else if (Request.QueryString["flow"] == "profile")
                    {
                        if (Request.QueryString["TagId"] != null && Request.QueryString["EmoId"] != null)
                        {
                            var tagstr = Request.QueryString["TagId"];
                            var emostr = Request.QueryString["EmoId"];
                            Lstdtonewsfeed = _blluser.GetUserTagFeed(_userId, tagstr, emostr, _pageNumber, 10);
                        }
                    }
                    else if (Request.QueryString["flow"] == "website")
                    {
                        if (Request.QueryString["TagId"] != null && Request.QueryString["EmoId"] != null &&
                            Request.QueryString["WebsiteId"] != null)
                        {
                            var tagstr = Request.QueryString["TagId"];
                            var emostr = Request.QueryString["EmoId"];
                            var websiteId = Convert.ToInt64(Request.QueryString["WebsiteId"]);
                            Lstdtonewsfeed = _bllwebsite.GetWebsiteFeed(_userId, websiteId, tagstr, emostr, _pageNumber,
                                10);
                        }
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
            _cookie = Request.Cookies["Tagged"];
            _userId = _cookie != null
                ? Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]))
                : 0;
        }
    }
}