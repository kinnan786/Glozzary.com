<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteTag.aspx.cs" Inherits="Tag.Tag.DeleteTag" %>

<html>
<head>
    <title></title>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/css/smoothness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
    <script src="../Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <script src="../Script/jquery-ui-1.10.4/jquery-ui-1.10.4.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            Maketaghtml();
        })

        $(document).ready(function () {
            alert("a")
        })

        function toggelTag(id) {
            id = "#" + id;
            if ($(id).hasClass("disable-tag")) {
                $(id).removeClass("disable-tag");
                $(id).addClass("post-tag");
            }
            else {
                $(id).removeClass("post-tag");
                $(id).addClass("disable-tag");
            }
        }

        function Maketaghtml() {
            alert("maketaghtml")
            var hdntags = (document.getElementById("hdntag").value).split('|');
            document.getElementById("tagdiv").innerHTML = "";

            alert(hdntags.length)
            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');
                    document.getElementById("tagdiv").innerHTML += "<span id='span" + ontag[1] + "' class='disable-tag'><input type='checkbox' id='chkid' runat='server' /><a id='anchor" + ontag[1] + "' onclick='toggelTag(&quot;span" + ontag[1] + "&quot;)' >" + ontag[0] + "</a></span>";
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table border="0" style="width: 100%; text-align: center;">
            <tr>
                <td>
                    <span id="tagdiv" runat="server"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="closewindow();" OnClick="btnSave_Click" />&nbsp;
                </td>
            </tr>
        </table>
        <input id="hdntag" type="hidden" runat="server" value="" />
    </form>
</body>
</html>