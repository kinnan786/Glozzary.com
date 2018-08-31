using System;
using System.Web;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Authentication
{
    public partial class EmailVerify : System.Web.UI.Page
    {
        private HttpCookie cookie;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (Request.QueryString["Email"] != null && Request.QueryString["VerificationCode"] != null)
                {
                    BllUser blluser = new BllUser();
                    DtoUser dtouser = new DtoUser();
                    dtouser.Email = Request.QueryString["Email"].ToString();
                    dtouser.Guid = Request.QueryString["VerificationCode"].ToString();

                    long result = blluser.VerifyEmail(dtouser);

                    if (result == -1)
                    {
                        lblmesssage.Text = "Cannot Verify your Email " + dtouser.Email + " . Check your Email again Try again Later.";
                    }
                    else if (result > 0)
                    {
                        cookie = new HttpCookie("Tagged");
                        cookie.Values.Add("d", BLL.UtilityClass.EncryptStringAES(result.ToString()));
                        cookie.Expires = DateTime.MaxValue;
                        Response.SetCookie(cookie);
                        Response.Redirect("~/Default.aspx");
                    }
                }
                else
                    lblmesssage.Text = "Email  and VerificationCode not in correct format";
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }

        }
    }
}