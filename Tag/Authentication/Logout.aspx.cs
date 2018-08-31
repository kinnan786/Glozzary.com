using System;
using System.Web;
using Exceptionless;

namespace Tag.Authentication
{
    public partial class Logout : System.Web.UI.Page
    {
        private HttpCookie cookie;
        private long ProviderId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                DeleteCookie();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void DeleteCookie()
        {
            cookie = this.Request.Cookies["Tagged"];
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now;
                Response.SetCookie(cookie);
                Response.Redirect("../Default.aspx");
            }
        }
    }
}