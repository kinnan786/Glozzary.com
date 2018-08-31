<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Member.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Tag.User.Profile" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="DTO" %>
<%@ Register TagPrefix="UserControl" TagName="ModalPopup" Src="~/UserControls/ModalPopup.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <%
        TextInfo textInfo = new CultureInfo("en-US", false).TextInfo;
        Dtouser.FirstName = textInfo.ToTitleCase(Dtouser.FirstName);
        Dtouser.Lastname = textInfo.ToTitleCase(Dtouser.Lastname);
    %>
    <br/><br/><br/>
    <div class="wrapper">
        <div class="profile-content" style="margin-left: 1%;">
            <table style="width: 100%;">
                <tr>
                    <td style="vertical-align: top; width: 15%;">
                        <img id="profileimg" class="img-thumbnail" style="cursor: pointer; height: 180px; width: 100%;" title="Click Image to Edit" onclick=" openEditPopup('profilephoto'); " src="<%= Dtouser.ImageUrl %>" />
                        <div style="color: black; font-weight: bold; height: 100%; text-align: center; width: 100%;">
                            <h4><%= Dtouser.FirstName %>&nbsp;<%= Dtouser.Lastname %></h4>
                        </div>
                    </td>
                    <td style="width: 55%;">
                        <script type="text/javascript">
                            function resizeIframe(obj) {
                                obj.style.height = (parseInt(obj.contentWindow.document.body.scrollHeight) + parseInt(50)) + 'px';
                            }
                        </script>
                        <div style="color: black; padding-left: 50px;">
                            <%-- <asp:Button ID="btnedit" runat="server" class="button secondary" PostBackUrl="~/User/Setting.aspx" Text="Edit profile" />--%>
                            <div style="color: black; font-size: smaller; font-style: italic;">
                                Filter (Tag | Emotions):
                            </div>
                            <div id="divtagquery"></div>
                            <div id="divemotionquery"></div>
                        </div>
                        <iframe id="iframeuserfeed" src="UserFeed.aspx?TagId=<%= Tagstring %>&EmoId=<%= Emostring %>&Id=<%= UserId %>" style="border: none; width: 100%;" onload=' javascript:resizeIframe(this); '></iframe>
                    </td>
                    <td class="tagcolumn" style="background-color: #ecf9d4; width: 35%;">
                        <div class="panel-group" id="accordion">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" style="text-decoration: none;" data-parent="#accordion" href="">Tag  <%
                                                                                                                                                       if (Lsttag != null)
                                                                                                                                                       {
                                                                                                                                                           if (Lsttag.Count > 0)
                                                                                                                                                           { %>(&nbsp;<%= Lsttag.Count.ToString() %>&nbsp;)<% }
                                                                                                                                                       } %>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse in">
                                    <div class="panel-body">
                                        <ul class="unorderlist">
                                            <%
                                                if (Lsttag != null && Lsttag.Count > 0)
                                                {
                                                    foreach (DtoTag tag in Lsttag)
                                                    { %>
                                                    <li style="display: inline-block;">
                                                        <span class='PinItCount'><span id='div<%= tag.TagId %>' class='CountBubble'><%= tag.TagCount %></span></span>
                                                        <br />
                                                        <span class="checkoutbutton"><a id="anchor<%= tag.TagId %>" style="color: white; cursor: pointer; text-decoration: none;" href="javascript:opentag('<%= tag.TagId %>','<%= tag.TagName %>')">&nbsp;&nbsp;&nbsp;<%= tag.TagName %></a>&nbsp;&nbsp;&nbsp;</span>
                                                    </li>
                                            <% }
                                                } %>
                                        </ul>

                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" style="text-decoration: none;" data-parent="#accordion" href="">Emotion <% if (Lstemotions != null)
                                                                                                                                                         {
                                                                                                                                                             if (Lstemotions.Count > 0)
                                                                                                                                                             { %>(&nbsp;<%= Lstemotions.Count.ToString() %>&nbsp;)<% }
                                                                                                                                                         } %>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="panel-collapse collapse" style="display: block; min-height: 50px;">
                                    <div class="panel-body">
                                        <ul class="unorderlist">
                                            <% if (Lstemotions != null && Lstemotions.Count > 0)
                                               {
                                                   foreach (DtoEmotions emo in Lstemotions)
                                                   { %>
                                                    <li style="display: inline-block;">
                                                        <span class='PinItCount'><span id='div<%= emo.Emotionid %>' class='CountBubble'><%= emo.TotalCount %></span></span>
                                                        <br />
                                                        <span class="checkoutbutton"><a id="anchor<%= emo.Emotionid %>" style="color: white; cursor: pointer; text-decoration: none;" href="javascript:openemo('<%= emo.Emotionid %>','<%= emo.EmotionName %>')">&nbsp;&nbsp;&nbsp;<%= emo.EmotionName %></a>&nbsp;&nbsp;&nbsp;</span>
                                                    </li>
                                            <% }
                                               } %>
                                        </ul>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <br />

    <input id="hdntag" type="hidden" runat="server" value="" />
    <input id="hdnemo" type="hidden" runat="server" value="" />
    <input type="button" runat="server" clientidmode='Static' id="btnmodalpopupusertag" style="display: none;" />
    <UserControl:ModalPopup ID="modalpopupuseriframe" ClientIDMode="Static" runat="server" IframeName="iframemodalpopupusertag" ModalPopupButtonId="btnmodalpopupusertag" ModalPopupTitle="Search / ADD" ModalPopupHeight="400" ModalPopupWidth="700" />
    <script type="text/javascript">
        function DeleteTag(tagid, tagname) {
            var hdn = document.getElementById("hdntagquery");
            var hdntagidarray = document.getElementById("hdntagidarray");
            var hdnemoidarray = document.getElementById("hdnemoidarray");

            var div = document.getElementById("divtagquery");
            if (hdn.value.length > 0) {
                var q = hdn.value.split('|');
                div.innerHTML = "";
                hdn.value = "";
                hdntagidarray.value = "";
                for (i = 0; i < q.length - 1; i++) {
                    var id = q[i].split(',');
                    if (id[0] != tagid) {
                        div.innerHTML += "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + id[0] + "' style='text-decoration:none;color:white;'>" + id[1] + "&nbsp;&nbsp;&nbsp;<img id='img" + id[0] + "' onclick='DeleteTag(&quot;" + id[0] + "&quot;,&quot;" + id[1] + "&quot;)' src= 'http://www.glozzary.com/Images/tagclose.png' style='cursor:pointer;' /></span>&nbsp;";
                        hdn.value += id[0] + "," + id[1] + "|";
                        hdntagidarray.value += id[0] + ",";
                    }
                }
            }
            if (hdntagidarray.value.length > 0 || hdnemoidarray.value.length > 0) {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=' + hdntagidarray.value + '&EmoId=' + hdnemoidarray.value;
            } else {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=<%= Tagstring %>&EmoId=<%= Emostring %>';
            }
        }

        function opentag(tagid, tagname) {
            var hdn = document.getElementById("hdntagquery");
            var hdntagidarray = document.getElementById("hdntagidarray");
            var hdnemoidarray = document.getElementById("hdnemoidarray");
            var div = document.getElementById("divtagquery");

            if (hdn.value.length > 0) {
                var q = hdn.value.split('|');
                for (var i = 0; i < q.length; i++) {
                    var id = q[i].split(',');
                    if (id[0] == tagid) {
                        alert('Already Exists !!!');
                        return false;
                    }
                }
                div.innerHTML += "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + tagid + "' style='text-decoration: none;color:white;'>" + tagname + "&nbsp;&nbsp;&nbsp;<a id='img" + tagid + "' class='close' onclick='DeleteTag(&quot;" + tagid + "&quot;,&quot;" + tagname + "&quot;)'>×</a></span>&nbsp;";
                hdn.value += (tagid + "," + tagname + "|");
                hdntagidarray.value += tagid + ",";
            } else {
                div.innerHTML = "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + tagid + "' style='text-decoration: none;color:white;'>" + tagname + "&nbsp;&nbsp;&nbsp;<a id='img" + tagid + "' class='close' onclick='DeleteTag(&quot;" + tagid + "&quot;,&quot;" + tagname + "&quot;)'>×</a></span>&nbsp;";
                hdn.value = (tagid + "," + tagname + "|");
                hdntagidarray.value = tagid + ",";
            }

            if (hdntagidarray.value.length > 0 || hdnemoidarray.value.length > 0) {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=' + hdntagidarray.value + '&EmoId=' + hdnemoidarray.value;
            } else {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=<%= Tagstring %>&EmoId=<%= Emostring %>';
            }
        }

        function DeleteEmo(emoid, emoname) {
            var hdn = document.getElementById("hdnemoquery");
            var hdntagidarray = document.getElementById("hdntagidarray");
            var hdnemoidarray = document.getElementById("hdnemoidarray");

            var div = document.getElementById("divemotionquery");
            if (hdn.value.length > 0) {
                var q = hdn.value.split('|');
                div.innerHTML = "";
                hdn.value = "";
                hdnemoidarray.value = "";
                for (i = 0; i < q.length - 1; i++) {
                    var id = q[i].split(',');
                    if (id[0] != emoid) {
                        div.innerHTML += "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + id[0] + "' style='text-decoration: none;color:white;'>" + id[1] + "&nbsp;&nbsp;&nbsp;<img id='img" + id[0] + "' onclick='DeleteEmo(&quot;" + id[0] + "&quot;,&quot;" + id[1] + "&quot;)' src= 'http://www.glozzary.com/Images/tagclose.png' style='cursor:pointer;' /></span>&nbsp;";
                        hdn.value += id[0] + "," + id[1] + "|";
                        hdnemoidarray.value += id[0] + ",";
                    }
                }
            }

            if (hdntagidarray.value.length > 0 || hdnemoidarray.value.length > 0) {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=' + hdntagidarray.value + '&EmoId=' + hdnemoidarray.value;
            } else {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=<%= Tagstring %>&EmoId=<%= Emostring %>';
            }
        }

        function openemo(emoid, emoname) {
            var hdntagidarray = document.getElementById("hdntagidarray");
            var hdnemoidarray = document.getElementById("hdnemoidarray");
            var hdn = document.getElementById("hdnemoquery");
            var div = document.getElementById("divemotionquery");

            if (hdn.value.length > 0) {
                var q = hdn.value.split('|');
                for (i = 0; i < q.length; i++) {
                    var id = q[i].split(',');
                    if (id[0] == emoid) {
                        alert('Already Exists !!!');
                        return false;
                    }
                }
                div.innerHTML += "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + emoid + "' style='text-decoration: none;color:white;'>" + emoname + "&nbsp;&nbsp;&nbsp;<a id='img" + emoid + "' class='close' onclick='DeleteEmo(&quot;" + emoid + "&quot;,&quot;" + emoname + "&quot;)'>×</a></span>&nbsp;";
                hdn.value += (emoid + "," + emoname + "|");
                hdnemoidarray.value += emoid + ",";
            } else {
                div.innerHTML = "<span class='checkoutbutton' style='color: black;padding: 5px;border: 1px solid gainsboro;'><a id='anchor" + emoid + "' style='text-decoration: none;color:white;'>" + emoname + "&nbsp;&nbsp;&nbsp;<a id='img" + emoid + "' class='close' onclick='DeleteEmo(&quot;" + emoid + "&quot;,&quot;" + emoname + "&quot;)'>×</a></span>&nbsp;";
                hdn.value = (emoid + "," + emoname + "|");
                hdnemoidarray.value = emoid + ",";
            }

            if (hdntagidarray.value.length > 0 || hdnemoidarray.value.length > 0) {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=' + hdntagidarray.value + '&EmoId=' + hdnemoidarray.value;
            } else {
                document.getElementById('iframeuserfeed').src = 'UserFeed.aspx?Id=<%= UserId %>&TagId=<%= Tagstring %>&EmoId=<%= Emostring %>';
            }
        }
    </script>
    <input type="hidden" id="hdntagquery" value="" />
    <input type="hidden" id="hdnemoquery" value="" />
    <input type="hidden" id="hdnemoidarray" value="" />
    <input type="hidden" id="hdntagidarray" value="" />
    <input type="hidden" id="hdnemostring" value="" runat="server" />
    <input type="hidden" id="hdntagstring" value="" runat="server" />
</asp:Content>