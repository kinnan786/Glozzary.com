<%@ Page Title="" Language="C#" MasterPageFile="~/WebsiteAdmin/WebsiteAdmin.Master" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="Tag.WebsiteAdmin.Setting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Website
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        
                        This is your Website, you can change any information regarding this in your website<br/>        
                        <asp:GridView ID="gridwebsite" runat="server" 
                                      CssClass="table table-hover table-striped" GridLines="None" 
                                      AutoGenerateColumns="False">
                            <EmptyDataTemplate>
                                <div style="width: 100%;text-align: center;">
                                <asp:HyperLink runat="server" NavigateUrl="WebsiteGeneralSetting.aspx">Add Website</asp:HyperLink>
                                    </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="WebSiteName">
                                    <ItemTemplate>
                                        <asp:Label ID="LblTagCount" runat="server" Text='<%# Eval("WebSiteName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="WebsiteURL">
                                    <ItemTemplate>
                                        <asp:Label ID="LblTagCount" runat="server" Text='<%# Eval("WebsiteURL") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Enable Emotion">
                                    <ItemTemplate>
                                        <asp:Label ID="LblTagCount" runat="server" Text='<%# Eval("Emotion") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Enable Tag">
                                    <ItemTemplate>
                                        <asp:Label ID="LblTagCount" runat="server" Text='<%# Eval("Tag") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkWebsiteName" runat="server" PostBackUrl='<%# Eval("WebsiteID", "WebsiteGeneralSetting.aspx?WebsiteID={0}") %>'
                                                        Text='Edit'></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="cursor-pointer" />
                        </asp:GridView>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
            <div class="col-lg-8" style="margin-left: 150px; padding: 10px;">
                <div class="input-group">
                    <input type="text" id="txtsearch" runat="server" class="form-control" placeholder="Search All premalinks" />
                    <span class="input-group-btn">
                        <asp:Button ID="btnsearch" runat="server" class="btn btn-default" Text="Search" OnClick="btnsearch_Click" />
                        <%--    <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                    --%>
                    </span>
                </div><!-- /input-group -->
            </div>
            <br/><br/>
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Premalinks
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        These are all the website premalink, you can add or edit these tags using this screen. The premalink will we added automatically. If the script is running on those pages
                        <br/>
                        <asp:GridView ID="GridView1" runat="server" 
                                      CssClass="table table-hover table-striped" GridLines="None" 
                                      AutoGenerateColumns="False">
                            <EmptyDataTemplate>
                                Currently you have no premalink associated with your website
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Link">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLink" runat="server" Text='<%# Eval("Link") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LnkWebsiteName" runat="server" PostBackUrl='<%# Eval("PremalinkID", "PremalinkSetting.aspx?ID={0}") %>'
                                                        Text='Edit'></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="cursor-pointer" />
                        </asp:GridView>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
    </div>
</asp:Content>