using BLL;
using Facebook;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;

namespace Tag
{
    public partial class FacebookConnect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckAuthorization();
        }

        private void CheckAuthorization()
        {
            //System.Diagnostics.Debugger.Launch();
            int userId = 0;

            try
            {
                string app_id = ConfigurationManager.AppSettings["appId"].ToString();
                string app_secret = ConfigurationManager.AppSettings["appSecret"].ToString();
                string scope = ConfigurationManager.AppSettings["scope"].ToString();

                if (Request["code"] == null)
                {
                    Response.Redirect(string.Format(
                        "https://graph.facebook.com/oauth/authorize?client_id={0}&redirect_uri={1}&scope={2}",
                        app_id, "http://www.glozzary.com", "basic_info,email"), false);
                }
                else
                {
                    Dictionary<string, string> tokens = new Dictionary<string, string>();

                    string url = string.Format("https://graph.facebook.com/oauth/access_token?client_id={0}&redirect_uri={1}&scope={2}&code={3}&client_secret={4}",
                        app_id, Request.Url.AbsoluteUri, scope, Request["code"].ToString(), app_secret);

                    HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;

                    using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                    {
                        StreamReader reader = new StreamReader(response.GetResponseStream());

                        string vals = reader.ReadToEnd();

                        foreach (string token in vals.Split('&'))
                        {
                            tokens.Add(token.Substring(0, token.IndexOf("=")),
                                token.Substring(token.IndexOf("=") + 1, token.Length - token.IndexOf("=") - 1));
                        }
                    }

                    string access_token = tokens["access_token"];
                    var client = new FacebookClient(access_token);
                    var obj = client.Get("/me");
                    string json = "{\"Items\":[" + obj + "]}";

                    BllUser blluser = new BllUser();

                    dynamic data = System.Web.Helpers.Json.Decode(json);

                    var result = from i in (IEnumerable<dynamic>)data.Items
                                 select new
                                 {
                                     i.email,
                                     i.first_name,
                                     i.gender,
                                     i.last_name
                                 };

                    if (result != null)
                    {
                        if (result.Count() > 0 && result.First().first_name != "" && result.First().last_name != "" && result.First().last_name != "")
                        {
                            //userId = Convert.ToInt32(blluser.FaceBookAuthetication(
                            //            Convert.ToString(result.First().email),
                            //            Convert.ToString(result.First().first_name),
                            //            Convert.ToString(result.First().last_name)));
                        }
                    }
                }
            }
            catch (Exception error)
            {
                throw error;
            }

            string newurl = string.Format("http://www.glozzary.com/Default.aspx?flow={0}&UserID={1}",
                "FacebookConnect", userId);
            Response.Redirect(newurl);
        }
    }
}