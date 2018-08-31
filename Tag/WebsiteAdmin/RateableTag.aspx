<%@ Page Title="" Language="C#" MasterPageFile="~/WebsiteAdmin/WebsiteAdmin.Master" AutoEventWireup="true" CodeBehind="RateableTag.aspx.cs" Inherits="Tag.WebsiteAdmin.RateableTag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Rateable Tag
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="input-group" style="width: 450px;">
                            <span class="input-group-btn"><asp:Button ID="btnadd" runat="server" Text="ADD" CssClass="btn btn-default" OnClick="btnadd_Click" OnClientClick=" return validate() " /></span>
                        </div>
                        <br />
                        <asp:GridView ID="grdtags" runat="server" CssClass="table table-hover table-striped"
                                      AutoGenerateColumns="False"  GridLines="None" OnRowDataBound="GridPremalinkTags_RowDataBound">
                            <EmptyDataTemplate>
                                No Rateable Tag Added
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        &nbsp;&nbsp;
                                        <asp:Label ID="lbltagname" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="95%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:HyperLink runat="server" ID="lnkedit" Text="Edit"></asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="cursor-pointer" />
                        </asp:GridView>
                                      
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
        </div>
    </div>
</asp:Content>