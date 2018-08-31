using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Website
{
    public partial class AllWebsite : System.Web.UI.Page
    {
        private HttpCookie _cookie;
        protected long UserId;
        protected List<DtoWebsite> Lstdtowebsite;
        private BllWebsite _bllwebsite;
        private DtoWebsite dtowebsite;

        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {

                //System.Diagnostics.Debugger.Launch();
                GetCookie();
                BindItemsList();

                if (Request.QueryString["searchterm"] != null)
                    ViewState["SearchTerm"] = Request.QueryString["searchterm"].ToString();
                else
                    ViewState["SearchTerm"] = "";
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }

        private void BindItemsList()
        {
            
            _bllwebsite = new BllWebsite();
            Lstdtowebsite = new List<DtoWebsite>();

            if(ViewState["SearchTerm"] == null)
                ViewState["SearchTerm"] = "";

            Lstdtowebsite = _bllwebsite.GetAllWebsite(1, 24, ViewState["SearchTerm"].ToString());
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            try
            {

                GetCookie();
                BindItemsList();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }

        private int GetCookie()
        {
            _cookie = this.Request.Cookies["Tagged"];
            if (_cookie != null)
                UserId = Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(_cookie["d"]));
            return 0;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable SearchWebsite(string PrefixText)
        {
            try
            {

                BllWebsite bllwebsite = new BllWebsite();
                return bllwebsite.SearchWebsite(PrefixText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}