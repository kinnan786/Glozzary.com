<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ThreeLayerLayout.Master" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="Tag.MainPage" %>
<%@ Import Namespace="DTO" %>
<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function pagging() {
            $('div#divloading').show();
            $('div#loadmoreajaxloader').hide();
            $(document).ready(function () {
                $.ajax({
                    type: "GET",
                    url: "Pagging.aspx?flow=wall&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value,
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        if (msg != "") {
                            $("#postswrapper").append(msg);
                            $('div#loadmoreajaxloader').show();
                            $('div#nomoreajaxloader').hide();
                            document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                            $('div#divloading').hide();
                        } else {
                            $('div#loadmoreajaxloader').hide();
                            $('div#nomoreajaxloader').show();
                            $('div#divloading').hide();
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                });
            });
        }

        function RateEmotion(Id, rate, link) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "MainPage.aspx/RateEmotion",
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

        function voteTag(id, vote, pid) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "MainPage.aspx/voteTag",
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

        function checkCookie() {
            if (document.cookie.split('=')[2] != null) {
                return true;
            }
            else {
                return false;
            }
        }

        function opentagDeletePopup() {
            alert(" You cannot Delete Tag !!")
            <%--if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', 'TAG.aspx?flow=wall');
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = 'Default.aspx';--%>
        }

        function openTagAddPopup(link) {

            if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', 'TAG.aspx?flow=wall&Link=' + link);
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = 'Default.aspx';
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
                $('#iframemodalpopupusertag').attr('src', 'Emotion.aspx?flow=wall&Link=' + link);
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = 'Default.aspx';
        }

        function showbubble(ctr) {
            document.getElementById(ctr).style.display = "";
        }

        function hidebubble(ctr) {
            document.getElementById(ctr).style.display = "none";
        }
    </script>
    <table id="tbltable" style="width: 100%; padding-bottom: 100px; margin: 0px; vertical-align: top; border-collapse: collapse;">
        <tr>
            <td style="vertical-align: top; min-height: 800px; text-align: center; width: 700px;">

                <% if (lstdtonewsfeed != null && lstdtonewsfeed.Count > 0)
                   {
                       foreach (DtoNewsFeed item in lstdtonewsfeed)
                       {%>
                <br />
                <table id="postswrapper" style="width: 100%;">
                    <tr>
                        <td style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="vertical-align: top; width: 10%; text-align: right; padding-right: 10px;">
                                            
                                        <a href="Website/Website.aspx?WebsiteId=<%= item.WebsiteId %>">
                                            <% if (item.WebsiteImage.Length > 0 && item.WebsiteImage != "")
                                                   webimageurl = item.WebsiteImage;
                                               else
                                                   webimageurl = "Images/no-img-available-icons.jpg";
                                                   %>
                                            <img id="ImgWebsitelogo" style="width: 50px; height: 50px; border: none;" alt="No Image" src="<%= webimageurl %>" />
                                        </a>
                                    </td>
                                    <td style="width: 90%;padding-right: 20px;">
                                        <div class="roundborder1" style="width: 100%; padding: 10px;">
                                            <div style="text-align: left;">
                                                <a style="color: black; font-weight: bold; text-decoration: none; padding-top: 10px;" href="Website/Website.aspx?WebsiteId=<%= item.WebsiteId %>">
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
                               for (int i = 1; i < onetag.Count(); i++)
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
                               for (int i = 1; i < oneemo.Count(); i++)
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
                                                        <a id="lnkemo<%= emoid%>" style="cursor: pointer; color: white; text-decoration: none;" onclick="RateEmotion('<%= emoid%>','minus','<%= item.Link%>')">
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
                <%}%>
            </td>
        </tr>
    </table>
    <div style="padding-left: 360px; padding-top: 25px;">
        <div id="loadmoreajaxloader">
            <input id="anchorgettags" class="simplebutton" value="More" onclick="javascript: pagging();" />
        </div>
        <div id="divloading" style="display: none;">
            <img src="Images/loader.gif" />
        </div>
        <div id="nomoreajaxloader"  style="display: none;">
            <img src="Images/end.png" style="width: 80px;" />
        </div>
        <%}
                   else
                   {
                       if (flow != "explore")
                       {
        %>
        <br />
        <a href="Tag/Follow.aspx" style="position: relative; left: -100px;">
            <img src="Images/start.png" /></a>
        </td>
        </tr>
    </table>
    <%}
                       else
                       {%>
        <br /><br /><br />
        <div id="nomoreajaxloader" style="display: none;">
            <img src="Images/end.png" />
        </div>
    </div>
    <%}
                   }%>
    <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupusertag" style="display: none;" />
    <UserControl:ModalPopup ID="ModalPopup4" runat="server" IframeName="iframemodalpopupusertag" ModalPopupButtonId="btnmodalpopupusertag" ModalPopupTitle="Search / ADD" ModalPopupHeight="400" ModalPopupWidth="700" />
    <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
</asp:Content>