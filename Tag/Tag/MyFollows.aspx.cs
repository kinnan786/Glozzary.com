using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Tag
{
    public partial class MyFollows : BaseClass
    {
        private BllUserTagSubscription _bblUserTagSubscription;
        private DtoUserTagSubscription _dtoUserTagSubscription;
        private List<DtoUserTagSubscription> _lstUserTagSubscription;
        private Int64 _userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                _userId = GetUserId();
                _bblUserTagSubscription = new BllUserTagSubscription();
                _lstUserTagSubscription = new List<DtoUserTagSubscription>();
                _lstUserTagSubscription = _bblUserTagSubscription.GetUserTagSubscription(_userId, "");
                DatalistLinkTag.DataSource = _lstUserTagSubscription;
                DatalistLinkTag.DataBind();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void DatalistLinkTag_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            try
            {
                var lteral = (Literal) e.Item.FindControl("ltrltags");
                var ltrlbtn = (Literal) e.Item.FindControl("ltrlbtn");

                var btnBtmTagFollow = (HtmlInputButton) e.Item.FindControl("BtnTagUnFollow");
                _dtoUserTagSubscription = new DtoUserTagSubscription();
                _dtoUserTagSubscription = (DtoUserTagSubscription) e.Item.DataItem;

                ltrlbtn.Text += "<input type='button' id='BtnTagUnFollow" + _dtoUserTagSubscription.TagId +
                                "' runat='server' style=' width:100px; ' onclick='DeleteUserTagSubscription(&quot;" +
                                _dtoUserTagSubscription.TagId + "&quot;)'  class='simplebutton' value='UnFollow Tag' />";
                lteral.Text += "<a id='" + _dtoUserTagSubscription.TagName + "-" + _dtoUserTagSubscription.TagId +
                               "' class='post-tag'  >" + _dtoUserTagSubscription.TagName + "</a>";
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod(EnableSession = true)]
        public static void DeleteUserTagSubscription(string TagID)
        {
            try
            {
                var cookie = HttpContext.Current.Request.Cookies["Tagged"];
                if (cookie != null)
                {
                    var bllUserTagSubscription = new BllUserTagSubscription();
                    bllUserTagSubscription.DeleteUserTagSubscription(
                        Convert.ToInt64(UtilityClass.DecryptStringAES(cookie["d"])), Convert.ToInt64(TagID));
                }
                else
                    HttpContext.Current.Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}