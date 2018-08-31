using BLL;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tag
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod(EnableSession = true)]
        public static string GetAllPages()
        {
            UtilityClass uc = new UtilityClass();
            DataTable table = uc.GetAllPages();

            JObject o = JObject.FromObject(new
            {
                Pages = new
                {
                    item =
                        from p in table.AsEnumerable()
                        select new
                        {
                            id = p.Field<int>(0),
                            type = p.Field<string>(1),
                        }
                }
            });

            return o.ToString();
        }

        [WebMethod()]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static void GetTagsbyPremalink(string Premalink, string callback)
        {
            BLLTag tag = new BLLTag();

            JObject o = JObject.FromObject(new
            {
                Tag = new
                {
                    Item =
                        from p in tag.GetTagsbyPremalink(Premalink)
                        select new
                        {
                            Id = p.TagId,
                            Vote = p.VoteType,
                            TagName = p.TagName
                        }
                }
            });

            StringBuilder sb = new StringBuilder();
            sb.Append(callback + "(");
            sb.Append(o.ToString()); // indentation is just for ease of reading while testing
            sb.Append(");");

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "application/json";
            HttpContext.Current.Response.AppendHeader("ContentType", "application/json");
            HttpContext.Current.Response.AppendHeader("Access-Control-Allow-Origin", "*");
            HttpContext.Current.Response.Write(sb.ToString());
            HttpContext.Current.Response.End();

        }

        [WebMethod(EnableSession = true)]
        public static string GetPremalinkEmotions(string Premalink)
        {
            BLLEmotions bllemotion = new BLLEmotions();

            JObject o = JObject.FromObject(new
            {
                Emotion = new
                {
                    Item =
                        from E in bllemotion.GetPremalinkEmotions(Premalink, 1)
                        select new
                        {
                            Id = E.Emotionid,
                            Vote = E.TotalCount,
                            Name = E.EmotionName,
                            UserEmotion = E.IsActive
                        }
                }
            });
            return o.ToString();
        }

        [WebMethod(EnableSession = true)]
        public static IEnumerable EmotionIntellisense(string PrefixText, string Premalink)
        {
            BLLEmotions bllemotion = new BLLEmotions();
            return bllemotion.EmotionIntellisense(Premalink, PrefixText);
        }

        [WebMethod(EnableSession = true)]
        public static int RateEmotion(string Premalink, int EmotionId, string Rate)
        {
            BLLEmotions bllemotion = new BLLEmotions();
            int returnvalue = 0;

            HttpCookie cookie;
            cookie = HttpContext.Current.Request.Cookies["Tagged"];

            if (Rate == "plus")
                returnvalue = bllemotion.IncrementEmotion(Premalink, EmotionId, Convert.ToInt64(cookie["userId"]));
            else if (Rate == "minus")
                returnvalue = bllemotion.DecrementEmotion(Premalink, EmotionId, Convert.ToInt64(cookie["userId"]));


            return returnvalue;
        }

        [WebMethod(EnableSession = true)]
        public static string Save(string tag, string emotion)
        {

            return "";
        }

    }
}