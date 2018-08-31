using System;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.PremaLink
{
    public partial class PremaLink : BaseClass
    {
        private BllPremalink _bllpremalink;
        private DtoPremalink _dtopremalink;
        private DtoTag _dtotag;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                if (!IsPostBack)
                {
                    ViewState["_premalinkId"] = 0;
                    ViewState["_websiteName"] = "";
                    ViewState["_link"] = "";
                }

                txttag.Attributes.Add("onblur", "blurfunction('tagsdfsspan','" + txttag.ClientID + "')");

                if (Request.QueryString["PremaLinkID"] != null)
                {
                    if (Convert.ToInt64(Request.QueryString["PremaLinkID"]) != 0)
                        ViewState["_premalinkId"] = Convert.ToInt64(Request.QueryString["PremaLinkID"]);
                }

                _bllpremalink = new BllPremalink();
                GridPremalinkTags.DataSource =
                    _bllpremalink.GetPremalinkTagsById(Convert.ToInt64(ViewState["_premalinkId"]));
                GridPremalinkTags.DataBind();

                _dtopremalink = new DtoPremalink();
                _dtopremalink = _bllpremalink.GetPremalinkById(Convert.ToInt64(ViewState["_premalinkId"]));
                hperlnk.Text = _dtopremalink.Title;
                hperlnk.NavigateUrl = "javascript:window.open('" + _dtopremalink.Link + "','_blank')";
                lbldescription.Text = _dtopremalink.Description;
                lbldate.Text = _dtopremalink.PublishedTime.ToShortDateString();
                imglnk.ImageUrl = _dtopremalink.Image;
                ViewState["_websiteName"] = _dtopremalink.SiteName;
                ViewState["_link"] = _dtopremalink.Link;
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
                    _dtotag = new DtoTag();
                    _dtotag = (DtoTag) e.Row.DataItem;

                    var lnkTagName = ((Label) e.Row.FindControl("lbltagname"));
                    lnkTagName.Text = _dtotag.TagName;

                    var linkDeletePremalinkTag = (HtmlImage) e.Row.FindControl("imgdelete");
                    linkDeletePremalinkTag.Attributes.Add("onclick",
                        "SetSelectedValue('" + Convert.ToInt64(ViewState["_premalinkId"]) + "','" + _dtotag.TagId + "')");
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
                _dtotag = new DtoTag
                {
                    Link = ViewState["_link"].ToString(),
                    WebsiteName = ViewState["_websiteName"].ToString(),
                    UserId = UserId,
                    TagName = txttag.Text
                };

                var blltag = new BllTag();
                blltag.AddTag(_dtotag);

                _bllpremalink = new BllPremalink();
                GridPremalinkTags.DataSource =
                    _bllpremalink.GetPremalinkTagsById(Convert.ToInt64(ViewState["_premalinkId"]));
                GridPremalinkTags.DataBind();

                txttag.Text = "";
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        [WebMethod]
        public static void DeleteTag(long premalinkid, long tagid)
        {
            try
            {
                var blltag = new BllTag();
                blltag.DeleteTag(premalinkid, tagid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}