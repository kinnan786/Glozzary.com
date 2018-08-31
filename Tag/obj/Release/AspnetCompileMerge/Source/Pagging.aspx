<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pagging.aspx.cs" Inherits="Tag.Pagging" %>
<%@ Import Namespace="DTO" %>

<% if (Lstdtonewsfeed != null)
   {
       foreach (DtoNewsFeed item in Lstdtonewsfeed)
       {%>
<tr>
    <td style="width: 100%;">
        <div style="font-weight: bold; text-decoration: none;">
            <a style="color: black;" href="Website/Website.aspx?WebsiteId=<%= item.WebsiteId %>">
                <%= item.WebsiteName %>
            </a>
        </div>
        <hr />
        <table style="width: 100%;">
            <tr>
                <td style="vertical-align: top; width: 10%;">
                    <a style="color: black;" href="Website/Website.aspx?WebsiteId=<%= item.WebsiteId %>">
                        <asp:image id="ImgWebsitelogo" style="width: 50px; height: 50px;" alternatetext="No Image" imageurl="<%= item.WebsiteImage %>" runat="server" />
                    </a>
                </td>
                <td style="width: 90%;">
                    <div class="roundborder1" style="width: 100%;">
                        <br />
                        <%if (item.Title != "")
                          {%>
                        <div class="title" >
                            <a style="color: black;" id="anch<%= item.PremalinkId%>" href="Javascript:window.open('<%= item.Link%>','_blank')"><%= item.Title%></a>
                        </div>
                        <%}%>
                        <div class="dateclass" style="color: black;">
                            <a><%= item.CreatedOn.ToString("MMMM dd, yyyy")%></a>
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
                        <div>
                            <a id='anch<%= item.PremalinkId%>' href="Javascript:window.open('<%= item.Link%>','_blank')">
                                <img src="<%= item.Image%>" style="width: 100%; height: 280px;" /></a>
                        </div>
                        <%}%>
                        <ul class="unorderlist">
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
                            %>
                            <li style="display: inline-block;">
                                <span class="PinItCount" id="span<%= tagids %>" style="display: none;"><span id="div<%= tagids%>" class="CountBubble"><%= totalvote%></span></span>
                                <br />
                                <span class="checkoutbutton" onmouseover="showbubble(&quot;span<%= tagids %>&quot;)" onmouseout="hidebubble(&quot;span<%= tagids %>&quot;)">
                                    <a id="anchordown<%= tagids%>" class="downVote" title="Down Vote" onclick="voteTag('<%= tagids%>','DownVote','<%= item.PremalinkId%>')">#&nbsp;&nbsp;&nbsp;<%= firstname%></a><a id="anchorup<%= tagids%>" title="Up Vote" class="upVote" onclick="voteTag('<%= tagids%>','UpVote','<%= item.PremalinkId%>')"><%= secondname%>&nbsp;&nbsp;&nbsp;</a>
                                </span>
                            </li>
                            <%
               }
           }
           else
           {
                            %>
                            <li style="display: inline-block;">
                                <div class="checkoutbutton1">
                                    <a onclick="javascript: alert(&quot;No Tags :( &quot;);">No Tags :( </a>
                                </div>
                            </li>
                            <%}%>
                        </ul>
                        <br />
                        <div style="padding: 0px; border-bottom: 1px solid #ecf9d4; text-align: left; position: relative; top: -15px;">
                            <a id="Minusanchor2" title="Remove" onclick='opentagDeletePopup()'>
                                <img src="../Images/minus_red.png" />
                            </a>
                            <a id="addanchor" title="Add" style="float: right;" onclick="openTagAddPopup('<%= item.Link%>')">
                                <img src="../Images/plus.png" /></a>
                        </div>

                        <ul class="unorderlist">
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
                                <br>
                                <span class="checkoutbutton">
                                    <a id="lnkemo<%= emoid%>" style="cursor: pointer;text-decoration: none;" onclick="RateEmotion('<%= emoid%>','minus','<%= item.Link%>')">
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
                                    <a id="lnkemo<%= emoid%>" style="cursor: pointer;" onclick="RateEmotion('<%= emoid%>','plus','<%= item.Link%>')">
                                        <%=emoname%>
                                    </a>
                                </span>
                            </li>
                            <%}
               }
           }
           else
           {%>
                            <li style="display: inline-block;">
                                <div class="checkoutbutton1">
                                    <a onclick="javascript: alert(&quot;No Emotions :( &quot;);">No Emotions :( </a>
                                </div>
                            </li>

                            <%            }%>
                        </ul>
                        <br />
                        <div style="padding: 0px; margin: 0px; border-bottom: 1px solid #ecf9d4; text-align: left; position: relative; top: -15px;">
                            <a id="Minusanchor" title="Remove" onclick='openemoDeletePopup()'>
                                <img src="../Images/minus_red.png" />
                            </a>
                            <a id="addanchor2" title="Add" style="float: right;" onclick="openemoAddPopup('<%= item.Link %>')">
                                <img src="../Images/plus.png" /></a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </td>
</tr>
<%}
   }
%>