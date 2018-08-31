using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Tag
{
    public partial class FollowPagging : Page
    {
        private int PageNo;
        private string SearchText = "";
        protected long UserID;
        private BllTag blltag;
        private HttpCookie cookie;
        private DtoTag dtotag;
        private string flow = "search";
        protected List<DtoTag> lsttag;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["search"] != null)
                    SearchText = Request.QueryString["search"];
                else
                    SearchText = "";

                if (Request.QueryString["PageNo"] != null)
                    PageNo = Convert.ToInt32(Request.QueryString["PageNo"]);
                else
                    PageNo = 1;

                blltag = new BllTag();
                lsttag = new List<DtoTag>();

                if (Request.QueryString["flow"] != null)
                    flow = Request.QueryString["flow"];
                else
                    flow = "search";

                GetCookie();
                BindItemsList();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void BindItemsList()
        {
            blltag = new BllTag();
            lsttag = new List<DtoTag>();

            lsttag = blltag.GetAllTags(UserID, SearchText, PageNo, 10, flow);
        }

        private int GetCookie()
        {
            cookie = Request.Cookies["Tagged"];
            if (cookie != null)
            {
                UserID = Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"]));
            }
            return 0;
        }
    }
}