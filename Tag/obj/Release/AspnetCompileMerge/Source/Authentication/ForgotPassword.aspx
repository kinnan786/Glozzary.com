<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Tag.Authentication.ForgotPassword" %>
<html>
<head>
    <title></title>
    <script src="../Script/StandardJavascript.js"></script>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 70%; margin: 100px 120px;">
            <tr>
                <td style="text-align: center;">
                     <asp:TextBox ID="TxtEmail" class="form-control textbox" placeholder="Email" runat="server" Width="400px" MaxLength="50"
                        ValidationGroup="A" CausesValidation="True"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldUserName" runat="server" Text="*" ValidationGroup="A"
                        ControlToValidate="TxtEmail" ErrorMessage="Email Required" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtEmail"
                        ErrorMessage="Email not in correct format" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ValidationGroup="A">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: center;">
                    <br />
                    <asp:Label ID="lblemailexists" Visible="false" runat="server" Style="color: red;"></asp:Label>
                    <br />
                </td>
            </tr>
            <tr>
                <td style="text-align: center;">
                    <asp:Button ID="BtnSendPassword" runat="server" CssClass="simplebutton" Style="width: 150px;"
                        Text="Recover Password" OnClick="BtnLogin_Click" ValidationGroup="A" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>