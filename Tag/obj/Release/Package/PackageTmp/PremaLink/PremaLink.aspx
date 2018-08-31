<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ThreeLayerLayout.Master" AutoEventWireup="true" CodeBehind="PremaLink.aspx.cs" Inherits="Tag.PremaLink.PremaLink" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function SetSelectedValue(premalinkid, tagid) {
            $(document).ready(function () {
                $.ajax
                              ({
                                  type: "POST",
                                  url: "PremaLink.aspx/DeleteTag",
                                  data: "{'premalinkid': '" + premalinkid + "','tagid': '" + tagid + "'}",
                                  contentType: "application/json; charset=utf-8",
                                  dataType: "json",
                                  async: true,
                                  cache: false,
                                  success: function (msg) {
                                      window.location = window.location;
                                  },
                                  error: function (request, status, error) {
                                      alert(request.responseText);
                                  }
                              })
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

    <table style="border-collapse: collapse; padding: 0px; background-color: white; width: 100%; -webkit-border-radius: 15px;">
        <tr>
            <td style="width: 20%; height: 20px;"></td>
            <td style="width: 60%;" colspan="2"></td>
            <td style="width: 20%;"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 150px;">
                            <asp:Image runat="server" ID="imglnk" Width="200px" />
                        </td>
                        <td style="vertical-align: top; padding-left: 10px; font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-size: 12px;">
                            <asp:HyperLink ID="hperlnk" runat="server"></asp:HyperLink><br />
                            <hr />
                            <asp:Label ID="lbldescription" runat="server"></asp:Label><br />
                            <br />
                            <asp:Label ID="lbldate" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td></td>
        </tr>
        <tr>
            <td><span id="tagsdfsspan" class="pht" style="opacity: 1; position: relative; padding: 10px; left: 190px;">Add / Search Tag</span>
            </td>

            <td style="text-align: center;">
                <span id="txttagspan" class="pht" style="opacity: 1; position: relative; left: 80px;">Search</span>
                <asp:TextBox ID="txttag" runat="server" onclick="clickfunction('txttagspan')" onblur="blurfunction('txttagspan','txttag')" Style="width: 300px;" />&nbsp;
                <asp:Button ID="btnadd" runat="server" Text="ADD" CssClass="simplebutton" OnClick="btnadd_Click" OnClientClick="return validate()" />
                <br />
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:GridView ID="GridPremalinkTags" runat="server" CellPadding="0" ForeColor="#333333"
                    Width="100%" AutoGenerateColumns="False"
                    OnRowDataBound="GridPremalinkTags_RowDataBound">
                    <EmptyDataTemplate>
                        No Website Added
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField HeaderText="Tag Name">
                            <ItemTemplate>
                                &nbsp;&nbsp;
                                <asp:Label ID="LnkTagName" CssClass="roundborder1" runat="server" Text=''></asp:Label>
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
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <HeaderStyle BackColor="#4c8f3d" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:GridView>
                <br />
                <br />
                <br />
            </td>
            <td></td>
        </tr>
    </table>
    <br />
    <br />
</asp:Content>