using System;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.User
{
    public partial class Setting : BaseClass
    {
        private BllUser _blluser;
        protected DtoUser Dtouser;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();

                if (!IsPostBack)
                {
                    _blluser = new BllUser();
                    Dtouser = new DtoUser();

                    Dtouser = _blluser.GetUserGeneralInfo(UserId);

                    TxtFname.Attributes.Add("value", Dtouser.FirstName);
                    TxtLname.Attributes.Add("value", Dtouser.Lastname);
                    TxtEmail.Attributes.Add("value", Dtouser.Email);

                    if (Dtouser.ImageUrl != "")
                        Dtouser.ImageUrl = "/Uploads/" + Dtouser.ImageUrl + ".jpg";
                    else
                        Dtouser.ImageUrl = "/Images/nopic.png";

                    if (Dtouser.CoverPhoto != "")
                        Dtouser.CoverPhoto = "/Uploads/" + Dtouser.CoverPhoto + ".jpg";
                    else
                        Dtouser.CoverPhoto = "";

                    //GriduserWebsie.DataSource = bllwebsite.GetUserWebsite(UserID);
                    //GriduserWebsie.DataBind();
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        private DtoUser SetDto()
        {
            Dtouser = new DtoUser
            {
                FirstName = TxtFname.Value,
                Lastname = TxtLname.Value,
                Email = TxtEmail.Value,
                UserId = UserId
            };
            return Dtouser;
        }

        protected void btncancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            try
            {
                UserId = GetUserId();
                _blluser = new BllUser();
                var flag = _blluser.UpdateUser(SetDto());

                if (flag == -1)
                {
                    _blluser = new BllUser();
                    Dtouser = new DtoUser();

                    Dtouser = _blluser.GetUserGeneralInfo(UserId);
                    Dtouser.ImageUrl = "/Uploads/" + Dtouser.ImageUrl + ".jpg";
                    Dtouser.CoverPhoto = "/Uploads/" + Dtouser.CoverPhoto + ".jpg";
                    var cs = Page.ClientScript;
                    // Check to see if the startup script is already registered.
                    if (!cs.IsStartupScriptRegistered(GetType(), "ClosePopupScript"))
                    {
                        var cstext1 = "ClosePopup()";
                        Page.ClientScript.RegisterStartupScript(GetType(), "closed",
                            "<script type='text/javascript'>document.getElementById('profileimg').src=" +
                            Dtouser.ImageUrl + "; document.getElementById('proheader').style.background-image= url('.." +
                            Dtouser.CoverPhoto + "'); </script>");
                    }

                    LblEmailExsits.Visible = true;
                }
                else
                    Response.Redirect("Profile.aspx");
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}