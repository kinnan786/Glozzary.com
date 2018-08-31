using System;
using System.Collections.Generic;
using System.Web;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Website
{
    public partial class Pagging : System.Web.UI.Page
    {
        private BllWebsite _bllwebsite;
        private HttpCookie _cookie;
        private int _pageNumber = 1;
        private long _userId = 0;
        protected DtoWebsite Dtowebsite;
        protected List<DtoWebsite> Lstdtowebsite;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                GetCookie();

                if (!IsPostBack)
                {
                    ViewState["searchText"] = "";
                }

                _bllwebsite = new BllWebsite();

                if (Request.QueryString["PageNo"] != null)
                    _pageNumber = Convert.ToInt32(Request.QueryString["PageNo"]);

                if (Request.QueryString["searchterm"] != null)
                    ViewState["searchText"] = Request.QueryString["searchterm"].ToString();

                Lstdtowebsite = _bllwebsite.GetAllWebsite(_pageNumber, 24, ViewState["searchText"].ToString());
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
                _userId = Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(_cookie["d"]));
            }
            else
                _userId = 0;
        }
    }
}