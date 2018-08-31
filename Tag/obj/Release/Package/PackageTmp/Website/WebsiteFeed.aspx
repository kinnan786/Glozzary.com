<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebsiteFeed.aspx.cs" Inherits="Tag.Website.WebsiteFeed" %>
<%@ Import Namespace="DTO" %>

<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<html>
<head>
    <title></title>
    <script src="../Script/jquery-1.11.0.js"></script>
    <script src="../Script/StandardJavascript.js"></script>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <script type="text/javascript">

        function checkCookie() {
            if (document.cookie.split('=')[2] != null) {
                return true;
            }
            else {
                return false;
            }
        }

        function voteTag(id, vote, pid) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "UserFeed.aspx/voteTag",
                        data: "{'premalinkId':'" + pid + "' ,'TagId':'" + id + "','vote':'" + vote + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            if (msg.d != null) {
                                if (vote == "UpVote")
                                    document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) + 1;
                                else
                                    document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) - 1;
                            }
                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
            else {
                window.location = "Default.aspx";
            }
        }

        function RateEmotion(Id, rate, link) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "UserFeed.aspx/RateEmotion",
                        data: "{premalink :'" + link + "',EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus','" + link + "')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (i = 0 ; i < htm.children.length; i++) {
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
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
            else {
                window.location = "Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        function openTagAddPopup(link) {
            $(document).ready(function () {
                if (checkCookie()) {
                    parent.document.getElementById('iframemodalpopupusertag').src = '../TAG.aspx?flow=wall&Link=' + link;
                    parent.document.getElementById('btnmodalpopupusertag').click();
                } else
                    parent.window.location = 'Default.aspx';
            });
        }

        function openemoDeletePopup() {
            <%--  if (checkCookie()) {
                 $('#iframemodalpopupusertag').attr('src', 'Emotion.aspx?flow=wall');
                 document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = 'Default.aspx';--%>
            alert(" You cannot Delete Emotion !!")
        }

        function openemoAddPopup(link) {
            if (checkCookie()) {
                parent.document.getElementById('iframemodalpopupusertag').src = '../Emotion.aspx?flow=wall&Link=' + link;
                parent.document.getElementById('btnmodalpopupusertag').click();
            } else
                parent.window.location = 'Default.aspx';
        }

        function pagging() {
            $(document).ready(function () {
                $('div#divloading').show();
                $('div#loadmoreajaxloader').hide();
                $.ajax({
                    type: "GET",
                    url: "../Pagging.aspx?Id=<%=Convert.ToInt64(ViewState["UserID"]) %>&TagId=<%=TagId%>&EmoId=<%= EmoId %>&flow=website&WebsiteId=<%= Websiteid %>&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value,
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function (msg) {
                        if (msg != "") {
                            $("#postswrapper").append(msg);
                            $('div#loadmoreajaxloader').show();
                            $('div#nomoreajaxloader').hide();
                            document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                            $('div#divloading').hide();
                        }
                        else {
                            $('div#loadmoreajaxloader').hide();
                            $('div#nomoreajaxloader').show();
                            $('div#divloading').hide();
                        }
                        parent.window.resizeIframe(parent.document.getElementById('iframeWebsiteFeed'));
                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                    }
                })
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <div id="roundborder" style="margin-left: 40px;">
        <% if (Lstdtonewsfeed != null && Lstdtonewsfeed.Count > 0)
           {
               foreach (DtoNewsFeed item in Lstdtonewsfeed)
               {%>
        <table id="postswrapper" style="width: 100%;">
            <tr>
                <td style="width: 100%;">
                    <table style="width: 100%;">
                        <tr>
                            <td style="vertical-align: top; width: 10%; text-align: right; padding-right: 10px;">
                                <a href="javascript:window.parent.location='Website.aspx?WebsiteId=<%= item.WebsiteId %>'">
                                    <% if (item.WebsiteImage != "")
                                       {
                                           if (item.WebsiteImage.Length > 0)
                                           {
                                               Imageurl = item.WebsiteImage;
                                           }
                                       }
                                       else
                                       {
                                           Imageurl = "../Images/no-img-available-icons.jpg";
                                       }
                                    %>
                                    <img id="ImgWebsitelogo" style="width: 50px; height: 50px; border: none;" alt="No Image" src="<%= Imageurl %>" />
                                </a>
                            </td>
                            <td style="width: 90%;padding-right: 10px;">
                                <div class="roundborder1" style="width: 100%; padding: 10px;">
                                    <div style="text-align: left;">
                        <a style="color: black; font-weight: bold; text-decoration: none; padding-top: 10px;" href="javascript:window.parent.location='Website.aspx?WebsiteId=<%= item.WebsiteId %>'">
                            <%= item.WebsiteName %>
                        </a>
                    </div>
                                    <br />
                                    <%if (item.Title != "")
                                      {%>
                                    <div class="title">
                                        <a style="color: black;" id="anch<%= item.PremalinkId%>" href="Javascript:window.open('<%= item.Link%>','_blank')"><%= item.Title%></a>
                                    </div>
                                    <%}%>
                                    <div class="dateclass">
                                        <a style="color: black;"><%= item.CreatedOn.ToString("MMMM dd, yyyy")%></a>
                                    </div>
                                    <%
                   if (item.Description != "")
                   {%>
                                    <div class="description" style="color: black;">
                                        <%= item.Description%>
                                    </div>
                                    <%}
                           if (item.Image != "")
                           {%>
                                    <br />
                                    <div>
                                        <a id='anch<%= item.PremalinkId%>' href="Javascript:window.open('<%= item.Link%>','_blank')">
                                            <img src="<%= item.Image%>" class="roundborder1" style="width: 100%; height: 280px;" /></a>
                                    </div>
                                    <%}%>
                                    <ul id="divtag" class="unorderlist">
                                        <%
                           int icell = 0;
                           string tagids, tagname, totalvote, firstname, secondname;

                           string[] onetag = item.Tagstring.Split('|');

                           if (onetag.Length > 1)
                           {
                               for (int i = 0; i < onetag.Count() - 1; i++)
                               {
                                   firstname = "";
                                   secondname = "";

                                   string[] n = onetag[i].Split(',');
                                   tagids = n[0];
                                   tagname = n[1];
                                   totalvote = n[2];

                                   int len = (tagname.Length) / 2;

                                   for (int j = 0; j < len; j++)
                                       firstname += tagname[j];

                                   for (int x = len; x < tagname.Length; x++)
                                       secondname += tagname[x];
                                        %><li style="display: inline-block;">
                                            <span id="span<%= tagids %>" style="display: none;" class="PinItCount">
                                                <span id="div<%= tagids %>" class="CountBubble"><%= totalvote %></span>
                                            </span>
                                            <br />
                                            <span class="checkoutbutton" onmouseover="showbubble(&quot;span<%= tagids %>&quot;)" onmouseout="hidebubble(&quot;span<%= tagids %>&quot;)">
                                                <a id="anchordown<%= tagids %>" class="downVote" title="Down Vote" onclick="voteTag('<%= tagids%>','DownVote','<%= item.PremalinkId%>')">#  &nbsp;&nbsp;&nbsp;<%= firstname%></a><a id="anchorup<%= tagids%>" title="Up Vote" class="upVote" onclick="voteTag('<%= tagids%>','UpVote','<%= item.PremalinkId%>')"><%= secondname%>&nbsp;&nbsp;&nbsp;</a>
                                            </span>
                                        </li>
                                        <%}
                           }
                           else
                           {%>
                                        <li style="display: inline-block;">
                                            <span class="checkoutbutton1">
                                                <a onclick="javascript: alert(&quot;No Tags :( &quot;);">No Tags :( </a>
                                            </span>
                                        </li>
                                        <% }%>
                                    </ul>
                                    <br />
                                    <div style="padding: 0px; border-bottom: 1px solid #ecf9d4; z-index: 10; text-align: left; position: relative; top: -15px;">
                                        <a id="Minusanchor2" title="Remove" style="cursor: pointer;" onclick='opentagDeletePopup()'>
                                            <img src="../Images/minus_red.png" />
                                        </a>
                                        <a id="addanchor" title="Add" style="float: right; cursor: pointer;" onclick="openTagAddPopup('<%= item.Link%>')">
                                            <img src="../Images/plus.png" /></a>
                                    </div>
                                    <ul id="divemo" class="unorderlist">
                                        <%
                           string emoid, emoname, emototalvote, taggedby;
                           string[] oneemo = item.EmotionString.Split('|');

                           if (oneemo.Length > 1)
                           {
                               for (int i = 0; i < oneemo.Count() - 1; i++)
                               {
                                   string[] n = oneemo[i].Split(',');
                                   emoid = n[0];
                                   emoname = n[1];
                                   emototalvote = n[2];
                                   taggedby = n[3];

                                   if (taggedby.ToLower() == "true")
                                   { %>
                                        <li style="display: inline-block;">
                                            <span class="PinItCount">
                                                <span id="divemo<%=emoid%>" class="CountBubble"><%= emototalvote%></span>
                                            </span>
                                            <br />
                                            <span class="checkoutbutton">
                                                <a id="lnkemo<%= emoid%>" style="cursor: pointer; color: white;" onclick="RateEmotion('<%= emoid%>','minus','<%= item.Link%>')">
                                                    <img id="imgemo<%= emoid%>" src="../Images/tagclose.png" />
                                                    <%=emoname%>
                                                </a>
                                            </span>
                                        </li>
                                        <%}
                                   else
                                   {%>
                                        <li style="display: inline-block;">
                                            <span class="PinItCount">
                                                <span id="divemo<%=emoid%>" class="CountBubble"><%= emototalvote%></span>
                                            </span>
                                            <br />
                                            <span class="checkoutbutton">
                                                <a id="lnkemo<%= emoid%>" style="cursor: pointer; color: white;" onclick="RateEmotion('<%= emoid%>','plus','<%= item.Link%>')">
                                                    <%=emoname%>
                                                </a>
                                            </span>
                                        </li>
                                        <%}
                               }
                           }
                           else
                           {
                                        %>
                                        <li style="display: inline-block;">
                                            <span class="checkoutbutton1">
                                                <a onclick="javascript: alert(&quot;No Emotions :( &quot;);">No Emotions :( </a>
                                            </span>
                                        </li>

                                        <%} %>
                                    </ul>
                                    <br />
                                    <div style="padding: 0px; margin: 0px; border-bottom: 1px solid #ecf9d4; text-align: left; position: relative; top: -15px;">
                                        <a id="Minusanchor" title="Remove" style="color: white;" onclick='openemoDeletePopup()'>
                                            <img src="../Images/minus_red.png" />
                                        </a>
                                        <a id="addanchor2" title="Add" style="float: right; color: white;" onclick="openemoAddPopup('<%= item.Link %>')">
                                            <img style="cursor: pointer;" src="../Images/plus.png" /></a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <%}
           }%>
             </div>

        <div style="padding-left: 360px; padding-top: 25px;">
            <div id="loadmoreajaxloader">
                <input id="anchorgettags" class="simplebutton" value="More" onclick="javascript: pagging();" />
            </div>
            <div id="divloading" style="text-align: center; display: none;" class="profile-buttons">
                <img src="../Images/loader.gif" />
            </div>
            <div id="nomoreajaxloader" style="display: none;">
                <img src="../Images/end.png" style="width: 80px;" />
            </div>
        </div>
        <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
    </form>
</body>
</html>
