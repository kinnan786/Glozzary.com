using System;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.Authentication
{
    public partial class PopUpLogin : Page
    {
        private readonly string _prevurl;
        private BllUser _blluser;
        private HttpCookie _cookie;
        private DtoUser _dtouser;
        private bool _pagevalid;
        private Int64 _userid;

        public PopUpLogin()
        {
            //  System.Diagnostics.Debugger.Launch();
        }

        public PopUpLogin(string prevurl)
        {
            _prevurl = prevurl;
        }

        [WebMethod]
        public static long FaceBookAuthentication(string id, string email, string firstName, string lastName)
        {
            try
            {
                var user = new BllUser();
                var returnval = user.FaceBookAuthetication(id, email, firstName, lastName);

                if (returnval > 1)
                {
                    var cookie = HttpContext.Current.Request.Cookies["Tagged"];
                    if (cookie == null)
                    {
                        cookie = new HttpCookie("Tagged");
                        cookie.Values.Add("d", UtilityClass.EncryptStringAES(returnval.ToString()));
                        cookie.Expires = DateTime.MaxValue;
                        HttpContext.Current.Response.SetCookie(cookie);
                    }
                }
                return returnval;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return 0;
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            //System.Diagnostics.Debugger.Launch();
            try
            {
                if (_pagevalid)
                {
                    _blluser = new BllUser();
                    _dtouser = new DtoUser();

                    var emailRegex = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                    var passwordRegex = new Regex("^([a-zA-Z0-9@*#]{8,15})$");


                    if (emailRegex.IsMatch(TxtLEmail.Text) &&
                        passwordRegex.IsMatch(TxtLPassword.Text))
                    {
                        _dtouser.Email = Convert.ToString(TxtLEmail.Text);
                        _dtouser.Password = Convert.ToString(TxtLPassword.Text);
                        _dtouser.IsUser = true;
                        // _dtouser.IsUser = chkuser.SelectedValue == "1" ? true : false;

                        _userid = _blluser.AuthenticateUser(_dtouser);

                        if (_userid == -1 || _userid == 0)
                        {
                            LblAutentication.Text = "Incorrect Username Or Password";
                            LblAutentication.Visible = true;
                        }
                        else if (_userid == -2)
                        {
                            LblAutentication.Text = "Please verify you email";
                            LblAutentication.Visible = true;
                        }
                        else
                        {
                            _cookie = new HttpCookie("Tagged");
                            _cookie.Values.Add("d", UtilityClass.EncryptStringAES(_userid.ToString()));
                            _cookie.Values.Add("u", UtilityClass.EncryptStringAES(1.ToString()));

                            _cookie.Expires = DateTime.MaxValue;
                            Response.SetCookie(_cookie);
                            // Get a ClientScriptManager reference from the Page class.
                            var cs = Page.ClientScript;

                            // Check to see if the startup script is already registered.
                            if (!cs.IsStartupScriptRegistered(GetType(), "ClosePopupScript"))
                            {
                                var cstext1 = "ClosePopup()";
                                Page.ClientScript.RegisterStartupScript(GetType(), "closed",
                                    "<script type='text/javascript'>ClosePopup('" + _prevurl + "')</script>");
                            }
                        }
                    }
                    else
                    {
                        LblAutentication.Text = "Incorrect Username Or Password";
                        LblAutentication.Visible = true;
                    }
                }
                else
                {
                    LblAutentication.Visible = true;
                    LblAutentication.Text = "Captcha Does Match";
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void BtnRegister_Click1(object sender, EventArgs e)
        {
            try
            {
                if (_pagevalid)
                {
                    _dtouser = new DtoUser();
                    _blluser = new BllUser();

                    var emailRegex = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                    var passwordRegex = new Regex("^([a-zA-Z0-9@*#]{8,15})$");


                    if (emailRegex.IsMatch(TxtLEmail.Text) &&
                        passwordRegex.IsMatch(TxtLPassword.Text))
                    {
                        _dtouser.Email = TxtLEmail.Text;
                        _dtouser.Password = TxtLPassword.Text;
                        _dtouser.Guid = Guid.NewGuid().ToString();
                        // _dtouser.IsUser = chkuser.SelectedValue == "1" ? true : false;

                        _userid = _blluser.RegisterUser(_dtouser);

                        if (_userid == -1)
                        {
                            LblAutentication.Text = "Email Already Exists";
                            LblAutentication.Visible = true;
                        }
                        else
                        {
                            var st = SendVerificationEmail(TxtLEmail.Text, _dtouser.Guid);

                            if (st == false)
                            {
                                LblAutentication.Text = "Email Cannot be Sent at this Time.";
                                LblAutentication.Visible = true;
                            }
                            else
                            {
                                LblAutentication.Text = "Please Verify Your Email";
                                LblAutentication.Visible = true;
                            }
                        }
                    }
                    else
                    {
                        LblAutentication.Text = "Incorrect Username Or Password";
                        LblAutentication.Visible = true;
                    }
                }
                else
                {
                    LblAutentication.Visible = true;
                    LblAutentication.Text = "Captcha Does Match";
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // System.Diagnostics.Debugger.Launch();


                if (!IsPostBack)
                {
                    //string Captcha = BLL.UtilityClass.EncryptStringAES(GetCaptchaText());
                    //Session["Captcha"] = Captcha;
                    // imgCaptcha.ImageUrl = "Captcha.ashx?n=" + Captcha;

                    //if (Request.QueryString["flow"] != null)
                    //{
                    //    if (Request.QueryString["flow"].ToString() == "FacebookConnect" && Request.QueryString["UserID"] != null)
                    //    {
                    //        cookie = new HttpCookie("Tagged");
                    //        cookie.Values.Add("d", BLL.UtilityClass.EncryptStringAES(Request.QueryString["UserID"].ToString()));
                    //        cookie.Expires = DateTime.MaxValue;
                    //        Response.SetCookie(cookie);

                    // if (Request.QueryString["prevurl"] != null) prevurl =
                    // Request.QueryString["prevurl"].ToString(); else prevurl = "Default.aspx";

                    //        // Check to see if the startup script is already registered.
                    //        if (!cs.IsStartupScriptRegistered(this.GetType(), "ClosePopupScript"))
                    //        {
                    //            string cstext1 = "ClosePopup()";
                    //            Page.ClientScript.RegisterStartupScript(this.GetType(), "closed", "<script type='text/javascript'>ClosePopup('" + prevurl + "')</script>");
                    //        }
                    //    }
                    //}
                    //else
                    //    if (Request.QueryString["prevurl"] != null)
                    //        prevurl = Request.QueryString["prevurl"].ToString();
                }
                else
                {
                    var query =
                        "http://www.google.com/recaptcha/api/verify?privatekey=6Lep5PkSAAAAAMRU5ex8WmMMHy_9iUzof9VXZ8T2&remoteip=192.168.1.6&challenge=" +
                        Request.Form["recaptcha_challenge_field"] + "&response=" +
                        Request.Form["recaptcha_response_field"];


                    var encode = Encoding.GetEncoding("utf-8");


                    var wrquest = (HttpWebRequest) WebRequest.Create(query);
                    var getresponse = (HttpWebResponse) wrquest.GetResponse();
                    var objStream = getresponse.GetResponseStream();
                    if (objStream != null)
                    {
                        var objSr = new StreamReader(objStream, encode, true);
                        var strResponse = objSr.ReadToEnd();

                        if (Convert.ToBoolean(strResponse.Split('\n')[0]))
                            _pagevalid = true;
                        else
                            _pagevalid = false;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected Boolean SendVerificationEmail(string email, string guid)
        {
            try
            {
                var msg = new MailMessage {From = new MailAddress(ConfigurationManager.AppSettings["MailingAddress"])};
                msg.To.Add(email);
                var reader = new StreamReader(Server.MapPath("~/Emailbody.htm"));
                var readFile = reader.ReadToEnd();
                //Here replace the name with [MyName]
                var strContent = readFile.Replace("[MYLink]",
                    "<a href=" + ConfigurationManager.AppSettings["currenturl"].ToString(CultureInfo.InvariantCulture) +
                    "Authentication/EmailVerify.aspx?Email=" + email + "&VerificationCode=" + guid +
                    "  target='_blank' >Verify Email</a>");

                msg.Subject = "Please confirm your email";
                msg.Body = strContent;
                msg.IsBodyHtml = true;
                // your remote SMTP server IP.
                var smtp = new SmtpClient {Host = ConfigurationManager.AppSettings["MailServerName"]};
                var networkCred = new NetworkCredential
                {
                    UserName = ConfigurationManager.AppSettings["MailingAddress"],
                    Password = ConfigurationManager.AppSettings["Password"]
                };
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = networkCred;
                smtp.Port = 25;
                smtp.Send(msg);
                return true;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return false;
        }

        protected void btnweblogin_Click(object sender, EventArgs e)
        {
            try
            {
                // System.Diagnostics.Debugger.Launch();
                _blluser = new BllUser();
                _dtouser = new DtoUser();

                var emailRegex = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                var passwordRegex = new Regex("^([a-zA-Z0-9@*#]{8,15})$");

                if (emailRegex.IsMatch(txtwebemail.Text) &&
                    passwordRegex.IsMatch(txtwebpassword.Text))
                {
                    _dtouser.Email = Convert.ToString(txtwebemail.Text);
                    _dtouser.Password = Convert.ToString(txtwebpassword.Text);
                    _dtouser.IsUser = false;
                    // _dtouser.IsUser = chkuser.SelectedValue == "1" ? true : false;

                    _userid = _blluser.AuthenticateUser(_dtouser);

                    if (_userid == -1 || _userid == 0)
                    {
                        lblwebauthentication.Text = "Incorrect Username Or Password";
                        lblwebauthentication.Visible = true;
                        Page.ClientScript.RegisterStartupScript(GetType(), "showwebtab",
                            "<script type='text/javascript'>$('#myTab a:last').tab('show');</script>");
                    }
                    else if (_userid == -2)
                    {
                        lblwebauthentication.Text = "Please verify you email";
                        lblwebauthentication.Visible = true;
                        Page.ClientScript.RegisterStartupScript(GetType(), "showwebtab",
                            "<script type='text/javascript'>$('#myTab a:last').tab('show');</script>");
                    }
                    else
                    {
                        _cookie = new HttpCookie("Tagged");
                        _cookie.Values.Add("d", UtilityClass.EncryptStringAES(_userid.ToString()));
                        _cookie.Values.Add("u", UtilityClass.EncryptStringAES(0.ToString()));

                        _cookie.Expires = DateTime.MaxValue;
                        Response.SetCookie(_cookie);
                        // Get a ClientScriptManager reference from the Page class.
                        var cs = Page.ClientScript;

                        // Check to see if the startup script is already registered.
                        if (!cs.IsStartupScriptRegistered(GetType(), "ClosePopupScript"))
                        {
                            var cstext1 = "ClosePopup()";
                            Page.ClientScript.RegisterStartupScript(GetType(), "closed",
                                "<script type='text/javascript'>ClosePopup('../WebsiteAdmin/WebsiteGeneralSetting.aspx')</script>");
                        }
                    }
                }
                else
                {
                    lblwebauthentication.Text = "Incorrect Username Or Password";
                    lblwebauthentication.Visible = true;
                    Page.ClientScript.RegisterStartupScript(GetType(), "showwebtab",
                        "<script type='text/javascript'>$('#myTab a:last').tab('show');</script>");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void btnwebregister_Click(object sender, EventArgs e)
        {
            var emailRegex = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
            var passwordRegex = new Regex("^([a-zA-Z0-9@*#]{8,15})$");

            if (emailRegex.IsMatch(txtwebemail.Text) &&
                passwordRegex.IsMatch(txtwebpassword.Text))
            {
                var dtowebsite = new DtoWebsite
                {
                    WebsiteLogo = txtwebemail.Text,
                    Image = txtwebpassword.Text,
                    RateTag = false,
                    WebSiteName = txtwebsitename.Text,
                    WebsiteUrl = txtwebsiteurl.Text,
                    WebsiteType = Guid.NewGuid().ToString()
                };

                var bllWebsite = new BllWebsite();
                var flag = bllWebsite.RegisterWebsiteAndUser(dtowebsite);

                if (flag == -1)
                {
                    lblwebauthentication.Text = "Email Already Exists";
                    lblwebauthentication.Visible = true;
                }
                else
                {
                    var st = SendVerificationEmail(TxtLEmail.Text, _dtouser.Guid);

                    if (st == false)
                    {
                        lblwebauthentication.Text = "Email Cannot be Sent at this Time.";
                        lblwebauthentication.Visible = true;
                    }
                    else
                    {
                        lblwebauthentication.Text = "Please Verify Your Email";
                        lblwebauthentication.Visible = true;
                    }
                }
            }
            else
            {
                lblwebauthentication.Text = "Incorrect Username Or Password";
                lblwebauthentication.Visible = true;
            }
        }
    }
}