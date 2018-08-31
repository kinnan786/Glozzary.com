using System;
using System.Collections.Generic;
using BLL;
using DTO;

namespace Tag.WebsiteAdmin
{
    public partial class Setting : BaseClass
    {
        private BllWebsite _bllWebsite;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                IsWebSite();
                if (!IsPostBack)
                {
                    _bllWebsite = new BllWebsite();
                    var bllPremalink = new BllPremalink();

                    var lstdto = new List<DtoWebsite>
                    {
                        _bllWebsite.GetUserWebsite(UserId)[0]
                    };


                    gridwebsite.DataSource = lstdto;
                    gridwebsite.DataBind();


                    GridView1.DataSource = bllPremalink.GetWebsitePremalink(new DtoPremalink
                    {
                        WebsiteId = lstdto[0].WebsiteId
                    });

                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            var bllPremalink = new BllPremalink();

            GridView1.DataSource = bllPremalink.SearchPremalink(txtsearch.Value, 1);
            GridView1.DataBind();
        }
    }
}