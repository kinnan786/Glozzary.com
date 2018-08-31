using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.User
{
    public partial class Profile : BaseClass
    {
        protected DtoUser Dtouser;
        protected int EmoId = 0;
        protected string Emostring = "";
        protected string Flow;
        protected string Ima = "";
        protected string Imageurl = "";
        protected List<DtoNewsFeed> Lstdtonewsfeed;
        protected List<DtoEmotions> Lstemotions;
        protected List<DtoTag> Lsttag;
        protected long TagId = 0;
        protected string Tagstring = "";
        protected string Type;              
        private BllEmotions _bllemotion;
        private BllTag _blltag;
        private BllUser _blluser;           

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
               IsUser();

                if (!IsPostBack)
                {
                    ViewState["CurrentUserProfileID"] = 0;

                    if (Request.QueryString["Id"] != null)
                    {
                        ViewState["CurrentUserProfileID"] = Convert.ToInt64(Request.QueryString["Id"]);
                        if (Convert.ToInt64(ViewState["CurrentUserProfileID"]) == 0)
                            ViewState["CurrentUserProfileID"] = UserId;
                    }
                    else if (UserId > 0)
                        ViewState["CurrentUserProfileID"] = UserId;

                    Dtouser = new DtoUser();
                    _blluser = new BllUser();
                    Dtouser = _blluser.GetUserGeneralInfo(Convert.ToInt64(ViewState["CurrentUserProfileID"]));

                    if (Dtouser.ImageUrl != "")
                        Dtouser.ImageUrl = "/Uploads/" + Dtouser.ImageUrl + ".jpg";
                    else if (Dtouser.CoverPhoto != "")
                        Dtouser.CoverPhoto = "/Uploads/" + Dtouser.CoverPhoto + ".jpg";

                    if (Imageurl != null)
                    {
                    }
                    else
                    {
                        Ima = "../Images/no_photo.jpg";
                    }
                    _blltag = new BllTag();
                    _bllemotion = new BllEmotions();
                    Lsttag = _blltag.GetTagByUser(Convert.ToInt64(ViewState["CurrentUserProfileID"]));
                    Lstemotions = _bllemotion.spGetEmotionByUser(Convert.ToInt64(ViewState["CurrentUserProfileID"]));

                    if (Lsttag != null && Lsttag.Count > 0)
                    {
                        foreach (DtoTag t in Lsttag)
                            Tagstring += t.TagId + ",";

                        hdntagstring.Value = Tagstring;
                    }
                    if (Lstemotions != null && Lstemotions.Count > 0)
                    {
                        foreach (DtoEmotions E in Lstemotions)
                            Emostring += E.Emotionid + ",";

                        hdnemostring.Value = Emostring;
                    }
                }
                else
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
   
        protected void Datalisttag_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            try
            {
                if (e.Item.DataItem != null)
                {
                    var tag = (DtoTag) e.Item.DataItem;

                    var lnktagn = (LinkButton) e.Item.FindControl("lnktag");

                    lnktagn.Text = tag.TagName + "  ( " + tag.TagCount + " )";
                    lnktagn.PostBackUrl = "~/MainPage.aspx?flow=userprofile&TagID=" + tag.TagId + "&UserID=" + UserId;
                    lnktagn.CssClass = "Tagstyle";
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void datalstemotion_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            try
            {
                if (e.Item.DataItem != null)
                {
                    var emotion = (DtoEmotions) e.Item.DataItem;

                    var lnkemotionn = (LinkButton) e.Item.FindControl("lnkemotion");
                    lnkemotionn.Text = emotion.EmotionName + " ( " + emotion.TotalCount + " ) ";

                    lnkemotionn.PostBackUrl = "~/MainPage.aspx?flow=userprofile&EmoID=" + emotion.Emotionid + "&TagID=" +
                                              emotion.Emotionid + "&UserID=" + UserId;
                    lnkemotionn.CssClass = "Tagstyle";
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

            //else
            //    lblemotion.Visible = true;
        }

        //donot call these webservices outside this page
        //[WebMethod]
        //public static string GetUserTags()
        //{
        //    HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];

        //    BLLTag blltag = new BLLTag();
        //    return blltag.GetUserTags(Convert.ToInt64(ViewState["CurrentUserProfileID"]), Convert.ToInt64(cookie["UserID"]));
        //}

        //[WebMethod]
        //public static string GetUserEmotion()
        //{
        //    HttpCookie cookie = HttpContext.Current.Request.Cookies["Tagged"];
        //    BLLEmotions bllemo = new BLLEmotions();
        //    return bllemo.GetUserEmotion(CurrentUserProfileID, Convert.ToInt64(cookie["UserID"]));
        //}

        //[WebMethod]
        //public static int RateUserEmotion(int EmotionId, string Rate)
        //{
        //    BLLEmotions bllemotion = new BLLEmotions();
        //    int returnvalue = 0;

        //    HttpCookie cookie;
        //    cookie = HttpContext.Current.Request.Cookies["Tagged"];

        //    if (Rate == "plus")
        //        returnvalue = bllemotion.IncrementUserEmotion(EmotionId, CurrentUserProfileID, Convert.ToInt64(cookie["UserID"]));
        //    else if (Rate == "minus")
        //        returnvalue = bllemotion.DecrementUserEmotion(EmotionId, CurrentUserProfileID, Convert.ToInt64(cookie["UserID"]));

        //    return returnvalue;
        //}
    }
}