using System;
using System.Collections.Generic;
using System.Web;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Website
{
    public partial class Website : System.Web.UI.Page
    {
        protected DtoWebsite Dtowebsite;
        private BllWebsite _bllwebsite;
        private BllTag _blltag;
        private BllEmotions _bllemotions;
        protected List<DtoTag> Lsttag;
        protected List<DtoEmotions> Lstemotions;
        protected string Tagstring;
        protected string Emostring;
        private HttpCookie _cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                GetCookie();
                if (!IsPostBack)
                {
                    ViewState["websiteId"] = 0;
                    ViewState["UserID"] = 0;

                    _bllwebsite = new BllWebsite();
                    _blltag = new BllTag();
                    _bllemotions = new BllEmotions();

                    if (Request.QueryString["WebsiteId"] != null)
                    {
                        ViewState["websiteId"] = Convert.ToInt64(Request.QueryString["WebsiteId"]);

                        Dtowebsite = _bllwebsite.GetWebsiteById(Convert.ToInt64(ViewState["websiteId"]));
                        Lsttag = _blltag.GetTagByWebsite(Convert.ToInt64(ViewState["websiteId"]));
                        Lstemotions = _bllemotions.GetEmotionByWebsite(Convert.ToInt64(ViewState["websiteId"]));

                        if (Lsttag != null && Lsttag.Count > 0)
                        {
                            foreach (DtoTag t in Lsttag)
                                Tagstring += t.TagId + ",";

                            hdntagstring.Value = Tagstring;
                        }
                        if (Lstemotions != null && Lstemotions.Count > 0)
                        {
                            foreach (DtoEmotions E in Lstemotions)
                                Emostring += E.Emotionid + ",";

                            hdnemostring.Value = Emostring;
                        }
                    }
                }
                else
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }

        private void GetCookie()
        {
            _cookie = this.Request.Cookies["Tagged"];

            if (_cookie != null)
            {
                ViewState["UserID"] = Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(_cookie["d"]));
            }
            else
                Response.Redirect("~/Default.aspx");
        }
    }
}