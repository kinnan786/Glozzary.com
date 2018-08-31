using System;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.User
{
    public partial class EditPassword : BaseClass
    {
        private BllUser _blluser;
        private DtoUser _dtouser;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                TxtCurrent.Attributes.Add("onblur", "blurfunction('TxtCurrentspan','" + TxtCurrent.ClientID + "')");
                TxtNew.Attributes.Add("onblur", "blurfunction('TxtNewspan','" + TxtNew.ClientID + "')");
                TxtRetypeNew.Attributes.Add("onblur", "blurfunction('TxtRetypeNewspan','" + TxtRetypeNew.ClientID + "')");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            try
            {
                _blluser = new BllUser();
                _dtouser = new DtoUser
                {
                    Password = TxtCurrent.Text,
                    NewPassword = TxtNew.Text,
                    UserId = GetUserId()
                };

                var flag = _blluser.UpdatePassword(_dtouser);
                if (flag < 0)
                {
                    LblPassworderror.Visible = true;
                    LblPasswordChanged.Visible = false;
                }
                else
                {
                    LblPassworderror.Visible = false;
                    LblPasswordChanged.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}