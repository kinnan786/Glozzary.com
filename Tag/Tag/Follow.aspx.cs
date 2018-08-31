using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;
using Newtonsoft.Json.Linq;

namespace Tag.Tag
{
    public partial class Follow : BaseClass
    {
        private BllTag _blltag;
        private int _pageNo = 1;
        private DtoTag dtotag;
        protected string Flow;
        protected List<DtoTag> Lsttag;
        public string SearchText { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                SearchText = Request.QueryString["search"] ?? "";

                _pageNo = Request.QueryString["PageNo"] != null
                    ? Convert.ToInt32(Request.QueryString["PageNo"])
                    : 1;

                txtinputtagfollow.Attributes.Add("onblur",
                    "blurfunction('searchstagpan','" + txtinputtagfollow.ClientID + "')");

                _blltag = new BllTag();
                Lsttag = new List<DtoTag>();

                Flow = Request.QueryString["flow"] ?? "search";

                BindItemsList();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

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

        [WebMethod(EnableSession = true)]
        public static void UnfollowUserTagSubscription(string TagID)
        {
            try
            {
                var cookie = HttpContext.Current.Request.Cookies["Tagged"];
                if (cookie != null)
                {
                    var bllUserTagSubscription = new BllUserTagSubscription();
                    bllUserTagSubscription.DeleteUserTagSubscription(
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

        private void BindItemsList()
        {
            _blltag = new BllTag();
            Lsttag = new List<DtoTag>();

            Lsttag = _blltag.GetAllTags(GetUserId(), SearchText, _pageNo, 30, Flow);

            if (Lsttag != null)
            {
                if (Lsttag.Count > 0)
                {
                    var q = (from c in Lsttag
                        select c.TagCount).Max();

                    if (Flow != "myfollow")
                    {
                        lnkfollow.Attributes.Add("value", "My Follow ( " + q + " )");
                        lnkfollow.Attributes.CssStyle.Add("display", "");
                        lnkfollow.Attributes.Add("onclick", "window.location='Follow.aspx?PageNo=1&flow=myfollow'");
                        lnkback.Attributes.CssStyle.Add("display", "none");
                    }
                    else
                    {
                        lnkfollow.Attributes.CssStyle.Add("display", "none");
                        lnkback.Attributes.CssStyle.Add("display", "");
                        lnkback.Attributes.Add("onclick", "window.location='Follow.aspx?flow=search&PageNo=1'");
                    }
                }
                else
                {
                    if (Flow == "myfollow")
                    {
                        lnkfollow.Visible = false;
                        lnkback.Visible = true;
                    }
                    lblnodata.Visible = true;
                }
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            try
            {
                SearchText = txtinputtagfollow.Value;
                BindItemsList();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable SearchTag(string PrefixText)
        {
            try
            {
                var bllbtag = new BllTag();
                return bllbtag.SearchTag(PrefixText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        [WebMethod]
        public static string GetIntellisense(string searchtext)
        {
            try
            {
                var uc = new UtilityClass();
                var lstDtoWebsites = uc.GetIntellisense(searchtext);

                var o = JObject.FromObject(new
                {
                    d =
                        from p in lstDtoWebsites
                        select new
                        {
                            label = p.WebSiteName,
                            category = p.WebsiteType
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
    }
}