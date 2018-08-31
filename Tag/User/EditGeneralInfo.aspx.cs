using System;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.User
{
    public partial class EditGeneralInfo : BaseClass
    {
        private BllUser _blluser;
        private DtoUser _dtouser;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                if (!IsPostBack)
                {
                    _blluser = new BllUser();
                    _dtouser = new DtoUser();
                    _dtouser = _blluser.GetUserGeneralInfo(GetUserId());
                    SetFileds(_dtouser);
                }

                TxtFname.Attributes.Add("onblur", "blurfunction('fnamespan','" + TxtFname.ClientID + "')");
                TxtLname.Attributes.Add("onblur", "blurfunction('lnamespan','" + TxtLname.ClientID + "')");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            try
            {
                var cs = Page.ClientScript;

                if (TxtFname.Value != "")
                {
                    cs.RegisterClientScriptBlock(GetType(), "hidefnamemask",
                        "<script type='text/javascript'>document.getElementById('fnamespan').style.opacity = 0;</script>");
                }
                else
                    cs.RegisterClientScriptBlock(GetType(), "showfnamemask",
                        "<script type='text/javascript'>document.getElementById('fnamespan').style.opacity = 1</script>");

                if (TxtLname.Value != "")
                {
                    cs.RegisterClientScriptBlock(GetType(), "hidelnamemask",
                        "<script type='text/javascript'>document.getElementById('lnamespan').style.opacity = 0</script>");
                }
                else
                    cs.RegisterClientScriptBlock(GetType(), "showlnamemask",
                        "<script type='text/javascript'>document.getElementById('lnamespan').style.opacity = 1</script>");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private void SetFileds(DtoUser user)
        {
            TxtFname.Value = user.FirstName;
            TxtLname.Value = user.Lastname;

            // TxtEmail.Text = user.Email;
        }

        private DtoUser SetDto()
        {
            _dtouser = new DtoUser
            {
                FirstName = TxtFname.Value,
                Lastname = TxtLname.Value,
                UserId = GetUserId()
            };
            //dtouser.Email =  TxtEmail.Text;
            return _dtouser;
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            try
            {
                _blluser = new BllUser();
                var flag = _blluser.UpdateUser(SetDto());

                if (flag == -1)
                    LblEmailExsits.Visible = true;
                else
                {
                    LblChangesSaved.Visible = true;

                    var cs = Page.ClientScript;
                    cs.RegisterClientScriptBlock(GetType(), "hidepopup",
                        "<script type='text/javascript'>HidePopup()<script>");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}