using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using BLL;
using DTO;
using Exceptionless;

namespace Tag.WebsiteAdmin
{
    public partial class WebsiteGeneralSetting : BaseClass
    {
        private BllWebsite _bllwebsite;
        private DtoPremalink _dtopremalink;
        private DtoWebsite _dtowebsite;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                if (!IsPostBack)
                {
                    _bllwebsite = new BllWebsite();
                    _dtowebsite = new DtoWebsite();
                    _dtopremalink = new DtoPremalink();

                    if (UserId > 0)
                    {
                        var isWebsite = _bllwebsite.GetUserWebsite(UserId);
                        if (isWebsite != null)
                        {
                            _dtowebsite = isWebsite[0];

                            ViewState["websiteid"] = _dtowebsite.WebsiteId;

                            TextBox1.Text = _dtowebsite.WebSiteName;
                            TextBox2.Text = _dtowebsite.WebsiteUrl;

                            chktag.Checked = _dtowebsite.Tag;
                            chkemotion.Checked = _dtowebsite.Emotion;
                            chkaddable.Checked = _dtowebsite.AddTag;
                            chkrateable.Checked = _dtowebsite.RateTag;
                            chkemoaddable.Checked = _dtowebsite.AddEmotion;

                            if (!string.IsNullOrEmpty(_dtowebsite.WebsiteLogo))
                                imgweblogo.ImageUrl = "../Images/WebsiteLogo/" + _dtowebsite.WebsiteLogo;

                            if (_dtowebsite.WebSiteName != "")
                                Page.ClientScript.RegisterStartupScript(GetType(), "shortnamespand",
                                    "<script type='text/javascript'>document.getElementById('shortnamespan').style.opacity = 0;</script>");
                            if (_dtowebsite.WebsiteUrl != "")
                                Page.ClientScript.RegisterStartupScript(GetType(), "websitespand",
                                    "<script type='text/javascript'>document.getElementById('websitespan').style.opacity = 0;</script>");

                            txtcode.InnerText = "<div id='taghead'></div><script type ='text/javascript' language='javascript'>"
                                                + "var Websitename_shortname = '" + _dtowebsite.WebSiteName +
                                                "';</script>"
                                                +
                                                "<script src='http://www.glozzary.com/Script/NewJScript.js' type='text/javascript'></script>";

                            BtnDone.Visible = true;
                            BtnRegister.Visible = false;
                            dplstwebsitetype.DataSource = _bllwebsite.GetWebsiteType();
                            dplstwebsitetype.DataBind();
                            dplstwebsitetype.SelectedValue = _dtowebsite.WebsiteType;
                            _dtopremalink.WebsiteId = Convert.ToInt64(_dtowebsite.WebsiteId);
                        }
                        else
                        {
                            Response.Redirect("~/Default.aspx");
                        }
                    }
                    else
                    {
                        BtnRegister.Visible = true;
                        BtnDone.Visible = false;

                        dplstwebsitetype.DataSource = _bllwebsite.GetWebsiteType();
                        dplstwebsitetype.DataBind();
                    }
                }
                else
                {
                    if (TextBox1.Text != "")
                        Page.ClientScript.RegisterStartupScript(GetType(), "shortnamespan",
                            "<script type='text/javascript'>document.getElementById('shortnamespan').style.opacity = 0;</script>");
                    if (TextBox2.Text != "")
                        Page.ClientScript.RegisterStartupScript(GetType(), "websitespans",
                            "<script type='text/javascript'>document.getElementById('websitespan').style.opacity = 0;</script>");
                    //   if (TxtSearch.Text != "")
                    //      Page.ClientScript.RegisterStartupScript(GetType(), "searchsspans",
                    //        "<script type='text/javascript'>document.getElementById('searchsspan').style.opacity = 0;</script>");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                _dtowebsite = new DtoWebsite();
                _bllwebsite = new BllWebsite();

                _dtowebsite.UserId = UserId;
                _dtowebsite.WebsiteUrl = TextBox2.Text;
                _dtowebsite.WebSiteName = TextBox1.Text;
                _dtowebsite.WebsiteType = dplstwebsitetype.SelectedValue;

                _dtowebsite.Tag = chktag.Checked;

                if (chktag.Checked)
                {
                    _dtowebsite.AddTag = chkaddable.Checked;
                    _dtowebsite.RateTag = chkrateable.Checked;
                }

                _dtowebsite.Emotion = chkemotion.Checked;

                if (chkemotion.Checked)
                    _dtowebsite.AddEmotion = chkemoaddable.Checked;

                var isValidFile = false;

                if (ImgUpload.FileName != "")
                {
                    string[] validFileTypes = {"bmp"};
                    var ext = Path.GetExtension(ImgUpload.PostedFile.FileName);
                    for (var i = 0; i < validFileTypes.Length; i++)
                    {
                        if (ext == "." + validFileTypes[i])
                        {
                            isValidFile = true;
                            _dtowebsite.WebsiteLogo = Guid.NewGuid() + "." + ext;
                            ImgUpload.SaveAs(Server.MapPath("~/Images/WebsiteLogo/") + _dtowebsite.WebsiteLogo);
                            break;
                        }
                    }
                    if (!isValidFile)
                        lbluplderrmsg.Text = "Invalid File. Please upload a File with extension " +
                                             string.Join(",", validFileTypes);
                }
                //else
                //{
                //    _dtowebsite.WebsiteLogo = ConvertTextToImage(TextBox1.Text.Substring(0, 1).ToUpper(), "Arial", 30,
                //        Color.White, Color.Black, 50, 50);
                //    isValidFile = true;
                //}

                if (isValidFile)
                {
                    int flag = Convert.ToInt16(_bllwebsite.RegisterWebsite(_dtowebsite));

                    switch (flag)
                    {
                        case -1:
                            LblRegisterWebsite.Text = "Website URL Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        case -2:
                            LblRegisterWebsite.Text = "WebsiteName Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        default:
                            LblRegisterWebsite.Visible = false;
                            Response.Redirect("../User/Setting.aspx");
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        public string ConvertTextToImage(string txt, string fontname, int fontsize, Color bgcolor, Color fcolor,
            int width, int height)
        {
            try
            {
                var bmp = new Bitmap(width, height);
                var imagename = Guid.NewGuid() + ".bmp";
                var logourl = Server.MapPath("~/Images/WebsiteLogo/") + imagename;

                using (var graphics = Graphics.FromImage(bmp))
                {
                    var font = new Font(fontname, fontsize);
                    graphics.FillRectangle(new SolidBrush(bgcolor), 0, 0, bmp.Width, bmp.Height);
                    graphics.DrawString(txt, font, new SolidBrush(fcolor), 0, 0);
                    graphics.Flush();
                    font.Dispose();
                    graphics.Dispose();
                    using (var ms = new MemoryStream())
                    {
                        bmp.Save(ms, ImageFormat.Bmp);
                        var img = Image.FromStream(ms);
                        img.Save(logourl);
                    }
                }
                return imagename;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
            return null;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                _dtowebsite = new DtoWebsite();
                _bllwebsite = new BllWebsite();

                _dtowebsite.WebSiteName = TextBox1.Text;
                _dtowebsite.WebsiteUrl = TextBox2.Text;
                _dtowebsite.WebsiteId = Convert.ToInt64(ViewState["websiteid"]);
                if (Cookie != null)
                {
                    _dtowebsite.UserId = UserId;

                    _dtowebsite.Tag = chktag.Checked;
                    if (chktag.Checked)
                    {
                        _dtowebsite.AddTag = chkaddable.Checked;
                        _dtowebsite.RateTag = chkrateable.Checked;
                    }

                    _dtowebsite.Emotion = chkemotion.Checked;
                    if (chkemotion.Checked)
                        _dtowebsite.AddEmotion = chkemoaddable.Checked;

                    if (Cookie != null)
                    {
                        Cookie.Expires = DateTime.Now;
                        Response.SetCookie(Cookie);
                        Response.Redirect("Default.aspx");
                    }
                }

                var isValidFile = false;

                if (ImgUpload.FileName != "")
                {
                    string[] validFileTypes = {"bmp"};
                    var ext = Path.GetExtension(ImgUpload.PostedFile.FileName);
                    for (var i = 0; i < validFileTypes.Length; i++)
                    {
                        if (ext == "." + validFileTypes[i])
                        {
                            isValidFile = true;
                            _dtowebsite.WebsiteLogo = Guid.NewGuid() + "." + ext;
                            ImgUpload.SaveAs(Server.MapPath("~/Images/WebsiteLogo/") + _dtowebsite.WebsiteLogo);
                            break;
                        }
                    }
                    if (!isValidFile)
                        lbluplderrmsg.Text = "Invalid File. Please upload a File with extension " +
                                             string.Join(",", validFileTypes);
                }
                else
                {
                    if (imgweblogo.ImageUrl == "")
                        _dtowebsite.WebsiteLogo = ConvertTextToImage(TextBox1.Text.Substring(0, 1).ToUpper(), "Arial",
                            30, Color.White, Color.Black, 50, 50);
                    isValidFile = true;
                }

                if (isValidFile)
                {
                    int flag = Convert.ToInt16(_bllwebsite.UpdateWebsite(_dtowebsite));

                    switch (flag)
                    {
                        case -1:
                            LblRegisterWebsite.Text = "Website URL Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        case -2:
                            LblRegisterWebsite.Text = "WebsiteName Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        default:
                            LblRegisterWebsite.Visible = false;
                            Response.Redirect("../User/Setting.aspx");
                            break;
                    }

                    Response.Redirect("../User/Setting.aspx");
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                //  _dtopremalink = new DtoPremalink {WebsiteId = Convert.ToInt64(ViewState["websiteid"])};

                //_dtopremalink.Link = TxtSearch.Text;

                //GridPremalink.DataSource = _bllpremalink.GetWebsitePremalink(_dtopremalink);
                //GridPremalink.DataBind();
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                _dtowebsite = new DtoWebsite();
                _bllwebsite = new BllWebsite();

                _dtowebsite.UserId = UserId;
                _dtowebsite.WebSiteName = TextBox1.Text;
                _dtowebsite.WebsiteUrl = TextBox2.Text;
                _dtowebsite.WebsiteId = Convert.ToInt64(ViewState["websiteid"]);
                _dtowebsite.WebsiteType = dplstwebsitetype.SelectedValue;

                _dtowebsite.Tag = chktag.Checked;
                _dtowebsite.Emotion = chkemotion.Checked;
                if (chktag.Checked)
                {
                    _dtowebsite.AddTag = chkaddable.Checked;
                    _dtowebsite.RateTag = chkrateable.Checked;
                }
                else
                {
                    chkaddable.Style.Add("display", "none");
                    chkrateable.Style.Add("display", "none");
                }

                if (chkemotion.Checked)
                    _dtowebsite.AddEmotion = chkemoaddable.Checked;
                else
                    chkemoaddable.Style.Add("display", "none");

                var isValidFile = false;

                if (ImgUpload.FileName != "")
                {
                    string[] validFileTypes = {"bmp"};
                    var ext = Path.GetExtension(ImgUpload.PostedFile.FileName);
                    for (var i = 0; i < validFileTypes.Length; i++)
                    {
                        if (ext == "." + validFileTypes[i])
                        {
                            isValidFile = true;
                            _dtowebsite.WebsiteLogo = Guid.NewGuid() + "." + ext;
                            ImgUpload.SaveAs(Server.MapPath("~/Images/WebsiteLogo/") + _dtowebsite.WebsiteLogo);
                            break;
                        }
                    }
                    if (!isValidFile)
                        lbluplderrmsg.Text = "Invalid File. Please upload a File with extension " +
                                             string.Join(",", validFileTypes);
                }
                else
                {
                    if (imgweblogo.ImageUrl == "")
                        _dtowebsite.WebsiteLogo = ConvertTextToImage(TextBox1.Text.Substring(0, 1).ToUpper(), "Arial",
                            30, Color.White, Color.Black, 50, 50);
                    isValidFile = true;
                }

                if (isValidFile)
                {
                    int flag = Convert.ToInt16(_bllwebsite.UpdateWebsite(_dtowebsite));

                    switch (flag)
                    {
                        case -1:
                            LblRegisterWebsite.Text = "Website URL Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        case -2:
                            LblRegisterWebsite.Text = "WebsiteName Already Exists";
                            LblRegisterWebsite.Visible = true;
                            break;
                        default:
                            //LblRegisterWebsite.Visible = false;
                            Response.Redirect("../User/Setting.aspx");
                            break;
                    }                                           
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void dplstwebsitetype_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var uc = new UtilityClass();
                txtoptional.InnerText = "";
                txtrecommended.InnerText = "";

                txtrecommended.InnerText =
                    "<meta property='og:title' content='Title Here>\n" +
                    "<meta property='og:url' content='url Here>\n" +
                    "<meta property='og:description' content='description Here>\n" +
                    "<meta property='og:image' content='Image Here>\n" +
                    "<meta property='og:Site_Name' content='Site_Name Here'>\n" +
                    "<meta property='og:Published_Time' content='Published_Time>\n" +
                    "<meta property='og:Emotion' content='Emotion Here>\n" +
                    "<meta property='og:Keyword' content='Keyword Here>\n";

                if (dplstwebsitetype.SelectedItem.Value != "0")
                {
                    var lst = uc.GetMetachars(Convert.ToInt32(dplstwebsitetype.SelectedItem.Value));
                    if (lst != null && lst.Count > 0)
                        txtoptional.InnerText = lst[0];
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}