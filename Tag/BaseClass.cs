using System;
using System.Web;
using System.Web.UI;
using BLL;

namespace Tag
{
    public class BaseClass : Page
    {
        protected HttpCookie Cookie;
        protected long UserId;

        protected void IsUser()
        {
            Cookie = Request.Cookies["Tagged"];
            if (Cookie != null)
            {
                if (Cookie["d"] != null)
                    UserId = long.Parse(UtilityClass.DecryptStringAES(Cookie["d"]));

                var bllwebsite = new BllWebsite();
                var isWebsite = bllwebsite.GetUserWebsite(UserId);

                if (isWebsite != null)
                    Response.Redirect("~/WebsiteAdmin/WebsiteGeneralSetting.aspx");
            }
            else
                Response.Redirect("Default.aspx");
        }

        protected void IsWebSite()
        {
            Cookie = Request.Cookies["Tagged"];

            if (Cookie != null)
            {
                UserId = long.Parse(UtilityClass.DecryptStringAES(Cookie["d"]));

                var bllwebsite = new BllWebsite();
                var isWebsite = bllwebsite.GetUserWebsite(UserId);

                if (isWebsite == null)
                    Response.Redirect("~/MainPage.aspx");
            }
            else
                Response.Redirect("~/Default.aspx");
        }

        protected long GetUserId()
        {
            Cookie = Request.Cookies["Tagged"];

            if (Cookie != null)
                return long.Parse(UtilityClass.DecryptStringAES(Cookie["d"]));

            Response.Redirect("~/Default.aspx");
            return 0;
        }

        protected void ExpireCookie_Redirect()
        {
            Cookie = Request.Cookies["Tagged"];
            if (Cookie != null)
            {
                Cookie.Expires = DateTime.Now;
                Response.SetCookie(Cookie);
                Response.Redirect("Default.aspx");
            }
        }
    }
}