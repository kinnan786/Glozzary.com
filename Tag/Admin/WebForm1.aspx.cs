using System;

namespace Tag.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            img1.Src = Request.QueryString["img"];
        }
    }
}