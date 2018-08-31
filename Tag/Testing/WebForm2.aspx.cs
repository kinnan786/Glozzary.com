using System;
using System.IO;
using System.Net;

namespace Tag.Testing
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string query = "http://www.google.com/recaptcha/api/verify?privatekey=6Lep5PkSAAAAAMRU5ex8WmMMHy_9iUzof9VXZ8T2&remoteip=192.168.1.6&challenge=" + Request.Form["recaptcha_challenge_field"].ToString() + "&response=" + Request.Form["recaptcha_response_field"].ToString();

         
                Stream objStream;
                StreamReader objSR;
                System.Text.Encoding encode = System.Text.Encoding.GetEncoding("utf-8");
                HttpWebResponse getresponse = null;
                

                HttpWebRequest wrquest = (HttpWebRequest)WebRequest.Create(query);
                getresponse = (HttpWebResponse)wrquest.GetResponse();
                objStream = getresponse.GetResponseStream();
                objSR = new StreamReader(objStream, encode, true);
                string strResponse = objSR.ReadToEnd();
                
                Response.Write(strResponse);
            }
        }
    }
}