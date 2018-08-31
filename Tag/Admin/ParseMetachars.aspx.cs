using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;
using HtmlAgilityPack;

namespace Tag.Admin
{
    public partial class ParseMetachars : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnstart_Click(object sender, EventArgs e)
        {
            try
            {
                //System.Diagnostics.Debugger.Launch();
                var bllpremalink = new BllPremalink();
                var lstpremalink = new List<DtoPremalink>();
                lstpremalink = bllpremalink.GetUnParsedPremalik();
                var serv = new WebService();

                int x = 0, y = 0, index = 0;
                string sr = "";
                var arr = new string[11];

                if (lstpremalink != null)
                {
                    foreach (DtoPremalink item in lstpremalink)
                    {
                        arr[index] = serv.Getmetadata(item.Link);
                        index += 1;
                    }

                    if (arr.Where(m => m != null).Count() > 0)
                    {
                        foreach (string item in arr.Where(m => m != null))
                        {
                            var uri = new Uri(item);
                            var request = (HttpWebRequest) WebRequest.Create(uri);
                            var response = (HttpWebResponse) request.GetResponse();
                            var reader = new StreamReader(response.GetResponseStream());
                            var doc = new HtmlDocument();

                            doc.Load(reader);

                            HtmlNodeCollection title = doc.DocumentNode.SelectNodes("//img");

                            foreach (HtmlNode item1 in title)
                            {
                                if (item1.HasAttributes)
                                {
                                    foreach (HtmlAttribute attr in item1.Attributes)
                                    {
                                        if (attr.Value.ToLower().StartsWith("http://"))
                                        {
                                            sr += " <br/><img name='img" + x + "_hdn" + y + "' src= " + attr.Value +
                                                  " alt='No Image' /><br/>";
                                            sr += "<input id='hdn" + y + "' type='hidden' value='" + item + "' />";
                                            ltrl.Text += sr;
                                            y += 1;
                                        }
                                    }
                                }
                            }
                            x += 1;
                        }
                        ltrl.Text += "<input id='total' type='hidden' value='" + x + "' />";
                        Page.ClientScript.RegisterStartupScript(GetType(), "parse",
                            "<script type='text/javascript'>Parse();</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static void done(object values)
        {
            try
            {
                String[] a = values.ToString().Replace('[', ' ').Replace(']', ' ').Split('|')[1].Split(',');

                var pre = new DtoPremalink();
                var bllp = new BllPremalink();
                pre.Link = a[0];
                pre.Image = a[1];

                bllp.AddPremalinkimages(pre);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}