using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Tag
{
    public partial class TagPage : System.Web.UI.Page
    {
        public string WebsiteName = "";
        private static string Premalink = "";
        private BllTag bltag = new BllTag();
        private List<DtoTag> lsttag;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                WebsiteName = Convert.ToString(Request.QueryString["WebsiteName"]);
                Premalink = Convert.ToString(Request.QueryString["Premalink"]);

                if (!IsPostBack)
                {
                    if ((WebsiteName != null && WebsiteName != "") || (Premalink != null && Premalink != ""))
                    {
                        System.Uri websiteurl = new System.Uri(Premalink);

                        string tags = "";

                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "How");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Howtags"] = tags;
                        hdnHowtag.Value = tags;

                        tags = "";
                        lsttag = new List<DtoTag>();
                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "What");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Whattags"] = tags;
                        hdnWhattag.Value = tags;

                        tags = "";
                        lsttag = new List<DtoTag>();
                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "When");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Whentags"] = tags;
                        hdnWhentag.Value = tags;

                        tags = "";
                        lsttag = new List<DtoTag>();
                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "Where");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Wheretags"] = tags;
                        hdnWheretag.Value = tags;

                        tags = "";
                        lsttag = new List<DtoTag>();
                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "Why");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Whytags"] = tags;
                        hdnWhytag.Value = tags;

                        tags = "";
                        lsttag = new List<DtoTag>();
                        lsttag = bltag.GetTag(WebsiteName, Premalink, "http://" + websiteurl.Host, "Who");

                        if (lsttag != null)
                        {
                            foreach (DtoTag tag in lsttag)
                                tags += "|" + tag.TagName + "," + tag.TagId + ",0";
                        }
                        ViewState["Whotags"] = tags;
                        hdnWhotag.Value = tags;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable WhatTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.WhatTagIntellisense(prefixText, Premalink, websitename);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable WhereTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.WhereTagIntellisense(prefixText, Premalink, websitename);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable WhenTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.WhenTagIntellisense(prefixText, Premalink, websitename);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable WhyTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.WhyTagIntellisense(prefixText, Premalink, websitename);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable WhoTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.WhoTagIntellisense(prefixText, Premalink, websitename);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable HowTagIntellisense(string prefixText, string websitename)
        {
            BllTag bllbtag = new BllTag();
            return bllbtag.HowTagIntellisense(prefixText, Premalink, websitename);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            bltag = new BllTag();
            DtoTag t = new DtoTag();

            try
            {
                if (hdnWhattag.Value != null && hdnWhattag.Value.ToString() != "")
                {
                    string[] Whatoldtags = ViewState["Whattags"].ToString().Split('|');
                    string[] Whatnewtags = hdnWhattag.Value.Split('|');

                    for (int i = 1; i < Whatnewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Whatnewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Whatnewtags[i].Split(',')[1]);
                            t.TagName = Whatnewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "What";

                            if (Convert.ToInt32(Whatnewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }

                if (hdnWheretag.Value != null && hdnWheretag.Value.ToString() != "")
                {
                    string[] Whereoldtags = ViewState["Wheretags"].ToString().Split('|');
                    string[] Wherenewtags = hdnWheretag.Value.Split('|');

                    for (int i = 1; i < Wherenewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Wherenewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Wherenewtags[i].Split(',')[1]);
                            t.TagName = Wherenewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "Where";

                            if (Convert.ToInt64(Wherenewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }

                if (hdnWhentag.Value != null && hdnWhentag.Value.ToString() != "")
                {
                    string[] Whenoldtags = ViewState["Whentags"].ToString().Split('|');
                    string[] Whennewtags = hdnWhentag.Value.Split('|');

                    for (int i = 1; i < Whennewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Whennewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Whennewtags[i].Split(',')[1]);
                            t.TagName = Whennewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "When";

                            if (Convert.ToInt64(Whennewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }

                if (hdnWhotag.Value != null && hdnWhotag.Value.ToString() != "")
                {
                    string[] Whooldtags = ViewState["Whotags"].ToString().Split('|');
                    string[] Whonewtags = hdnWhotag.Value.Split('|');

                    for (int i = 1; i < Whonewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Whonewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Whonewtags[i].Split(',')[1]);
                            t.TagName = Whonewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "Who";

                            if (Convert.ToInt64(Whonewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }

                if (hdnHowtag.Value != null && hdnHowtag.Value.ToString() != "")
                {
                    string[] Howoldtags = ViewState["Howtags"].ToString().Split('|');
                    string[] Hownewtags = hdnHowtag.Value.Split('|');

                    for (int i = 1; i < Hownewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Hownewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Hownewtags[i].Split(',')[1]);
                            t.TagName = Hownewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "How";

                            if (Convert.ToInt64(Hownewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }

                if (hdnWhytag.Value != null && hdnWhytag.Value.ToString() != "")
                {
                    string[] Whyoldtags = ViewState["Whytags"].ToString().Split('|');
                    string[] Whynewtags = hdnWhytag.Value.Split('|');

                    for (int i = 1; i < Whynewtags.Length; i++)
                    {
                        if (Convert.ToInt64(Whynewtags[i].Split(',')[2]) == 1)
                        {
                            t = new DtoTag();
                            t.TagId = Convert.ToInt64(Whynewtags[i].Split(',')[1]);
                            t.TagName = Whynewtags[i].Split(',')[0];
                            t.Link = Premalink;
                            t.WebsiteName = WebsiteName;
                            t.TagType = "Why";

                            if (Convert.ToInt64(Whynewtags[i].Split(',')[1]) == 0)
                                bltag.AddTag(t);
                            else
                                bltag.AssociateTag(t);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static IEnumerable TagIntellisense(string PrefixText, string Premalink)
        {
            try
            {
                BllTag bllbtag = new BllTag();
                return bllbtag.TagIntellisense(PrefixText, Premalink);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}