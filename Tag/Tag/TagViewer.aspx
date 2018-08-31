<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Member.Master" AutoEventWireup="true" CodeBehind="TagViewer.aspx.cs" Inherits="Tag.Tag.TagViewer" %>
<%@ Import Namespace="DTO" %>

<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--  <input type="button" id="BtnTagFollow" runat="server" style="width: 100px; z-index: 10;" class="simplebutton" value="Follow" />--%>
    <table style="width: 100%; padding: 0px; margin: 0px; vertical-align: top; border-collapse: collapse;">
        <tr>
            <td colspan="2" style="text-align: center; width: 100%; font-size: large; font-weight: bold;">
                <asp:Label ID="lbltagname" runat="server" Text="Label"></asp:Label>&nbsp;
                <hr />
            </td>
        </tr>
        <%--  <tr>
            <td>
                <hr />
                <div class="wrapper">
                    Tag:
                    <a id="Minusanchor" title="Remove" style="position: relative; top: 9px;" onclick='opentagDeletePopup()'>
                        <img src="../Images/minus_red.png" /></a>
                    <span id="tagdiv" runat="server"></span>
                    <a id="addanchor" style="position: relative; top: 5px;" title="Add" onclick='openTagAddPopup()'>
                        <img src="../Images/plus.png" />
                    </a>
                </div>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <div>
                    <div class="wrapper">
                        Emotion:
                        <a id="Minusemoanchor" title="Remove" style="position: relative; top: 9px;" onclick='openemoDeletePopup("<%= tagid %>")'>
                            <img src="../Images/minus_red.png" />
                        </a>
                        <span id="divemotion" runat="server"></span>
                        <a id="addemoanchor" title="Add" style="position: relative; top: 5px;" onclick='openemoAddPopup("<%= tagid %>")'>
                            <img src="../Images/plus.png" />
                        </a>
                    </div>
                </div>
                <hr />
            </td>
        </tr>
        --%>
        <tr>
            <td style="vertical-align: top; text-align: center; width: 70%; background-color: #e9eaed;">
                <% if (Lstdtonewsfeed != null)
                   {
                       foreach (DtoNewsFeed item in Lstdtonewsfeed)
                       { %>
                        <table id="postswrapper" style="width: 100%;">
                            <tr>
                                <td style="width: 15%; vertical-align: bottom;">
                                    <img src="../Images/tag.png" style="height: 25px;" />
                                    <a id="Minusanchor2" style="cursor: pointer;" title="Remove" onclick=' opentagDeletePopup() '>
                                        <img src="../Images/minus_red.png" />
                                    </a>

                                    <br />
                                    <br />
                                    <br />
                                    <img src="../Images/Emotion.png" style="height: 25px;" />
                                    <a id="Minusanchor" title="Remove" onclick=' return openemoDeletePopup() '>
                                        <img src="../Images/minus_red.png" />
                                    </a>
                                </td>
                                <td>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td style="width: 80%;">
                                                <div class="roundborder1" style="width: 100%;">
                                                    <br />
                                                    <% if (item.Title != "")
                                                       { %>
                                                        <div style="text-align: Left; padding-left: 10px;">
                                                            <a id="anch<%= item.PremalinkId %>" href="Javascript:window.open('<%= item.Link %>','_blank')"><%= item.Title %></a>
                                                        </div>
                                                    <% } %>
                                                    <div style="text-align: Left; padding-left: 10px;">
                                                        Tagged In
                                                        <a><%= item.WebsiteName %></a> on  <a><%= item.CreatedOn.ToShortDateString() %></a>
                                                    </div>
                                                    <%
                                                       if (item.Description != "")
                                                       { %>
                                                        <div style="text-align: Left; padding-left: 10px;">
                                                            <%= item.Description %>
                                                        </div>
                                                    <% }
                                                       if (item.Image != "")
                                                       { %>
                                                        <div style="padding: 7px; border: 1px solid rgba(0, 0, 0, 0.1); margin: 15px; background-color: white; -webkit-border-radius: 15px;">
                                                            <a id='anch<%= item.PremalinkId %>' href="Javascript:window.open('<%= item.Link %>','_blank')">
                                                                <img src="<%= item.Image %>" style="width: 100%; height: 350px;" /></a>
                                                        </div>
                                                    <% } %>
                                                    <table id="divtag" style="margin: 0px auto; padding: 0px;">
                                                        <%
                                                            int icell = 0;
                                                            string tagids, tagname, totalvote, firstname, secondname;

                                                            string[] onetag = item.Tagstring.Split('|');

                                                            for (int i = 1; i < onetag.Count(); i++)
                                                            {
                                                                firstname = "";
                                                                secondname = "";

                                                                string[] n = onetag[i].Split(',');
                                                                tagids = n[0];
                                                                tagname = n[1];
                                                                totalvote = n[2];

                                                                int len = (tagname.Length)/2;

                                                                for (int j = 0; j < len; j++)
                                                                    firstname += tagname[j];

                                                                for (int x = len; x < tagname.Length; x++)
                                                                    secondname += tagname[x];

                                                                if (icell == 0 || icell == 10)
                                                                { %>
                                                            <tr>
                                                                <% } %>
                                                                <td>
                                                                    <span class="PinItCount"><span id="div<%= tagids %>" class="CountBubble"><%= totalvote %></span></span>
                                                                    <div class="checkoutbutton">
                                                                        <a id="anchordown<%= tagids %>" class="downVote" title="Down Vote" onclick=" voteTag('<%= tagids %>', 'DownVote', '<%= item.PremalinkId %>') ">&nbsp;&nbsp;&nbsp;<%= firstname %></a><a id="anchorup<%= tagids %>" title="Up Vote" class="upVote" onclick=" voteTag('<%= tagids %>', 'UpVote', '<%= item.PremalinkId %>') "><%= secondname %>&nbsp;&nbsp;&nbsp;</a>
                                                                    </div>
                                                                </td>
                                                                <% if (icell == 10)
                                                                   { %>
                                                                    </tr>
                                                        <% }
                                                            if (icell == 10)
                                                                icell = 0;
                                                            else
                                                                icell = icell + 1;
                                                            } %>
                                                    </table>
                                                    <table id="divemo" style="border-collapse: collapse; border-spacing: 0px; margin: 0px auto; padding: 0px;">
                                                        <tr>
                                                            <%
                                                                string emoid, emoname, emototalvote, taggedby;
                                                                string[] oneemo = item.EmotionString.Split('|');
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
                                                                            <span id="divemo<%= emoid %>" class="CountBubble"><%= emototalvote %></span>
                                                                        </span>
                                                                        <div class="checkoutbutton">
                                                                            <a id="lnkemo<%= emoid %>" style="cursor: pointer;" onclick=" RateEmotion('<%= emoid %>', 'minus', '<%= item.Link %>') ">
                                                                                <img id="imgemo<%= emoid %>" src="../Images/tagclose.png" />
                                                                                <%= emoname %>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                <% }
                                                                    else
                                                                    { %>
                                                                    <td>
                                                                        <span class="PinItCount">
                                                                            <span id="divemo<%= emoid %>" class="CountBubble"><%= emototalvote %></span>
                                                                        </span>
                                                                        <div class="checkoutbutton">
                                                                            <a id="lnkemo<%= emoid %>" style="cursor: pointer;" onclick=" RateEmotion('<%= emoid %>', 'plus', '<%= item.Link %>') ">
                                                                                <%= emoname %>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                            <% }
                                                                } %>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 10%; vertical-align: bottom;">
                                    <a id="addanchor" title="Add" style="cursor: pointer;" onclick=" openTagAddPopup('<%= item.Link %>') ">
                                        <img src="../Images/plus.png" /></a>
                                    <br />
                                    <br />
                                    <br />
                                    <a id="addanchor2" title="Add" onclick=" openemoAddPopup('<%= item.Link %>') ">
                                        <img src="../Images/plus.png" /></a>
                                </td>
                            </tr>
                        </table>
                <% }
                   } %>
            </td>
            <td style="vertical-align: top; width: 20%; background-color: white;">
                <% string q = (from c in Lsttag
                       select c.WebsiteName).Distinct().SingleOrDefault(); %>
                <div class="websi"><%= q.ToString() %></div>
                <table style="margin: 0px auto; padding: 0px;">
                    <tr>
                    <% int index = 0;
                       foreach (DtoTag tag in Lsttag)
                       {
                           index += 1;
                           if (index == 4)
                           { %>
                    <tr>
                        <%
                           } %>
                        <td>
                            <div class="checkoutbutton"><a id="anchor<%= tag.TagId %>" style="text-decoration: none;" href="javascript:opentag('<%= tag.TagId %>')">&nbsp;&nbsp;&nbsp;<%= tag.TagName %></a>&nbsp;&nbsp;&nbsp;</div>
                        </td>
                        <% if (index == 5)
                           {
                               index = 0; %>
                            </tr>
                    <% }
                       } %>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <input id="hdntag" type="hidden" value="" />
    <input id="hdnemo" type="hidden" value="" />
    <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupusertag" style="display: none;" />
    <UserControl:ModalPopup ID="ModalPopup4" runat="server" IframeName="iframemodalpopupusertag" ModalPopupButtonId="btnmodalpopupusertag" ModalPopupTitle="ADD TAG" ModalPopupHeight="400" ModalPopupWidth="700" />

    <script type="text/javascript">

        function voteTag(id, vote, pid) {

            if (checkCookie()) {
                $(document).ready(function() {
                    $.ajax({
                        type: "POST",
                        url: "TagViewer.aspx/voteTag",
                        data: "{'premalinkId':'" + pid + "' ,'TagId':'" + id + "','vote':'" + vote + "','UserID':'" + getCookie("Tagged").split('=')[1] + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg != null) {
                                if (vote == "UpVote")
                                    document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) + 1;
                                else
                                    document.getElementById("div" + id).innerText = parseInt(document.getElementById("div" + id).innerText) - 1;
                            }
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            } else {
                window.location = "../Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        function opentag(tagid) {
            window.location = 'TagViewer.aspx?flow=inlinecode&Id=' + tagid + '&websiteid=<%= Websiteid %>';
        }

        function openuserimagepopup() {
            document.getElementById("BtneditUserimage").click();
        }

        function openuserinfopopup() {
            document.getElementById("BtneditUserinfo").click();
        }

        function openuserpasswordpopup() {
            document.getElementById("BtneditUserpassword").click();
        }

        function openTagAddPopup(link) {
            if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', '../TAG.aspx?Link=' + link + '&flow=wall&TagId=<%= Convert.ToInt64(ViewState["tagid"]) %>');
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = '../Default.aspx';
        }

        function opentagDeletePopup(link) {
            alert(" You cannot Delete Tag !!")
            <%--if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', '../TAG.aspx?Link='+link+'&flow=wall');
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
            --%>    window.location = '../Default.aspx';
        }

        function openemoAddPopup(link) {
            if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', '../Emotion.aspx?Premalink=' + link + '&flow=inlinecode');
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
                window.location = '../Default.aspx';
        }

        function openemoDeletePopup(Id) {
            alert(" You cannot Delete Emotion !!")
            <%--if (checkCookie()) {
                $('#iframemodalpopupusertag').attr('src', '../Emotion.aspx?flow=inlinecode&TagId=' + Id);
                document.getElementById('<%= btnmodalpopupusertag.ClientID %>').click();
            } else
           --%>     window.location = '../Default.aspx';
            return false;
        }

        function RateEmotion(Id, rate, link) {
            if (checkCookie()) {
                $(document).ready(function() {
                    $.ajax({
                        type: "POST",
                        url: "TagViewer.aspx/RateEmotion",
                        data: "{premalink :'" + link + "',EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='../Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus','" + link + "')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (i = 0; i < htm.children.length; i++) {
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
                    })
                });
            } else {
                window.location = "../Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        //function RateEmotion(Id, rate) {
        //    if (checkCookie()) {
        //        $(document).ready(function () {
        //            $.ajax({
        //                type: "POST",
        //                url: "TagViewer.aspx/RateTaggedEmotion",
        //                contentType: "application/json; charset=utf-8",
        //                data: "{EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
        //                dataType: "json",
        //                async: true,
        //                cache: false,
        //                success: function (msg) {
        //                    if (msg.d != null) {
        //                        if (msg.d > 0) {
        //                            if (rate == 'plus') {
        //                                document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1
        //                                $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='../Images/tagclose.png'>");

        //                                $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
        //                                $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus')");

        //                            } else {
        //                                document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1

        //                                var htm = document.getElementById("lnkemo" + Id);

        //                                for (i = 0 ; i < htm.children.length; i++) {
        //                                    console.log(htm.children[i].nodeName.toUpperCase());
        //                                    if (htm.children[i].nodeName.toUpperCase() == "IMG")
        //                                        htm.removeChild(htm.children[i]);
        //                                }
        //                                $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
        //                                $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','plus')");
        //                            }
        //                        }
        //                    }
        //                },
        //                error: function (request, status, error) {
        //                    alert(request.responseText);
        //                }
        //            })
        //        });
        //    }
        //    else {
        //        window.location = "http://localhost/Authentication/PopUpLogin.aspx?prevurl=" + document.forms[0].action;
        //    }
        //}

        function maketaghtmls() {
            var hdntags = (document.getElementById("hdnemo").value).split('|');
            document.getElementById("divemotion").innerHTML = "";

            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var oneemo = hdntags[i].split(',');
                    var len = parseInt(Math.floor((oneemo[0].length) / 2));

                    if (oneemo[3].toString() == "true")
                        document.getElementById("divemotion").innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','minus')\" ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                    else
                        document.getElementById("divemotion").innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','plus')\" >" + oneemo[0] + "</a></span></span>";

                }
            }
        }

        $(window).scroll(function() {
            var dif = $(document).height() - $(window).height();

            if (dif < 0)
                dif = dif * -1;

            if ($(window).scrollTop() == dif) {
                //$('div#loadmoreajaxloader').show();
                $(document).ready(function() {
                    $.ajax({
                        type: "GET",
                        url: "../Pagging.aspx?flow=inlinecode&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value + "&Id=<%= Convert.ToInt64(ViewState["tagid"]) %>",
                        contentType: "text/html; charset=utf-8",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg != "") {
                                $("#postswrapper").append(msg);
                                //$('div#loadmoreajaxloader').hide();
                                document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                            }
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
        });

        function pagging() {
            $(document).ready(function() {
                $.ajax({
                    type: "GET",
                    url: "../Pagging.aspx?flow=inlinecode&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value + "&Id=<%= Convert.ToInt64(ViewState["tagid"]) %>",
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        if (msg != "") {
                            $("#postswrapper").append(msg);
                            $('div#loadmoreajaxloader').show();
                            $('div#nomoreajaxloader').hide();
                            document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                        } else {
                            $('div#loadmoreajaxloader').hide();
                            $('div#nomoreajaxloader').show();
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                })
            });
        }
    </script>

    <br />
    <br />
    <div id="loadmoreajaxloader" style="text-align: center;" class="profile-buttons">
        <a class="button secondary" style="text-decoration: none;" href="javascript:pagging();">Get More News Feed</a>
    </div>
    <div id="nomoreajaxloader" style="display: none; font-size: medium; font-weight: bold; padding-top: 15px; color: black; text-align: center; height: 50px;">
        <a onclick=" return false; ">No More News Feed </a>
    </div>

    <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
</asp:Content>