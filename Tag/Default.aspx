<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tag.Default" %>

<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<html>
<head>
    <title>Glozzary</title>
    <link rel="shortcut icon" href="Images/icon.ico" />
    <link href="Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <script src="Script/StandardJavascript.js"></script>
    <link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="bootstrap-3.2.0-dist/css/bootstrap-theme.min.css" rel="stylesheet" />
    <script type="text/javascript">

        function openPopup() {
            if (!checkCookie()) {
                $('#iframemodalpopupuserlogin').attr('src', 'Authentication/PopUpLogin.aspx?prevurl=' + window.location);
                <%--document.getElementById('<%=userlogin.ClientID %>').ModalPopupTitle = title;--%>
                document.getElementById('btnmodalpopupuserlogin').click();
            } else
                window.location = '../Default.aspx';
            return false;
        }

        function checkCookie() {
            if (document.cookie.split('=')[2] != null) {
                return true;
            }
            else {
                return false;
            }
        }

        function openexplore() {
            if (document.getElementById('<%= Txtexplore.ClientID %>').value.length > 2) {
                window.location.href = "Explore.aspx?flow=search&search=" + document.getElementById('<%= Txtexplore.ClientID %>').value + "&PageNo=1";
                return false;
            }
            else {
                alert("No Value given or the length is less than 2 characters");
                return false;
            }
        }
    </script>
</head>
<body style="border-collapse: collapse; border: 0; min-height: 525px; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; background-color: #ecf9d4;">
    <form id="form2" runat="server">
        <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupuserlogin" style="display: none;" />
        <UserControl:ModalPopup ID="userlogin" runat="server" IframeName="iframemodalpopupuserlogin" ModalPopupButtonId="btnmodalpopupuserlogin" ModalPopupTitle="Login / Sign Up" ModalPopupHeight="400" ModalPopupWidth="700" />
        <table border="0" style="border-collapse: collapse; width: 100%; border: 0; min-height: 525px; vertical-align: top; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px;">
            <tr>
                <td style="box-shadow: 0px 0px 10px #666; background-image: url('../Images/background.png'); width: 100%; position: fixed; color: White; height: 50px; z-index: 2; opacity: 0.8;"
                    colspan="3">
                    <div class="menuclass" style="text-align: right; padding-top: 5px; z-index: 100; text-align: left;">
                        <span><a href="MainPage.aspx">
                            <img src="Images/Logo.png" /></a></span>
                        <div style="text-align: right; position: relative; top: -70px;">
                            <input type="button" id="btnlogin" class="simplebutton" value="Start" onclick="return openPopup();" />&nbsp;&nbsp;
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width: 20%;"></td>
                <td style="width: 60%;">
                    <div style="text-align: center;">
                        <div class="form-group">
                            <asp:TextBox ID="Txtexplore" runat="server" Width="500px" MaxLength="50" class="form-control textbox" placeholder="Search All Tags & Website"></asp:TextBox>
                            <asp:Button ID="btnsearch" runat="server" Text="Search" class="simplebutton" OnClientClick="return openexplore();" />
                        </div>
                    </div>
                </td>
                <td style="width: 20%;"></td>
            </tr>
            <tr>
                <td colspan="3" >
                    <div style="padding: 5px; margin: 0px; text-align: center;">
                        <div>
                            <a style=" text-decoration: none;color: black; " href="https://www.facebook.com/pages/Glozzary/686084914801723?fref=ts" title="Facebook Page" target="_blank">
                                <img src="Images/facebook.png" style="height: 50px; width: 50px;" />
                            </a>
                            <a style=" text-decoration: none;color: black; " href="https://twitter.com/Glozzary" title="Twitter" target="_blank">
                                <img src="Images/twitter.png" style="height: 50px; width: 50px;" />
                            </a>
                            <a style=" text-decoration: none;color: black; " href="http://www.pinterest.com/Glozzary/" title="Pinterest" target="_blank">
                                <img src="Images/pinterest.png" style="height: 50px; width: 50px;" />
                            </a>
                        </div>
                        <a href="AboutUs.aspx">About Us</a>&nbsp;|&nbsp;<a href="ContactUs.aspx">Contact Us</a>&nbsp;|&nbsp;<a href="Developer.aspx">Developer</a>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>