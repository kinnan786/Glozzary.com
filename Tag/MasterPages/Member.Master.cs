using System;
using System.Web;
using System.Web.UI;
using BLL;
using Exceptionless;

namespace Tag.MasterPages
{
    public partial class Member : MasterPage
    {
        private HttpCookie _cookie;
        private long _userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                    IsRegisterUser();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void IsRegisterUser()
        {
            try
            {
                _cookie = Request.Cookies["Tagged"];
                if (_cookie != null)
                {
                    if (_cookie["UserID"] != null)
                        _userId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["UserID"]));
                    var bllwebsite = new BllWebsite();
                    var isWebsite = bllwebsite.GetUserWebsite(_userId);

                    if (isWebsite != null)
                        Response.Redirect("~/WebsiteAdmin/WebsiteGeneralSetting.aspx");
                }
                else
                    Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
        }
    }
}