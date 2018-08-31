<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModalPopup.ascx.cs" Inherits="Tag.UserControls.ModalPopup" %>
<script src="../Script/jquery-1.11.0.js"></script>
<link href="../bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="../Styles/StyleSheet2.css" rel="stylesheet" />
<script type="text/javascript">

    window.onload = function () {
        document.getElementById('popupControldialog<%= this.ID %>').style.left = (screen.width / 2) - (parseInt(<%= ModalPopupWidth%>) / 2);
        document.getElementById('popupControldialog<%= this.ID %>').style.top = ((screen.height / 2) - 150) - (parseInt(<%= ModalPopupHeight%>) / 2);
    }

    $(document).ready(function () {
        $("#<%= ModalPopupButtonId %>").click(function (e) {
            ShowDialog<%= this.ID %>();
        });

        $("#btnClose<%= this.ID %>").click(function (e) {
            HideDialog<%= this.ID %>();
            e.preventDefault();
        });
    });

    function ShowDialog<%= this.ID %>() {
        $("#popupControloverlay<%= this.ID %>").show();
        $("#popupControldialog<%= this.ID %>").fadeIn(100);
        $("#popupControldialog<%= this.ID %>").draggable().resizable();
    }

    function HideDialog<%= this.ID %>() {
        $("#<%= IframeName %>").src = "";
        $("#popupControloverlay<%= this.ID %>").hide();
        $("#popupControldialog<%= this.ID %>").fadeOut(100);
    }

    $(document).ready(function () {
        $("#popupControldialog<%= this.ID %>").resize(function () {
            setCookie("<%= this.ID %>texvitmodalPopupresolutionWidth", document.getElementById('popupControldialog<%= this.ID %>').style.width, 365);
            setCookie("<%= this.ID %>texvitmodalPopupresolutionHeight", document.getElementById('popupControldialog<%= this.ID %>').style.height, 365);
        });
    })

    $(document).ready(function () {
        var popupwidth<%= this.ID %> = getCookie("<%= this.ID %>texvitmodalPopupresolutionWidth");
        var popupheight<%= this.ID %> = getCookie("<%= this.ID %>texvitmodalPopupresolutionHeight");
        if (popupwidth<%= this.ID %> != null && popupwidth<%= this.ID %> != "") {
            document.getElementById('popupControldialog<%= this.ID %>').style.width = getCookie("<%= this.ID %>texvitmodalPopupresolutionWidth");
                document.getElementById('popupControldialog<%= this.ID %>').style.height = getCookie("<%= this.ID %>texvitmodalPopupresolutionHeight");
            }
    })

        function getCookie(c_name) {
            var i, x, y, ARRcookies = document.cookie.split(";");
            for (i = 0; i < ARRcookies.length; i++) {
                x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
                y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
                x = x.replace(/^\s+|\s+$/g, "");
                if (x == c_name) {
                    return unescape(y);
                }
            }
        }

        function setCookie(c_name, value, exdays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
            document.cookie = c_name + "=" + c_value;
        }
</script>
<div id="popupControloverlay<%= this.ID %>" class="web_dialog_overlay">
</div>
<div id="popupControldialog<%= this.ID %>" class="web_dialog">
    <div class="web_dialog_title" style="min-height: 16.43px; padding: 15px; border-bottom: 1px solid #e5e5e5;">
        <h4>
            <asp:Label ID="lbltitle" Style="margin: 0; line-height: 1.42857143;" runat="server"></asp:Label>
            <button id="btnClose<%= this.ID %>" type="button" class="close">
                <span>×</span>
                <span class="sr-only">Close</span>
            </button>
        </h4>
        <span style="float: right; display: none; position: relative; top: -10px; left: 10px;">
            <%--<input id="btnClose<%= this.ID %>" value="Cancel" type="image" src="../Images/close_button.png"
                name="image" />--%>
        </span>
    </div>
    <div style="padding: 20px;">
        <asp:Literal ID="ltrliframe" runat="server"></asp:Literal>
    </div>
</div>