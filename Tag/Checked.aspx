<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checked.aspx.cs" Inherits="Tag.Checked" %>
<html>
    <head>
        <title></title>
        <link href="Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
        <script src="Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
        <script type="text/javascript" lang="javascript">

            function showbubble(ctr) {
                document.getElementById(ctr).style.display = "";
            }

            function hidebubble(ctr) {
                document.getElementById(ctr).style.display = "none";
            }

            function opennewtab() {
                window.open("http://www.glozzary.com/Developer.aspx", '_blank');
            }

            var d = new Date();
            var t = d.getMinutes();

            var myVar = window.setInterval(function() {
                checkpagestatus();
            }, 5000);

            function myStopFunction() {
                clearInterval(myVar);
            }

            function checkpagestatus() {
                d = new Date();
                if (document.readyState == "complete") {
                    myStopFunction();
                    document.getElementById('loadmoreajaxloader').style.display = "none";
                    document.getElementById('tablekinnannawa').style.display = "block";
                    document.getElementById('somethingwentwrong').style.display = "none";
                }

                if ((d.getMinutes() - t) > 2 && document.readyState != "complete") {
                    myStopFunction();
                    document.getElementById('somethingwentwrong').style.display = "block";
                    document.getElementById('loadmoreajaxloader').style.display = "none";
                    document.getElementById('tablekinnannawa').style.display = "none";
                }
            }

            window.onload = function() {
                Maketaghtml();
            };

            function openwebsitetag(tagid, webid) {
                window.open('/Tag/TagViewer.aspx?flow=inlinecode&Id=' + tagid + '&WebsiteId=' + webid, '_blank');
            }

            function GetTag() {
                $(document).ready(function() {
                    $.ajax
                    ({
                        type: "POST",
                        url: "Checked.aspx/GetTag",
                        data: "{'websitename': '" + parent.document.Websitename_shortname + "','premalink': '" + location.href + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            document.getElementById("hdntag").value += msg.d;
                            Maketaghtml();
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    });
                });
            }

            function GetEmotion() {
                $(document).ready(function() {
                    $.ajax
                    ({
                        type: "POST",
                        url: "Checked.aspx/GetEmotion",
                        data: "{'websitename': '" + parent.document.Websitename_shortname + "','premalink': '" + location.href + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            document.getElementById("hdnemo").value += msg.d;
                            Maketaghtml();
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    });
                });
            }

            function RateEmotion(Id, rate, link) {
                if (checkCookie()) {
                    $(document).ready(function() {
                        $.ajax({
                            type: "POST",
                            url: "Checked.aspx/RateEmotion",
                            data: "{premalink :'" + link + "',EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function(msg) {
                                if (msg.d != null) {
                                    if (msg.d > 0) {
                                        if (rate == 'plus') {
                                            document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1;
                                            $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo" + Id + "' src='Images/tagclose.png'>");

                                            $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                            $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus','" + link + "')");

                                        } else {
                                            document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1;

                                            var htm = document.getElementById("lnkemo" + Id);
                                            console.log(htm);

                                            for (var i = 0; i < htm.children.length; i++) {
                                                console.log(htm.children[i].nodeName.toUpperCase());
                                                if (htm.children[i].nodeName.toUpperCase() == "IMG")
                                                    htm.removeChild(htm.children[i]);
                                            }
                                            $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                            $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','plus','" + link + "')");
                                        }
                                    }
                                }
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

            function voteTag(id, vote) {
                if (checkCookie()) {
                    $(document).ready(function() {
                        $.ajax({
                            type: "POST",
                            url: "Checked.aspx/voteTag",
                            data: "{'premalink': '<%= Premalink %>','TagId':'" + id + "','vote':'" + vote + "'}",
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

            function Maketaghtml() {

                var hdntags = (document.getElementById("hdntag").value).split('|');
                var hdnemo;
                document.getElementById("divtag").innerHTML = "";

                <% if (Emotionflag)
                   { %>

                hdnemo = (document.getElementById("hdnemo").value).split('|');
                document.getElementById("divemo").innerHTML = "";
                
                <% } %>

                var te = 0;
                var icell = 0;
                var irow = 0;
                var table;

                <% if (Emotionflag)
                   { %>

                table = document.getElementById("divemo");

                if (hdnemo != "" && hdnemo.length > 1) {
                    for (var i = 1; i < hdnemo.length; i++) {
                        var onemo = hdnemo[i].split(',');
                        var row, col;
                        var len = parseInt(Math.floor((onemo[0].length) / 2));
                        var tagvote = 0;

                        var ht = "<li style='display:inline-block;'><span style='display: none;' class='PinItCount'><span id='divemo" + onemo[1] + "' class='CountBubble'>" + onemo[2] + "</span></span><br/><span class='checkoutbutton' style='cursor:hand;'><a id='lnkemo" + onemo[1] + "' style='text-decoration:none;' ";

                        if (onemo[3] == 'True')
                            ht += "onclick=RateEmotion('" + onemo[1] + "','minus','<%= Premalink %>') >&nbsp;&nbsp;";
                        else
                            ht += "onclick=RateEmotion('" + onemo[1] + "','plus','<%= Premalink %>') >&nbsp;&nbsp;";

                        if (onemo[3] == 'True')
                            ht += "<img id='imgemo" + onemo[1] + "' src='http://www.glozzary.com/Images/tagclose.png' />";

                        ht += onemo[0] + "&nbsp;&nbsp;</a></span></li>";

                        table.innerHTML += ht;
                    }
                } else {

                    table.innerHTML += "<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='javascript: alert(&quot;No Emotions :( &quot;);'>No Emotions :( </a></span></li>&nbsp;<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='opennewtab();'>Check Meta Chars</a></span></li>&nbsp;<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='openAddemoPopup()'> Add New Emotion :) </a></span></li>";
                }

                <% } %>

                table = document.getElementById("divtag");

                if (hdntags != "" && hdntags.length > 1) {
                    for (i = 1; i < hdntags.length; i++) {
                        var ontag = hdntags[i].split(',');

                        <% if (Convert.ToBoolean(ViewState["rateTag"]))
                           { %>

                        var len = parseInt(Math.floor((ontag[0].length) / 2));
                        var first = second = "";
                        var tagvote = 0;

                        for (var x = 0; x < len; x++) {
                            first += String(ontag[0][x]);
                        }

                        for (var j = len; j < ontag[0].length; j++) {
                            second += String(ontag[0][j]);
                        }

                        table.innerHTML += "<li style='display:inline-block;'><span id='span" + hdntags[i].split(',')[1] + "' style='display: none;' class='PinItCount'><span id='div" + hdntags[i].split(',')[1] + "' class='CountBubble'>" + hdntags[i].split(',')[2] + "</span></span><br/><span class='checkoutbutton' onmouseover='showbubble(&quot;span" + hdntags[i].split(',')[1] + "&quot;)' onmouseout='hidebubble(&quot;span" + hdntags[i].split(',')[1] + "&quot;)'><a id='anchordown" + hdntags[i].split(',')[1] + "' class='downVote' title='Down Vote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchor'" + ontag[1] + " title='Up Vote' class='upVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span></li>";
                        first = "";
                        second = "";

                        <% }
                           else if (Convert.ToBoolean(ViewState["rateTag"]) == false)
                           { %>
                        
                        table.innerHTML += "<li style='display:inline-block;'><span class='checkoutbutton'><a id='anchor" + ontag[1] + "' style='text-decoration:none;' href='javascript:openwebsitetag(" + ontag[1] + ",<%= Convert.ToInt64(ViewState["websiteid"]) %>)'>&nbsp;&nbsp;" + ontag[0] + "&nbsp;&nbsp;</a></span></li>";

                        <% } %>
                    }

                } else {
                    table.innerHTML += "<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='javascript: alert(&quot;No Tags :( &quot;);'>No Tags :( </a></span></li>&nbsp;<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='opennewtab();'>Check Meta Chars</a></span></li>&nbsp;<li style='display:inline-block;'><span class='checkoutbutton1'><a onclick='openAddPopup()'> Add New Tags :) </a></span></li>";
                }
            }

            function checkCookie() {
                if (document.cookie.split('=')[2] != null) {
                    return true;
                } else {
                    return false;
                }
            }

            function openAddPopup() {
                if (checkCookie())
                    window.open("TAG.aspx?flow=inlinecode&WebsiteName=<%= Request.QueryString["Websitename"] %>&Premalink=<%= Request.QueryString["url"] %>", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
                else
                    window.open("Authentication/PopUpLogin.aspx", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
            }

            function openAddemoPopup() {
                if (checkCookie())
                    window.open("Emotion.aspx?flow=inlinecode&WebsiteName=<%= Request.QueryString["Websitename"] %>&Premalink=<%= Request.QueryString["url"] %>", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
                else
                    window.open("Authentication/PopUpLogin.aspx", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
            }

            function openDeletePopup() {
                alert("Currently Delete is Not supported !!!");
            }
        </script>
    </head>
    <body style="margin: 0; padding: 0;">
        <form id="checkform" method="get" runat="server" style="margin: 0; padding: 0; vertical-align: top;">
            <div id="loadmoreajaxloader" style="height: 50px; text-align: center;">
                <img src="Images/loader.gif" />
            </div>
            <div id="somethingwentwrong" style="display: none; height: 20px; text-align: center;">
                Something went wrong taking alot of time. try again Later :(
            </div>
            <table id="tablekinnannawa" style="border-collapse: collapse; display: none; margin: 0; padding: 0; width: 100%;">
                <tr>
                    <td style="margin: 0; padding: 0; width: 5%;">
                        <a id="Minusanchor" runat="server" title="Remove" onclick='openDeletePopup()'>
                            <img src="Images/minus.png" style="cursor: pointer; position: relative; top: -5px;" /></a>&nbsp;&nbsp;
                    </td>
                    <td style="width: 90%;height:50px;">
                        <ul id="divtag" class="unorderlist">
                        </ul>
                    </td>
                    <td style="width: 5%;">
                        <a id="addanchor" runat="server" title="Add" onclick='openAddPopup()'>&nbsp;&nbsp;
                            <img src="Images/add.png" style="cursor: pointer; position: relative; top: -5px;" /></a>
                        <input id="hdntag" type="hidden" runat="server" value="" /></td>
                </tr>
                <% if (Emotionflag)
                   { %>
                    <tr>
                        <td style="margin: 0; padding: 0; width: 5%;">
                            <a id="deleteemoanchor" runat="server" title="Remove" onclick='openDeletePopup()'>
                                <img src="Images/minus.png" style="cursor: pointer; position: relative; top: -5px;" /></a>&nbsp;&nbsp;
                        </td>
                        <td style="width: 90%;height:50px;">
                            <ul id="divemo" class="unorderlist">
                            </ul>
                        </td>
                        <td style="width: 5%;">
                            <a id="addemoanchor" runat="server" title="Add" onclick='openAddemoPopup()'>&nbsp;&nbsp;
                                <img src="Images/add.png" style="cursor: pointer; position: relative; top: -5px;" /></a>
                        </td>
                    </tr>
                <% } %>
            </table>
            <input id="hdnemo" type="hidden" runat="server" value="" />
        </form>
    </body>
</html>