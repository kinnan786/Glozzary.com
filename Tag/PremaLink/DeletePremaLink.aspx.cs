using System;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.PremaLink
{
    public partial class DeletePremaLink : Page
    {
        private BllPremalink _bllpremalink;
        private DtoPremalink _dtopremalink;
        private long _premaLinkId;
        private long _tagId;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    _premaLinkId = Convert.ToInt32(Request.QueryString["PremaLinkID"]);
                    _tagId = Convert.ToInt32(Request.QueryString["TagID"]);

                    _dtopremalink = new DtoPremalink
                    {
                        PremalinkId = _premaLinkId,
                        TagId = _tagId
                    };

                    _bllpremalink = new BllPremalink();
                    _bllpremalink.DeactivateTagToWebsite(_dtopremalink);
                    Response.Redirect("PremaLink.aspx?PremalinkID=" + _premaLinkId);
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}