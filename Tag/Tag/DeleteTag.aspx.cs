using System;
using System.Collections.Generic;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Tag
{
    public partial class DeleteTag : BaseClass
    {
        private readonly BllTag _bllTag = new BllTag();
        private List<DtoTag> _lsttag = new List<DtoTag>();
        private string _tags = "";
        public string WebsiteName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                WebsiteName = Convert.ToString(Request.QueryString["WebsiteName"]);
                ViewState["Premalink"] = Convert.ToString(Request.QueryString["Premalink"]);

                if (!IsPostBack)
                {
                    if (!string.IsNullOrEmpty(WebsiteName) ||
                        (ViewState["Premalink"] != null && ViewState["Premalink"].ToString() != ""))
                    {
                        _lsttag = _bllTag.GetAllTag(WebsiteName, ViewState["Premalink"].ToString(), GetUserId());

                        if (_lsttag != null)
                        {
                            foreach (var tag in _lsttag)
                                _tags += "|" + tag.TagName + "," + tag.TagId;
                        }

                        hdntag.Value = _tags;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
        }
    }
}