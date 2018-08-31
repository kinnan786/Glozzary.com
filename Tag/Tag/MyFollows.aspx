<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Member.Master" AutoEventWireup="true" CodeBehind="MyFollows.aspx.cs" Inherits="Tag.Tag.MyFollows" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <script src="../Script/Jquery.min.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
    function DeleteUserTagSubscription(Tagid) {
        $(document).ready(function () {
            $.ajax
                    ({
                        type: "POST",
                        url: "MyFollows.aspx/DeleteUserTagSubscription",
                        data: "{'TagID':'" + Tagid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            document.getElementById("BtnTagUnFollow" + Tagid).style.display = "none";
                        }
                    })
        });
    }
    </script>

    <div style="float: left;">
        <asp:Button ID="tagbtnfollows" class="simplebutton" Style="width: 100px;" PostBackUrl="~/TagPage/Follow.aspx" runat="server" Text="Tag Follows" />
    </div>
    <div>
        <asp:DataList ID="DatalistLinkTag" runat="server" Width="100%" OnItemDataBound="DatalistLinkTag_ItemDataBound" RepeatDirection="Vertical" RepeatLayout="Table">
            <ItemTemplate>
                <table width="100%">
                    <tr>
                        <td style="width: 100%">
                            <asp:Literal ID="ltrltags" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="ltrlbtn" runat="server"></asp:Literal>
                        </td>
                    </tr>
                </table>
                <hr />
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>