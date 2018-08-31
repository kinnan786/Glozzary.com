using System;
using System.Configuration;
using System.IO;
using System.Net.Mail;
using System.Web.UI;
using BLL;
using Exceptionless;

namespace Tag.Authentication
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        private BllUser user = new BllUser();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
            else
            {
                if (TxtEmail.Text != "")
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "Emailspanssss", "<script type='text/javascript'>document.getElementById('Emailspan').style.opacity = 0;</script>");
            }
        }

        protected Boolean SendVerificationEmail(string email)
        {
            //System.Diagnostics.Debugger.Launch();
            try
            {
                string password = "";
                password = user.GetUserPassword(email);

                if (password != "-1")
                {
                    MailMessage Msg = new MailMessage();
                    Msg.From = new MailAddress(ConfigurationManager.AppSettings["MailingAddress"]);
                    Msg.To.Add(email);
                    StreamReader reader = new StreamReader(Server.MapPath("~/EmailPassword.html"));
                    string readFile = reader.ReadToEnd();
                    string StrContent = "";
                    //Here replace the name with [MyName]
                    StrContent = readFile.Replace("[MYPassword]", password);

                    Msg.Subject = "Recover Password";
                    Msg.Body = StrContent.ToString();
                    Msg.IsBodyHtml = true;
                    // your remote SMTP server IP.
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = ConfigurationManager.AppSettings["MailServerName"];
                    System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();
                    NetworkCred.UserName = ConfigurationManager.AppSettings["MailingAddress"];
                    NetworkCred.Password = ConfigurationManager.AppSettings["Password"];
                    smtp.UseDefaultCredentials = true;
                    smtp.Credentials = NetworkCred;
                    smtp.Port = 25;
                    smtp.Send(Msg);
                    lblemailexists.Text = "Email sent";
                    lblemailexists.Visible = true;
                }
                else
                {
                    lblemailexists.Text = "Incorrect Email.";
                    lblemailexists.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return false;
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            SendVerificationEmail(TxtEmail.Text.ToString());
        }
    }
}