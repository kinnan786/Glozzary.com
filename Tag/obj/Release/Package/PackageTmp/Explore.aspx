<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/General.Master" AutoEventWireup="true" CodeBehind="Explore.aspx.cs" Inherits="Tag.Explore" %>
<%@ Import Namespace="DTO" %>

<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        function pagging() {
            $(document).ready(function () {
                $.ajax({
                    type: "GET",
                    url: "Pagging.aspx?flow=wall&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value,
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function (msg) {
                        if (msg != "") {
                            $("#postswrapper").append(msg);
                            $('div#loadmoreajaxloader').show();
                            $('div#nomoreajaxloader').hide();
                            document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                }
                else {
                    $('div#loadmoreajaxloader').hide();
                    $('div#nomoreajaxloader').show();
                }
            },
                    error: function (request, status, error) {
                        alert(request.responseText);
                    }
                })
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
                data: "{'premalinkId':'" + pid + "' ,'TagId':'" + id + "','vote':'" + vote + "','UserID':'" + getCookie("Tagged").split('=')[1] + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {
                    if (msg != null) {
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
        window.location = "Default.aspx?prevurl=" + document.forms[0].action;
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
    </script>
    <table id="tbltable" style="width: 100%; padding-bottom: 100px; margin: 0px; vertical-align: top; border-collapse: collapse;">
        <tr>
            <td style="vertical-align: top; min-height: 800px; text-align: center; width: 100%;">
                <% if (Lstdtonewsfeed != null && Lstdtonewsfeed.Count > 0)
                   {
                       foreach (DtoNewsFeed item in Lstdtonewsfeed)
                       {%>
                <table id="postswrapper" style="width: 100%;">
                    <tr>
                        <td style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 100%;">
                                        <div class="roundborder1" style="width: 100%; padding: 10px;">
                                            <br />
                                            <%if (item.Title != "")
                                              {%>
                                            <div class="title">
                                                <a id="anch<%= item.PremalinkId%>" href="Javascript:window.open('<%= item.Link%>','_blank')"><%= item.Title%></a>
                                            </div>
                                            <%}%>
                                            <div class="dateclass">
                                                <a><%= item.CreatedOn.ToShortDateString()%></a>
                                            </div>
                                            <%
                           if (item.Description != "")
                           {%>
                                            <div class="description">
                                                <%= item.Description%>
                                            </div>
                                            <%}
                           if (item.Image != "")
                           {%>
                                            <div>
                                                <a id='anch<%= item.PremalinkId%>' href="Javascript:window.open('<%= item.Link%>','_blank')">
                                                    <img src="<%= item.Image%>" style="width: 100%; height: 350px;" /></a>
                                            </div>
                                            <%}%>
                                            <table id="divtag" style="margin: 0px auto;">
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

                                   if (icell == 0 || icell == 10)
                                   {%>
                                                <tr>
                                                    <%}%>
                                                    <td>
                                                        <br />
                                                        <span class="PinItCount">
                                                            <span id="div<%= tagids%>" class="CountBubble"><%= totalvote%></span>
                                                        </span>
                                                        <div class="checkoutbutton">
                                                            <a id="anchordown<%= tagids%>" class="downVote" title="Down Vote" onclick="voteTag('<%= tagids%>','DownVote','<%= item.PremalinkId%>')">&nbsp;&nbsp;&nbsp;<%= firstname%></a><a id="anchorup<%= tagids%>" title="Up Vote" class="upVote" onclick="voteTag('<%= tagids%>','UpVote','<%= item.PremalinkId%>')"><%= secondname%>&nbsp;&nbsp;&nbsp;</a>
                                                        </div>
                                                    </td>
                                                    <% if (icell == 10)
                                                       {%>
                                                </tr>
                                                <%}
                                                       if (icell == 10)
                                                           icell = 0;
                                                       else
                                                           icell = icell + 1;
                                           }
                                       }
                                       else
                                       {%>

                                                <tr>
                                                    <td>
                                                        <div class="checkoutbutton1">
                                                            <a onclick="javascript: alert(&quot;No Tags :( &quot;);">No Tags :( </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <%}%>
                                            </table>
                                            <div style="padding: 0px; border-bottom: 1px solid #ecf9d4; text-align: left; margin: 0px; position: relative; top: -25px;">
                                                <a id="Minusanchor2" title="Remove" onclick='opentagDeletePopup()'>
                                                    <img src="Images/minus_red.png" />
                                                </a><a id="addanchor" title="Add" style="float: right;" onclick="openTagAddPopup('<%= item.Link%>')">
                                                    <img src="Images/plus.png" /></a>
                                            </div>
                                            <table id="divemo" style="border-collapse: collapse; border-spacing: 0px; margin: 0px auto; padding: 0px;">
                                                <tr>
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
                                                    <td>
                                                        <span class="PinItCount">
                                                            <span id="divemo<%=emoid%>" class="CountBubble"><%= emototalvote%></span>
                                                        </span>
                                                        <div class="checkoutbutton">
                                                            <a id="lnkemo<%= emoid%>" style="cursor: pointer;" onclick="RateEmotion('<%= emoid%>','minus','<%= item.Link%>')">
                                                                <img id="imgemo<%= emoid%>" src="Images/tagclose.png" />
                                                                <%=emoname%>
                                                            </a>
                                                        </div>
                                                    </td>
                                                    <%}
                                                        else
                                                        {%>
                                                    <td>
                                                        <span class="PinItCount">
                                                            <span id="divemo<%=emoid%>" class="CountBubble"><%= emototalvote%></span>
                                                        </span>
                                                        <div class="checkoutbutton">
                                                            <a id="lnkemo<%= emoid%>" style="cursor: pointer;" onclick="RateEmotion('<%= emoid%>','plus','<%= item.Link%>')">
                                                                <%=emoname%>
                                                            </a>
                                                        </div>
                                                    </td>
                                                    <%}
                                                    }
                                                }
                                                else
                                                {%>
                                                    <td>
                                                        <div class="checkoutbutton1">
                                                            <a onclick="javascript: alert(&quot;No Emotions :( &quot;);">No Emotions :( </a>
                                                        </div>
                                                    </td>

                                                    <%}%>
                                                </tr>
                                            </table>

                                            <div style="padding: 0px; border-bottom: 1px solid #ecf9d4; text-align: left; margin: 0px; position: relative; top: -25px;">
                                                <a id="Minusanchor" title="Remove" onclick='openemoDeletePopup()'>
                                                    <img src="Images/minus_red.png" />
                                                </a>
                                                <a id="addanchor2" title="Add" style="float: right;" onclick="openemoAddPopup('<%= item.Link %>')">
                                                    <img src="Images/plus.png" /></a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <%}
                   }
                   else
                   {
                       if (Flow != "explore")
                       {
                %>
                <br />
                <a href="Tag/Follow.aspx" style="position: relative; left: -100px;">
                    <img src="Images/start.png" /></a>

                <%}
                       else
                       {%>
                <a>No News Feed Found</a>
                <%}
                   }%>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div id="loadmoreajaxloader" style="text-align: center;" class="profile-buttons">
        <a class="button secondary" style="text-decoration: none;" href="javascript:pagging();">Get More News Feed</a>
    </div>
    <div id="nomoreajaxloader" style="display: none; font-size: medium; font-weight: bold; padding-top: 15px; color: black; text-align: center; height: 50px;">
        <a onclick="return false;">No More News Feed </a>
    </div>

    <br />
    <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupusertag" style="display: none;" />
    <UserControl:ModalPopup ID="ModalPopup4" runat="server" IframeName="iframemodalpopupusertag" ModalPopupButtonId="btnmodalpopupusertag" ModalPopupTitle="Search / ADD" ModalPopupHeight="400" ModalPopupWidth="700" />
    <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
</asp:Content>