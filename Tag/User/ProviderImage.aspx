<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProviderImage.aspx.cs" Inherits="Tag.User.ProviderImage" %>

<html>
<head>
    <title>Image
    </title>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <script type="text/javascript">
        function HidePopup() {
            parent.window.location = "Setting.aspx";
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" class="TableStyle">
            <tr>
                <td>&nbsp;</td>
                <td>
                    <br />
                    <asp:Image ID="ImgPic" ImageUrl="~/Images/nopic.png" runat="server" Height="300px" Width="400px" /></td>
                <td>Image/Logo<br />
                    <asp:FileUpload ID="ImgUpld" Width="250px" runat="server" />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td>
                    <asp:Button ID="BtnImgSave" CssClass="simplebutton" runat="server" Text="Save" OnClick="BtnImgSave_Click" />
                    <%-- <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="simplebutton" Visible="false" OnClick="BtnDelete_Click" />--%>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>