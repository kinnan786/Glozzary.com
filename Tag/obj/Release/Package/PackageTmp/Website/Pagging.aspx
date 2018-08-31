<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pagging.aspx.cs" Inherits="Tag.Website.Pagging" %>
<%@ Import Namespace="DTO" %>

<%
    if (Lstdtowebsite != null)
    {
        foreach (DtoWebsite item in Lstdtowebsite)
        { %>
<li class="liststyle">
    <a id="Lnkwebsiteurl<%= item.WebsiteId.ToString() %>" href="Website.aspx?WebsiteId=<%= item.WebsiteId.ToString() %>" class="title" style="text-decoration: none; color: black;"><%=item.WebSiteName %></a>
    <hr />
    <a id="Lnkwebsiteurl1<%= item.WebsiteId.ToString() %>" href="Website.aspx?WebsiteId=<%= item.WebsiteId.ToString() %>" class="title" style="text-decoration: none; color: black;">
        <img style="width: 100%" src="../Images/nopic.png" id="imgpic" /></a>
</li>
<%}
    }%>