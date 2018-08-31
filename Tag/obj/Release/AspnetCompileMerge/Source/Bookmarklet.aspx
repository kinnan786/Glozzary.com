<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ThreeLayerLayout.Master" AutoEventWireup="true" CodeBehind="Bookmarklet.aspx.cs" Inherits="Tag.Bookmarklet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div style="width: 100%;">
       
     <div style="text-align: center; color: black; font-size: x-large; font-weight: bold;">
        BOOKMARKLET
    </div>
    <hr />
    <table style="width: 100%;">
        <tr>
            <td style="width: 5%;"></td>
            <td style="width: 90%;">
                <div style="padding: 80px; text-align:center;">
                    <a class="simplebutton" style="padding: 10px; color: white; text-decoration: none;" href="javascript:void((function(d){var%20e=d.createElement('script');e.setAttribute('type','text/javascript');e.setAttribute('charset','UTF-8');e.setAttribute('src','http://www.glozzary.com/Bookmarklet/bookmarklet.js?r='+Math.random()*99999999);d.body.appendChild(e)})(document));">&nbsp;&nbsp;&nbsp;Glozz@ry&nbsp;&nbsp;&nbsp;
                    </a>
                </div>
            </td>
            <td style="width: 5%;"></td>
        </tr>
    </table>
       
   </div>
</asp:Content>