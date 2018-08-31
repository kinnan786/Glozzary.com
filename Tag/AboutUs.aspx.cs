using System;
using System.Web;
using System.Web.UI;
using BLL;

namespace Tag
{
    public partial class AboutUs : Page
    {
        private HttpCookie _cookie;
        private long _userId;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            GetCookie();
            MasterPageFile = _userId <= 0
                ? "~/MasterPages/General.Master"
                : "~/MasterPages/ThreeLayerLayout.Master";
        }

        private int GetCookie()
        {
            _cookie = Request.Cookies["Tagged"];
            if (_cookie != null)
                _userId = Convert.ToInt64(UtilityClass.DecryptStringAES(_cookie["d"]));
            return 0;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}