<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FollowPagging.aspx.cs" Inherits="Tag.Tag.FollowPagging" %>
<%@ Import Namespace="DTO" %>

<% if (lsttag != null)
   {%>
<%foreach (DtoTag item in lsttag)
  { %>
<li class="liststyle">
    <%  if (item.UserId != UserID)
        { %>
    <a id="<%= item.TagName %>-<%= item.TagId.ToString() %>" href="../MainPage.aspx?flow=explore&TagID=<%=item.TagId.ToString()%>" class="title" style="text-decoration: none;color:black;"><%= item.TagName %></a>
    <br />
    <hr />
    <input type="button" id="BtnTagFollow<%= item.TagId.ToString() %>" style="z-index: 10;" onclick="AddUserTagSubscription(<%= item.TagId.ToString() %>)" class="simplebutton" value="Follow" />
    <%}
        else
        { %>
    <a id="<%= item.TagName %>-<%= item.TagId.ToString() %>" href="../MainPage.aspx?flow=explore&TagID=<%=item.TagId.ToString()%>" class="title" style="text-decoration: none;color:black;"><%= item.TagName %></a>
    <hr />
    <input type="button" id="BtnTagUnFollow<%= item.TagId.ToString() %>" style="z-index: 10;" onclick="UnfollowUserTagSubscription(<%= item.TagId.ToString() %>)" class="simplebutton" value="UnFollow" />
    <%} %>
</li>
<%
  }%>
<%

   }%>