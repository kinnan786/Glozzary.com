using System;
using System.IO;
using BLL;
using Exceptionless;
using ImageResizer;

namespace Tag.User
{
    public partial class ProviderImage : BaseClass
    {
        private BllUser _blluser;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsUser();

                if (!IsPostBack)
                {
                    ViewState["Id"] = 0;
                    ViewState["flow"] = "";
                    ViewState["imageurl"] = "";

                    if (Request.QueryString["Id"] != null)
                        ViewState["Id"] = Convert.ToInt64(Request.QueryString["Id"]);
                    else
                        ViewState["Id"] = UserId;

                    _blluser = new BllUser();

                    if (Request.QueryString["flow"] != null)
                        ViewState["flow"] = Request.QueryString["flow"];

                    var s = Request.QueryString["flow"];
                    if (s != null && s.ToLower() == "coverphoto".ToLower())
                    {
                        ViewState["imageurl"] = _blluser.GetCoverImage(UserId);
                        if (ViewState["imageurl"].ToString() != "")
                            ImgPic.ImageUrl = "/Uploads/" + ViewState["imageurl"] + ".jpg";
                        //BtnDelete.Visible = true;
                    }
                    else
                    {
                        var s1 = Request.QueryString["flow"];
                        if (s1 != null && s1.ToLower() == "profilephoto".ToLower())
                        {
                            ViewState["imageurl"] = _blluser.GetUserImage(UserId);
                            if (ViewState["imageurl"].ToString() != "")
                                ImgPic.ImageUrl = "/Uploads/" + ViewState["imageurl"] + ".jpg";
                            //BtnDelete.Visible = true;
                        }
                        else
                        {
                            ImgPic.ImageUrl = "~/Images/no_photo.jpg";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        protected void BtnImgSave_Click(object sender, EventArgs e)
        {
            try
            {
                IsUser();
                _blluser = new BllUser();

                if (UserId > 0)
                {
                    if (ImgUpld.HasFile && ImgUpld.PostedFile != null)
                    {
                        var directory = Server.MapPath("/Uploads/");
                        ResizeSettings resizeCropSettings;
                        var url = ImgUpld.FileName;
                        ImgUpld.SaveAs(directory + ImgUpld.FileName);

                        //The resizing settings can specify any of 30 commands.. See http://imageresizing.net for details.
                        if (ViewState["flow"].ToString() == "profilephoto")
                            resizeCropSettings = new ResizeSettings("maxwidth=195&maxheight=190&format=jpg");
                        else
                            resizeCropSettings = new ResizeSettings("maxwidth=600&maxheight=300&format=jpg");

                        var name = Guid.NewGuid().ToString();

                        //Generate a filename (GUIDs are safest).
                        url = Path.Combine(directory, name);

                        //Let the image builder add the correct extension based on the output file type (which may differ).
                        ImageBuilder.Current.Build(directory + ImgUpld.FileName, url, resizeCropSettings, false, true);

                        if (Request.QueryString["flow"].ToLower() == "coverphoto")
                        {
                            if (File.Exists(ImgPic.ImageUrl))
                                File.Delete(ImgPic.ImageUrl);

                            _blluser.UpdateUsercoverphoto(UserId, name);
                        }

                        File.Delete(directory + ImgUpld.FileName);

                        if (Request.QueryString["flow"].ToLower() == "profilephoto")
                        {
                            if (File.Exists(ImgPic.ImageUrl))
                                File.Delete(ImgPic.ImageUrl);

                            _blluser.UpdateUserImage(UserId, name);
                        }

                        if (File.Exists(Server.MapPath("/Uploads/") + ViewState["imageurl"] + ".jpg"))
                            File.Delete(Server.MapPath("/Uploads/") + ViewState["imageurl"] + ".jpg");

                        ClientScript.RegisterClientScriptBlock(GetType(), "hidepopy",
                            "<script type='text/javascript'>HidePopup();</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }

        public bool ThumbnailCallback()
        {
            return false;
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                _blluser = new BllUser();
                if (Request.QueryString["flow"].ToLower() == "update")
                {
                    //BtnDelete.Visible = true;

                    if (File.Exists(Server.MapPath("/Uploads/") + ImgPic.ImageUrl + ".jpg"))
                        File.Delete(Server.MapPath("/Uploads/") + ImgPic.ImageUrl + ".jpg");

                    _blluser.DeleteUserImage(Convert.ToInt64(ViewState["Id"]));
                    ClientScript.RegisterClientScriptBlock(GetType(), "hidepopy",
                        "<script type='text/javascript'>HidePopup();</script>");
                }
                // else
                //BtnDelete.Visible = false;
            }
            catch (Exception ex)
            {
                ex.ToExceptionless().Submit();
            }
        }
    }
}