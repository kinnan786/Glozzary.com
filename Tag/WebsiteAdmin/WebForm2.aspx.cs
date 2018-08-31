using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Exceptionless;

namespace Tag.WebsiteAdmin
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static IEnumerable TagIntellisense(string prefixText)
        {
            System.Diagnostics.Debugger.Launch();
            try
            {
                //var bllbtag = new BllTag();
                //return bllbtag.TagIntellisense(prefixText);
                return null;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}