using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.WebsiteAdmin
{
    public partial class EditRateableTag : BaseClass
    {
        private BLLEmotionGroup _bllEmotionGroup;
        private DTOEmotionGroup _dtoEmotionGroup;
        private List<DTOEmotionGroup> _lstemotionGroup;

        protected void Page_Load(object sender, EventArgs e)
        {
            IsWebSite();
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    _lstemotionGroup = new List<DTOEmotionGroup>();
                    _bllEmotionGroup = new BLLEmotionGroup();
                    _lstemotionGroup =
                        _bllEmotionGroup.GetRateableEmotionByEmotionGroupId(Convert.ToInt64(Request.QueryString["id"]));

                    if (_lstemotionGroup != null && _lstemotionGroup.Count > 0)
                    {
                        txtRateGrouName.Text = _lstemotionGroup[0].GroupName;

                        foreach (var tag in _lstemotionGroup)
                            hdntag.Value += "|" + tag.EmotionName + "," + tag.Id + ",0,1";
                    }
                }
            }
        }

        protected void btnadd_Click(object sender, EventArgs e)
        {
            try
            {
                long eid = 0;

                if (Request.QueryString["id"] != null)
                    eid = Convert.ToInt64(Request.QueryString["id"]);

                _bllEmotionGroup = new BLLEmotionGroup();
                _bllEmotionGroup.AddRateableEmotion(txtRateGrouName.Text, UserId, eid, hdntag.Value);
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void btnGenerateScript_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null && Convert.ToInt64(Request.QueryString["id"]) != 0)
            {
                var groupid = Convert.ToInt64(Request.QueryString["id"]);
                _bllEmotionGroup = new BLLEmotionGroup();
                _dtoEmotionGroup = new DTOEmotionGroup();
                _dtoEmotionGroup = _bllEmotionGroup.GetGenerateScript(groupid, UserId);

                if (_dtoEmotionGroup != null)
                {
                    var script =
                        "<div id='taghead'></div><script type ='text/javascript' language='javascript'>" +
                        "var Websitename_shortname = '" + _dtoEmotionGroup.EmotionName + "';var RateabletagId = '" +
                        _dtoEmotionGroup.UniqueId + "'</script>" +
                        "<script src='http://www.glozzary.com/Script/NewJScript.js' type='text/javascript'></script>";
                    txtscript.InnerText = script;
                }
            }
        }

        [WebMethod]
        public static IEnumerable RateableEmotionIntellisense(string prefixText)
        {
            try
            {
                var daltag = new BllEmotions();
                IEnumerable query = "";
                var lsttag = daltag.RateableEmotionIntellisense(prefixText);

                if (lsttag != null)
                {
                    query = from c in lsttag
                        select new
                        {
                            Value = c.Emotionid.ToString(),
                            Name = c.EmotionName
                        };
                }
                return query;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }
    }
}