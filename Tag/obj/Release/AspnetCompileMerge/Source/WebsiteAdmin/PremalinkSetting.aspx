<%@ Page Title="" Language="C#" MasterPageFile="~/WebsiteAdmin/WebsiteAdmin.Master" AutoEventWireup="true" CodeBehind="PremalinkSetting.aspx.cs" Inherits="Tag.WebsiteAdmin.PremalinkSetting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        function SetSelectedValue(premalinkid, tagid) {
            $(document).ready(function() {
                $.ajax
                ({
                    type: "POST",
                    url: "PremalinkSetting.aspx/DeleteTag",
                    data: "{'premalinkid': '" + premalinkid + "','tagid': '" + tagid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        window.location = window.location;
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                });
            });
        }


        function validate() {
            if (document.getElementById("<%= txttag.ClientID %>").value.length < 3) {
                alert("At least 3 characters required !!!");
                return false;
            }
            return true;
        }
    </script>
    <div id="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Premalink
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <asp:Label runat="server" ID="linkPremalink" ></asp:Label>
                        <br/>
                        <table style="text-align: left; vertical-align: top; width: 100%;">
                            <tr>
                                <td style="width: 150px">
                                    <asp:Image runat="server" ID="imgPremalink" style="height: 100px; width: 100px;"/>            
                                </td>
                                <td style="vertical-align: top;">
                                    <asp:Label runat="server" ID="lblPremalink"></asp:Label>
                                    <asp:Label runat="server" ID="lblDescription"></asp:Label>
                                    
                                </td>
                            </tr>
                        </table>                            
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Tag
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">        
                        <%--<p>Kindly Select the services that you want to have on your Website or blog. Select atleast one services</p>
                        <br />
                        <p>
                            <asp:CheckBox ID="chktag" runat="server" Text="  Tags" Font-Bold="true" />
                        </p>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkrateable" runat="server" style="display: inline-block;" /><label id="lbltagrate" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Rate Tags in my Website/Blog</strong></p>
                                                                                                                                              </label>
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkaddable" runat="server" style="display: inline-block;" /><label id="lbltagadd" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Add New Tags in my Website/Blog</strong></p>
                                                                                                                                             </label>
                        <br /><br/>--%>
                        <div class="input-group" style="width: 450px;">
                            <asp:TextBox ID="txttag" placeholder="Add Tag" runat="server" CssClass="form-control"  Style="width: 430px;" />
                            <span class="input-group-btn"><asp:Button ID="btnadd" runat="server" Text="ADD" CssClass="btn btn-default" OnClick="btnadd_Click" OnClientClick=" return validate() " /></span>
                        </div>
                        <br />

                        <asp:GridView ID="grdtags" runat="server" CssClass="table table-hover table-striped"
                                      AutoGenerateColumns="False"  GridLines="None" OnRowDataBound="GridPremalinkTags_RowDataBound">
                            <EmptyDataTemplate>
                                No Tag Added
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Tag Name">
                                    <ItemTemplate>
                                        &nbsp;&nbsp;
                                        <asp:Label ID="lbltagname" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="95%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <img id="imgdelete" runat="server" src="../Images/delete.gif" style="cursor: pointer;" />
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
        <%--    <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Emotion
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">        
                       <%-- <p>Kindly Select the services that you want to have on your Website or blog. Select atleast one services</p>
                        <br />
                        <p>
                            <asp:CheckBox ID="CheckBox1" runat="server" Text="  Tags" Font-Bold="true" />
                        </p>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="Checkbox2" runat="server" style="display: inline-block;" /><label id="Label1" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Rate Tags in my Website/Blog</strong></p>
                                                                                                                                            </label>
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="Checkbox3" runat="server" style="display: inline-block;" /><label id="Label2" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Add New Tags in my Website/Blog</strong></p>
                                                                                                                                            </label>
                        
                        <br /><br/>
                       --%>
                        
                      <%--  <asp:GridView ID="grdemotion" runat="server" CssClass="table table-hover table-striped"
                                      AutoGenerateColumns="False"  GridLines="None" OnRowDataBound="GridPremalinkTags_RowDataBound">
                            <EmptyDataTemplate>
                                No Emotion Added
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        &nbsp;&nbsp;
                                        <asp:Label ID="lblemotion" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="95%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <img id="imgdelete" runat="server" src="../Images/delete.gif" style="cursor: pointer;" />
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="cursor-pointer" />
                        </asp:GridView>--%>

                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
        </div>
    </div> 
</asp:Content>