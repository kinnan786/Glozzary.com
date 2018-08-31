<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RateableTag.aspx.cs" Inherits="Tag.RateableTag" %>
<!DOCTYPE html>
<html>
    <head runat="server">
        <title></title>
        <link href="Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
        <script src="Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
        <script type="text/javascript">
            function Maketaghtml() {
                var hdntags = (document.getElementById("hdnrateabletag").value).split('|');
                document.getElementById("divratetag").innerHTML = "";
                var table = document.getElementById("divratetag");
                if (hdntags != "" && hdntags.length > 1) {
                    for (var i = 1; i < hdntags.length; i++) {
                        var ontag = hdntags[i].split(',');
                        if (ontag[3] > 0) {
                            table.innerHTML +=
                                "<li style='display:inline-block;'><span id='span" + ontag[1] + "' style='display: block;' class='PinItCount'>" +
                                "<span id='div" + ontag[1] + "' class='CountBubble'>" + ontag[2] + "</span></span>" +
                                "<span class='checkoutbutton'><img id='img" + ontag[1] + "' src='http://www.glozzary.com/Images/tagclose.png' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;DownVote&quot;)'/>&nbsp;" +
                                "<a id='anchordown" + ontag[1] + "' >" + ontag[0] + "</a></span></li>&nbsp;&nbsp;";
                        } else {
                            table.innerHTML +=
                                "<li style='display:inline-block;'><span id='span" + ontag[1] + "' style='display: block;' class='PinItCount'>" +
                                "<span id='div" + ontag[1] + "' class='CountBubble'>" + ontag[2] + "</span></span>" +
                                "<span class='checkoutbutton'><a id='anchordown" + ontag[1] + "' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;UpVote&quot;)'>" + ontag[0] + "</a></span></li>&nbsp;&nbsp;";
                        }
                    }
                }
            }

            function checkCookie() {
                if (document.cookie.split('=')[2] != null) {
                    return true;
                } else {
                    return false;
                }
            }

        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <ul id="divratetag" class="unorderlist">
            </ul>
            <input id="hdnrateabletag" type="hidden" runat="server" value="" />
        </form>
        <script type="text/javascript">

            function voteTag(id, vote) {
                if (checkCookie()) {
                    $(document).ready(function() {
                        $.ajax({
                            type: "POST",
                            url: "RateableTag.aspx/VoteTag",
                            data: "{'premalink': '<%= Premalink %>','tagid':'" + id + "','vote':'" + vote + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function(msg) {
                                if (msg.d != -2) {
                                    if (vote == "UpVote")
                                        document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) + 1;
                                    else
                                        document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) - 1;
                                } else
                                    window.open("Authentication/PopUpLogin.aspx", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
                            },
                            error: function(request, status, error) {
                                alert(request.responseText);
                            }
                        });
                    });
                } else {
                    window.open("Authentication/PopUpLogin.aspx", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
                }
            }

            window.onload = function() {
                Maketaghtml();
            };

        </script>
    </body>
</html>