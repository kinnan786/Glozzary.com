using System;
using System.Web;
using System.Web.UI;
using Exceptionless;

namespace Tag
{
    public partial class Default : BaseClass
    {
        private HttpCookie _cookie;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    _cookie = Request.Cookies["Tagged"];

                    if (_cookie != null)
                        Response.Redirect("MainPage.aspx");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}