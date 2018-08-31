using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using BLL;
using DTO;

namespace Tag
{
    /// <summary>
    ///     Summary description for CommonWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class CommonWebService : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable GetIntellisense(string searchtext)
        {
            System.Diagnostics.Debugger.Launch();

            var uc = new UtilityClass();

            List<DtoWebsite> lstdtoWebsites = uc.GetIntellisense(searchtext);


            if (lstdtoWebsites != null)
            {
                IEnumerable query = from c in lstdtoWebsites
                    select new
                    {
                        Value = c.WebsiteId.ToString(),
                        Name = c.WebSiteName
                    };
                return query;
            }

            return null;
        }
    }
}