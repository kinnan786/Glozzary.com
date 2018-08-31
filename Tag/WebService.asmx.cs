using System;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Net;
using System.Web.Services;
using BLL;
using DTO;
using HtmlAgilityPack;

namespace Tag
{
    /// <summary>
    ///     Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
    // [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        [WebMethod]
        public string Getmetadata(string link)
        {
            System.Diagnostics.Debugger.Launch();
            var dtometa = new DtoMeta();

            var uri = new Uri(link);
            var request = (HttpWebRequest) WebRequest.Create(uri);
            var response = (HttpWebResponse) request.GetResponse();
            var reader = new StreamReader(response.GetResponseStream());
            var doc = new HtmlDocument();

            doc.Load(reader);

            HtmlNode node = doc.DocumentNode;

            //All metachars
            HtmlNodeCollection All = node.SelectNodes("//meta");
            string allmetachars = "";

            if (All != null)
            {
                foreach (HtmlNode item in All)
                    allmetachars += item.OuterHtml;
            }

            //General
            HtmlNodeCollection ogtitle = node.SelectNodes("//meta[@property='og:title']");
            HtmlNodeCollection ogurl = node.SelectNodes("//meta[@property='og:url']");
            HtmlNodeCollection ogsite_name = node.SelectNodes("//meta[@property='og:site_name']");
            HtmlNodeCollection ogdescription = node.SelectNodes("//meta[@property='og:description']");
            HtmlNodeCollection ogimage = node.SelectNodes("//meta[@property='og:image']");
            HtmlNodeCollection ogpublished_time = node.SelectNodes("//meta[@property='og:published_time']");
            HtmlNodeCollection ogkeywords = node.SelectNodes("//meta[@name='keywords']");
            HtmlNodeCollection ogemotion = node.SelectNodes("//meta[@property='og:emotion']");
            HtmlNodeCollection ogtype = node.SelectNodes("//meta[@property='og:type']");

            //Product
            HtmlNodeCollection ogpriceamount = node.SelectNodes("//meta[@property='og:price:amount']");
            HtmlNodeCollection ogpricecurrency = node.SelectNodes("//meta[@property='og:price:currency']");
            HtmlNodeCollection ogavailability = node.SelectNodes("//meta[@property='og:availability']");
            HtmlNodeCollection ograting = node.SelectNodes("//meta[@property='og:rating']");
            HtmlNodeCollection oggender = node.SelectNodes("//meta[@property='og:gender']");
            HtmlNodeCollection ogpricestartdate = node.SelectNodes("//meta[@property='og:price:start_date']");
            HtmlNodeCollection ogpriceenddate = node.SelectNodes("//meta[@property='og:price:end_date']");
            HtmlNodeCollection ogbrand = node.SelectNodes("//meta[@property='og:brand']");

            //Receipe
            HtmlNodeCollection ogingredients = node.SelectNodes("//meta[@property='og:ingredients']");
            HtmlNodeCollection ogavilabilitydestinations =
                node.SelectNodes("//meta[@property='og:avilability:destinations']");
            HtmlNodeCollection ogcooktime = node.SelectNodes("//meta[@property='og:cooktime']");
            HtmlNodeCollection ogpreptime = node.SelectNodes("//meta[@property='og:preptime']");
            HtmlNodeCollection ogtotaltime = node.SelectNodes("//meta[@property='og:totaltime']");
            HtmlNodeCollection ogrecipeyield = node.SelectNodes("//meta[@property='og:recipeyield']");
            HtmlNodeCollection ogaggregaterating = node.SelectNodes("//meta[@property='og:aggregaterating']");

            //movies
            HtmlNodeCollection ogduration = node.SelectNodes("//meta[@property='og:duration']");
            HtmlNodeCollection oggenre = node.SelectNodes("//meta[@property='og:genre']");
            HtmlNodeCollection ogactor = node.SelectNodes("//meta[@property='og:actor']");
            HtmlNodeCollection ogdirector = node.SelectNodes("//meta[@property='og:director']");
            HtmlNodeCollection ogcontentrating = node.SelectNodes("//meta[@property='og:contentrating']");

            //Article
            HtmlNodeCollection ogauthor = node.SelectNodes("//meta[@property='og:author']");
            HtmlNodeCollection ogsection = node.SelectNodes("//meta[@property='og:section']");

            //Place
            HtmlNodeCollection oglocationlatitude = node.SelectNodes("//meta[@property='og:location:latitude']");
            HtmlNodeCollection oglocationlongitude = node.SelectNodes("//meta[@property='og:location:longitude']");
            HtmlNodeCollection ogstreet_address = node.SelectNodes("//meta[@property='og:street_address']");
            HtmlNodeCollection oglocality = node.SelectNodes("//meta[@property='og:locality']");
            HtmlNodeCollection ogregion = node.SelectNodes("//meta[@property='og:region']");
            HtmlNodeCollection ogpostal_code = node.SelectNodes("//meta[@property='og:postal_code']");

            if (ogtitle != null)
            {
                if (ogtitle[0].Attributes["content"].Value == "")
                {
                    ogtitle = node.SelectNodes("//meta[@property='og:name']");

                    if (ogtitle != null)
                    {
                        if (ogtitle[0].Attributes["content"].Value == "")
                        {
                            ogtitle = node.SelectNodes("//title");
                            dtometa.Ogtitle = ogtitle[0].InnerText;
                        }
                        else
                            dtometa.Ogtitle = ogtitle[0].Attributes["content"].Value;
                    }
                }
                else
                    dtometa.Ogtitle = ogtitle[0].Attributes["content"].Value;
            }

            if (ogurl != null)
            {
                if (ogurl[0].Attributes["content"].Value != "")
                    dtometa.Ogurl = ogurl[0].Attributes["content"].Value;
                else
                    dtometa.Ogurl = link;
            }

            if (ogsite_name != null)
            {
                if (ogsite_name[0].Attributes["content"].Value != "")
                    dtometa.OgsiteName = ogsite_name[0].Attributes["content"].Value;
                else
                    dtometa.OgsiteName = uri.Host;
            }

            if (ogdescription != null)
            {
                if (ogdescription[0].Attributes["content"].Value != "")
                {
                    ogdescription = node.SelectNodes("//meta[@name='description']");
                    if (ogdescription != null)
                        dtometa.Ogdescription = ogdescription[0].Attributes["content"].Value;
                }
                else
                    dtometa.Ogdescription = ogdescription[0].Attributes["content"].Value;
            }

            if (ogimage != null)
            {
                if (ogimage[0].Attributes["content"].Value == "")
                {
                    ogimage = node.SelectNodes("//link [@rel='image_src']");
                    if (ogimage != null)
                        dtometa.Ogimage = ogimage[0].Attributes["href"].Value;
                }
                else
                    dtometa.Ogimage = ogimage[0].Attributes["content"].Value;
            }

            if (ogpublished_time != null)
                dtometa.OgpublishedTime = ogpublished_time[0].Attributes["content"].Value;

            if (ogkeywords != null)
            {
                if (ogkeywords[0].Attributes["content"].Value == "")
                {
                    ogkeywords = node.SelectNodes("//meta[@name='keywords']");
                    if (ogkeywords != null)
                    {
                        if (ogkeywords[0].Attributes["content"].Value == "")
                            ogkeywords = node.SelectNodes("//meta[@name='news_keywords']");

                        dtometa.Ogkeywords = ogkeywords[0].Attributes["content"].Value;
                    }
                }
                else
                    dtometa.Ogkeywords = ogkeywords[0].Attributes["content"].Value;
            }

            if (ogemotion != null)
                dtometa.Ogemotion = ogemotion[0].Attributes["content"].Value;
            if (ogtype != null)
            {
                if (ogtype[0].Attributes["content"].Value == "")
                    dtometa.Ogtype = "others";
                else
                    dtometa.Ogtype = ogtype[0].Attributes["content"].Value;
            }

            if (ogpriceamount != null)
                dtometa.Ogpriceamount = ogpriceamount[0].Attributes["content"].Value;
            if (ogpricecurrency != null)
                dtometa.Ogpricecurrency = ogpricecurrency[0].Attributes["content"].Value;
            if (ogavailability != null)
                dtometa.Ogavailability = ogavailability[0].Attributes["content"].Value;
            if (ograting != null)
                dtometa.Ograting = ograting[0].Attributes["content"].Value;
            if (oggender != null)
                dtometa.Oggender = oggender[0].Attributes["content"].Value;
            if (ogpricestartdate != null)
                dtometa.Ogpricestartdate = ogpricestartdate[0].Attributes["content"].Value;
            if (ogpriceenddate != null)
                dtometa.Ogpriceenddate = ogpriceenddate[0].Attributes["content"].Value;
            if (ogingredients != null)
                dtometa.Ogingredients = ogingredients[0].Attributes["content"].Value;
            if (ogavilabilitydestinations != null)
                dtometa.Ogavilabilitydestinations = ogavilabilitydestinations[0].Attributes["content"].Value;
            if (ogcooktime != null)
                dtometa.Ogcooktime = ogcooktime[0].Attributes["content"].Value;
            if (ogpreptime != null)
                dtometa.Ogpreptime = ogpreptime[0].Attributes["content"].Value;
            if (ogtotaltime != null)
                dtometa.Ogtotaltime = ogtotaltime[0].Attributes["content"].Value;
            if (ogrecipeyield != null)
                dtometa.Ogrecipeyield = ogrecipeyield[0].Attributes["content"].Value;
            if (ogaggregaterating != null)
                dtometa.Ogaggregaterating = ogaggregaterating[0].Attributes["content"].Value;
            if (ogduration != null)
                dtometa.Ogduration = ogduration[0].Attributes["content"].Value;
            if (oggenre != null)
                dtometa.Oggenre = oggenre[0].Attributes["content"].Value;
            if (ogactor != null)
                dtometa.Ogactor = ogactor[0].Attributes["content"].Value;
            if (ogdirector != null)
                dtometa.Ogdirector = ogdirector[0].Attributes["content"].Value;
            if (ogcontentrating != null)
                dtometa.Ogcontentrating = ogcontentrating[0].Attributes["content"].Value;
            if (ogauthor != null)
            {
                if (ogauthor[0].Attributes["content"].Value == "")
                {
                    ogauthor = node.SelectNodes("//meta[@name='author']");
                    if (ogauthor != null)
                        dtometa.Ogauthor = ogauthor[0].Attributes["content"].Value;
                }
                else
                    dtometa.Ogauthor = ogauthor[0].Attributes["content"].Value;
            }
            if (ogsection != null)
            {
                if (ogsection[0].Attributes["content"].Value == "")
                {
                    ogsection = node.SelectNodes("//meta[@property='article:section']");
                    if (ogsection != null)
                        dtometa.Ogsection = ogsection[0].Attributes["content"].Value;
                }
                else
                    dtometa.Ogsection = ogsection[0].Attributes["content"].Value;
            }

            if (oglocationlatitude != null)
                dtometa.Oglocationlatitude = oglocationlatitude[0].Attributes["content"].Value;
            if (oglocationlongitude != null)
                dtometa.Oglocationlongitude = oglocationlongitude[0].Attributes["content"].Value;
            if (ogstreet_address != null)
                dtometa.OgstreetAddress = ogstreet_address[0].Attributes["content"].Value;
            if (oglocality != null)
                dtometa.Oglocality = oglocality[0].Attributes["content"].Value;
            if (ogregion != null)
                dtometa.Ogregion = ogregion[0].Attributes["content"].Value;
            if (ogpostal_code != null)
                dtometa.OgpostalCode = ogpostal_code[0].Attributes["content"].Value;
            if (allmetachars != "")
                dtometa.AllMetachars = allmetachars;

            string[] Logo;
            string character = "";

            if (dtometa.OgsiteName != null)
            {
                if (dtometa.OgsiteName != "")
                {
                    character = dtometa.OgsiteName.Trim().Substring(0, 1);
                }
            }

            if (character == "")
            {
                if (dtometa.Ogurl != null)
                {
                    if (dtometa.Ogurl != "")
                    {
                        Logo = dtometa.Ogurl.Split('.');
                        if (Logo.Length == 2)
                            character = Logo[1].Trim().Substring(0, 1);
                        else
                            character = Logo[0].Trim().Substring(0, 1);
                    }
                }
            }
            if (character == "")
                character = "W";


            dtometa.WebsiteLogo = ConvertTextToImage(character.ToUpper(), "Arial", 30, Color.White, Color.Black, 50, 50);

            var bllpremalink = new BllPremalink();
            bllpremalink.AddPremalinkMetaChar(dtometa);

            if (dtometa.Ogimage.Length > 0)
                return null;
            return link;
        }


        public string ConvertTextToImage(string txt, string fontname, int fontsize, Color bgcolor, Color fcolor,
            int width, int Height)
        {
            var bmp = new Bitmap(width, Height);
            string imagename = Guid.NewGuid() + ".bmp";
            string Logourl = Server.MapPath("~/Images/WebsiteLogo/") + imagename;

            using (Graphics graphics = Graphics.FromImage(bmp))
            {
                var font = new Font(fontname, fontsize);
                graphics.FillRectangle(new SolidBrush(bgcolor), 0, 0, bmp.Width, bmp.Height);
                graphics.DrawString(txt, font, new SolidBrush(fcolor), 0, 0);
                graphics.Flush();
                font.Dispose();
                graphics.Dispose();
                using (var ms = new MemoryStream())
                {
                    bmp.Save(ms, ImageFormat.Bmp);
                    Image img = Image.FromStream(ms);
                    img.Save(Logourl);
                }
            }
            return imagename;
        }
    }
}