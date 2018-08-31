<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditGeneralInfo.aspx.cs" Inherits="Tag.User.EditGeneralInfo" %>

<html>
<head>
    <title></title>
    <script src="../Script/StandardJavascript.js"></script>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <link href="../bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript">
        function HidePopup() {
            parent.form1.submit();
            parent.disablePopup();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <br />
        <table style="width: 100%;">
            <tr>
                <td style="width: 20%;"></td>
                <td style="width: 80%;">
                    <input type="text" id="TxtFname" placeholder="First Name" runat="server" class="textbox" style="width: 500px;" />&nbsp;
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="text" id="TxtLname" runat="server" style="width: 500px;" class="textbox" placeholder="Last Name" />
                &nbsp;
            </tr>
            <%--<tr>
                <td >Email</td>
                <td>
                    <asp:TextBox ID="TxtEmail" runat="server" ValidationGroup="A"></asp:TextBox>
                    <br />
        <asp:RegularExpressionValidator
            ID="RegularExpressionValidator1" runat="server"
                ErrorMessage="Email Not in correct format" ControlToValidate="TxtEmail"
                ForeColor="Red" SetFocusOnError="True"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                ValidationGroup="A"></asp:RegularExpressionValidator>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ErrorMessage="Cannot Be Empty" ControlToValidate="TxtEmail"
                ForeColor="Red" ValidationGroup="A"></asp:RequiredFieldValidator>
                </td>
            </tr>--%>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Label ID="LblEmailExsits" runat="server" Text="Email Already Exsists"
                        Visible="False" ForeColor="Red"></asp:Label><br />
                    <asp:Label ID="LblChangesSaved" runat="server" Text="Changes Saved"
                        Visible="False" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click" Style="margin: 60px;" CssClass="simplebutton"
                        ValidationGroup="A" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>