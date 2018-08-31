using System;
using System.Collections;
using System.Web.Services;
using System.Web.UI.WebControls;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.WebsiteAdmin
{
    public partial class RateableTag : BaseClass
    {
        private BLLEmotionGroup _bllEmotion;
        private BllWebsite _bllWebsite;
        private DTOEmotionGroup _dtoEmotions;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                if (!IsPostBack)
                {
                    _bllEmotion = new BLLEmotionGroup();
                    _bllWebsite = new BllWebsite();
                    grdtags.DataSource = _bllEmotion.GetRateableEmotion(_bllWebsite.GetUserWebsite(UserId)[0].WebsiteId);
                    grdtags.DataBind();
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("EditRateableTag.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void GridPremalinkTags_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    _dtoEmotions = new DTOEmotionGroup();
                    _dtoEmotions = (DTOEmotionGroup) e.Row.DataItem;

                    var lnkTagName = ((Label) e.Row.FindControl("lbltagname"));
                    lnkTagName.Text = _dtoEmotions.GroupName;

                    var action = (HyperLink) e.Row.FindControl("lnkedit");
                    action.NavigateUrl = "EditRateableTag.aspx?id=" + _dtoEmotions.Id;
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static IEnumerable TagIntellisense(string prefixText)
        {
            try
            {
                var bllbtag = new BllTag();
                return bllbtag.SearchTag(prefixText);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}