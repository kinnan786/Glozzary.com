<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ThreeLayerLayout.Master" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="Tag.User.Setting" %>
<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function checkEmail() {
            var email = document.getElementById('<%= TxtEmail.ClientID %>');
            var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

            if (!filter.test(email.value)) {
                alert('Please provide a valid email address');
                email.focus();
                return false;
            }
        }

        function checkCookie() {
            if (document.cookie.split('=')[2] != null) {
                return true;
            } else {
                return false;
            }
        }

        function openEditPopup(flow) {
            if (checkCookie()) {
                $('#iframemodalpopupedituser').attr('src', 'ProviderImage.aspx?flow=' + flow);
                document.getElementById('<%= btnmodalpopupuseredit.ClientID %>').click();
            } else
                window.location = '../Default.aspx';
        }

        function openEditPassword() {
            if (checkCookie()) {
                $('#iframemodalpopupedituser').attr('src', 'EditPassword.aspx');
                document.getElementById('<%= btnmodalpopupuseredit.ClientID %>').click();
            } else {
                alert("Not Logged In");
            }

            return false;
        }
    </script>
    <div style="padding-left: 250px; padding-top: 50px;">
        <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupuseredit" style="display: none;" />
        <UserControl:ModalPopup ID="ModalpopuEdit" runat="server" IframeName="iframemodalpopupedituser" ModalPopupButtonId="btnmodalpopupuseredit" ModalPopupTitle="Edit User" ModalPopupHeight="400" ModalPopupWidth="700" />
    </div>
    <%----%>
         
    <table style="width: 100%;">
        <tr>
            <td>
                <img id="profileimg" style="cursor: pointer; height: 200px; left: 0px; top: 0px; width: 200px;" title="Click Image to Edit" onclick=" openEditPopup('profilephoto'); " src="<%= dtouser.ImageUrl %>" />            
            </td>
            <td>
                <input type="text" maxlength="30" id="TxtFname" class="form-control textbox" placeholder="First Name" runat="server" style="width: 300px;" /><br/>
                <input type="text" maxlength="30" id="TxtLname" runat="server" class="form-control textbox" placeholder="Last Name" style="width: 300px;" /><br/>
                <input type="text" maxlength="50" id="TxtEmail" disabled="disabled" class="form-control textbox" placeholder="Email" runat="server" style="width: 300px;" />       
                <asp:Label ID="LblEmailExsits" runat="server" Style="color: red;" Visible="false">Email Already Exists</asp:Label><br />
                <br/>
                <asp:Button ID="btncancel" runat="server" class="simplebutton" OnClick="btncancel_Click" Text="Cancel" />
                <asp:Button ID="btnchangepassword" runat="server" class="simplebutton" style="width: 150px;" OnClientClick=" return openEditPassword(); " Text="Change Password" />
                <asp:Button ID="btnsave" runat="server" class="simplebutton" Text="Save" OnClientClick=" return checkEmail(); " OnClick="btnsave_Click" />
   
            </td>
        </tr>
    </table>
    <br/>
    <%--<div style="text-align: center; width: 100%;">
        <asp:Button ID="lnkwebsitesettings" runat="server" Text="New Website / Blog" PostBackUrl="~/Setting/WebsiteSetting.aspx" CssClass="simplebutton" Style="width: 190px;" />
    </div>
    <br/>
    <div style="padding: 50px;">
        <asp:GridView ID="GriduserWebsie" runat="server" CellPadding="0" ForeColor="#333333" Style="border-collapse: collapse; color: #141823; font-family: Helvetica, Arial, 'lucida grande', tahoma, verdana, arial, sans-serif; font-size: 12px; width: 100%;"
                      AutoGenerateColumns="False">
            <Columns>
                <asp:TemplateField HeaderText="WebSite Name">
                    <ItemTemplate>
                        <asp:LinkButton ID="LnkWebsiteName" runat="server" PostBackUrl='<%# Eval("WebsiteID", "../Setting/WebsiteSetting.aspx?WebsiteID={0}") %>'
                                        Text='<%# Eval("WebSiteName") %>'></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website URL">
                    <ItemTemplate>
                        <asp:Label ID="LblWebsiteURL" runat="server" Text='<%# Eval("WebsiteURL") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="20px" />
                </asp:TemplateField>
            </Columns>
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <HeaderStyle BackColor="#4c8f3d" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        </asp:GridView>
    
    </div>--%>
</asp:Content>