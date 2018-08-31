using System;
using System.Web;

namespace Tag
{
    public partial class Developer : System.Web.UI.Page
    {
        protected long UserID;
        private HttpCookie cookie;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            GetCookie();
            if (UserID <= 0)
                MasterPageFile = "~/MasterPages/General.Master";
            else
                MasterPageFile = "~/MasterPages/ThreeLayerLayout.Master";
        }

        private int GetCookie()
        {
            cookie = Request.Cookies["Tagged"];

            if (cookie != null)
            {
                UserID = Convert.ToInt64(BLL.UtilityClass.DecryptStringAES(cookie["d"].ToString()));
            }
            return 0;
        }
    }
}