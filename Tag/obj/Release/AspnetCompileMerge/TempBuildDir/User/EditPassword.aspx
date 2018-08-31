<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditPassword.aspx.cs" Inherits="Tag.User.EditPassword" %>

<html>
<head>
    <title>Change Password</title>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <script src="../Script/StandardJavascript.js"></script>
    <link href="../bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td style="width: 100%; text-align: center; padding: 0px; margin: 0px;">
                    <asp:TextBox ID="TxtCurrent" CssClass="textbox" placeholder="Current Password" runat="server" TextMode="Password" MaxLength="30" Style="width: 300px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="TxtCurrent" ErrorMessage="Cannot Be empty" ForeColor="Red"
                        ValidationGroup="A">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; text-align: center; padding: 0px; margin: 0px;">
                    <br />
                    &nbsp;&nbsp;<asp:TextBox ID="TxtNew" runat="server" TextMode="Password" ValidationGroup="A" CssClass="textbox" placeholder="New Password" MaxLength="30" Style="width: 300px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="TxtNew" ErrorMessage="Cannot Be empty" ForeColor="Red"
                        ValidationGroup="A">*</asp:RequiredFieldValidator>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Password must consists of at least 8 characters and not more than 15 characters." runat="server" ForeColor="Red" Text="*" ValidationGroup="A" ControlToValidate="TxtNew" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; text-align: center; padding: 0px; margin: 0px;">
                    <br />
                    <asp:TextBox ID="TxtRetypeNew" runat="server" TextMode="Password" CssClass="textbox" placeholder="Retype Password" MaxLength="30" Style="width: 300px;">
                ValidationGroup="A"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="TxtRetypeNew" ErrorMessage="Cannot Be Empty"
                        ValidationGroup="A">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; text-align: center; padding: 0px; margin: 0px;">
                    <asp:CompareValidator ID="CompareValidator1" runat="server"
                        ControlToCompare="TxtNew" ControlToValidate="TxtRetypeNew"
                        ErrorMessage="Password Does Not match" ForeColor="Red" ValidationGroup="A"></asp:CompareValidator><br />
                    <asp:Label ID="LblPassworderror" runat="server" Visible="False"
                        Text="Current Password Not Match" ForeColor="Red"></asp:Label><br />
                    <asp:Label ID="LblPasswordChanged" runat="server" Visible="False"
                        Text="Password Changed" ForeColor="Red"></asp:Label>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="A" ForeColor="Red" />

                </td>
            </tr>
        </table>
        <div style="height: 16.43px; padding: 15px; border-top: 1px solid #e5e5e5; float: right; vertical-align: bottom; text-align: right; width: 100%">
            <asp:Button ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click" CssClass="simplebutton"
                ValidationGroup="A" />
        </div>
    </form>
</body>
</html>