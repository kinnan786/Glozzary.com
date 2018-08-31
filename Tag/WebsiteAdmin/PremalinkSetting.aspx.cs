using System;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.WebsiteAdmin
{
    public partial class PremalinkSetting : BaseClass
    {
        private BllPremalink _bllPremalink;
        private BllTag _bllTag;
        private DtoPremalink _dtoPremalink;
        private DtoTag _dtotag;
        private long _premalinkId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                ViewState["_premalinkId"] = 0;
                if (!IsPostBack)
                {
                    if (Request.QueryString["ID"] != null)
                        _premalinkId = Convert.ToInt64(Request.QueryString["ID"]);

                    ViewState["_premalinkId"] = _premalinkId;

                    _bllPremalink = new BllPremalink();

                    _dtoPremalink = _bllPremalink.GetPremalinkById(_premalinkId);
                    imgPremalink.ImageUrl = _dtoPremalink.Image;
                    lblPremalink.Text = _dtoPremalink.Title;
                    lblDescription.Text = _dtoPremalink.Description;
                    linkPremalink.Text = _dtoPremalink.Link;

                    ViewState["_link"] = _dtoPremalink.Link;

                    grdtags.DataSource = _bllPremalink.GetPremalinkTagsById(_premalinkId);
                    grdtags.DataBind();


                    //     grdemotion.DataSource = _bllEmotions.GetPremalinkEmotionsById(_premalinkId);
                    //     grdemotion.DataBind();
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
                    UserId = UserId,
                    TagName = txttag.Text
                };

                var blltag = new BllTag();
                blltag.AddTag(_dtotag);

                _bllPremalink = new BllPremalink();

                grdtags.DataSource = _bllPremalink.GetPremalinkTagsById(Convert.ToInt64(Request.QueryString["ID"]));
                grdtags.DataBind();

                txttag.Text = "";
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

        [WebMethod]
        public static void DeleteEmotion(long premalinkid, long tagid)
        {
            try
            {
                //var blltag = new BllEmotions();
                //blltag.de(premalinkid, tagid);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}