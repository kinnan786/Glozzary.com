<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/Member.Master" CodeBehind="Follow.aspx.cs" Inherits="Tag.Tag.Follow" %>
<%@ Import Namespace="DTO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <script type="text/javascript">
        function pagging() {
            $('div#loadmoreajaxloader').hide();
            $('div#gifloader').show();

            $(document).ready(function() {
                $.ajax({
                    type: "GET",
                    url: "FollowPagging.aspx?search=" + document.getElementById('<%= txtinputtagfollow.ClientID %>').value + "&flow=<%= Flow %>&PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value,
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        if (msg != "") {
                            $('#ultag').append(msg);
                            $('div#loadmoreajaxloader').show();
                            $('div#nomoreajaxloader').hide();
                            $('div#gifloader').hide();
                            document.getElementById('<%= hdnpagenumber.ClientID %>').value = (parseInt(document.getElementById('<%= hdnpagenumber.ClientID %>').value) + 1);
                        } else {
                            $('div#gifloader').hide();
                            $('div#loadmoreajaxloader').hide();
                            $('div#nomoreajaxloader').show();
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                });
            });
        }

        function AddUserTagSubscription(Tagid) {
            $(document).ready(function() {
                $.ajax
                ({
                    type: "POST",
                    url: "Follow.aspx/AddUserTagSubscription",
                    data: "{'TagID':'" + Tagid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        document.getElementById("BtnTagFollow" + Tagid).style.display = "none";
                    }
                });
            });
        }

        function UnfollowUserTagSubscription(Tagid) {
            $(document).ready(function() {
                $.ajax
                ({
                    type: "POST",
                    url: "Follow.aspx/UnfollowUserTagSubscription",
                    data: "{'TagID':'" + Tagid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        document.getElementById("BtnTagUnFollow" + Tagid).style.display = "none";
                    }
                });
            });
        }

        $(document).ready(function() {
            $("#<%= txtinputtagfollow.ClientID %>").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Follow.aspx/SearchTag",
                        dataType: "json",
                        data: "{'PrefixText': '" + request.term + "'}",
                        success: function(data) {
                            if (data.d != "") {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.Name,
                                        value: item.Value,
                                        name: item.Name
                                    };
                                }));
                            } else {
                                var nosuggestion = ["No Suggestions"];
                                response(nosuggestion);
                            }
                        }
                    });
                },
                minLength: 2,
                select: function(event, ui) {
                    search1(ui.item.name);
                },
                open: function() {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function() {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        function search1(name) {
            window.location = "Follow.aspx?search=" + String(name) + "&flow=search&PageNo=1";
        }


        function showButton(id) {
            document.getElementById(id).style.display = "block";
        }
    </script>

    <div style="padding-top: 50px; text-align: center;">
        <div style="padding-left: 200px; padding-right: 200px; text-align: center; width: 100%;">
            <div class="row" style="position: relative; right: -200px">    
                <div class="col-lg-6">
                    <div class="input-group">
                        <input type="text" id="txtinputtagfollow" class="form-control" placeholder="Search All Tags" style="width: 430px;" runat="server" />
                        <span class="input-group-btn">
                            <asp:Button ID="btnsearch" class="btn btn-default" runat="server" Text="Search" OnClick="btnsearch_Click" />
                        </span>
                    </div><!-- /input-group -->
                </div><!-- /.col-lg-6 -->
            </div>
            <br />
            <asp:Label ID="lblnodata" Visible="false" runat="server" Style="color: red; text-align: center; width: 200px;"> No Row Found </asp:Label>
            <div style="text-align: center;">
                <input type="button" class="simplebutton" runat="server" id="lnkback" style="width: 150px; z-index: 10;" value="< Back " />
                <input type="button" class="simplebutton" runat="server" id="lnkfollow" style="width: 150px; z-index: 10;" value="My Tags" />
            </div>
            <div id="roundborder" style="margin: 20px;">
                <% if (Lsttag != null)
                   { %>
                    <ul id="ultag" class="unorderlist">
                        <% foreach (DtoTag item in Lsttag)
                           { %>
                            <li class="liststyle" onmouseover=" showButton('BtnTagUnFollow<%= item.TagId.ToString() %>') ">
                                <% if (item.UserId !=GetUserId())
                                   { %>
                                    <a id="<%= item.TagName %>-<%= item.TagId.ToString() %>" href="../MainPage.aspx?flow=explore&TagID=<%= item.TagId.ToString() %>" class="title" style="color: black; text-decoration: none;"><%= item.TagName %></a><br />
                                    <input type="button" id="BtnTagFollow<%= item.TagId.ToString() %>" style="z-index: 10;" onclick=" AddUserTagSubscription(<%= item.TagId.ToString() %>) " class="simplebutton" value="Follow" />
                                <% }
                                   else
                                   { %>
                                    <a id="<%= item.TagName %>-<%= item.TagId.ToString() %>" href="../MainPage.aspx?flow=explore&TagID=<%= item.TagId.ToString() %>" class="title" style="color: black; text-decoration: none;"><%= item.TagName %></a><br/>
                                    <input type="button" id="BtnTagUnFollow<%= item.TagId.ToString() %>" style="z-index: 10;" onclick=" UnfollowUserTagSubscription(<%= item.TagId.ToString() %>) " class="simplebutton" value="UnFollow" />
                                <% } %>
                            </li>
                        <%
                           } %>
                    </ul>
                <%
                   } %>
            </div>
            <div style="padding-left: 50px; padding-top: 25px;">
                <div id="loadmoreajaxloader">
                    <input id="anchorgettags" class="simplebutton" value="More" onclick=" javascript: pagging(); " />
                </div>
                <div id="gifloader" style="display: none;">
                    <img src="../Images/loader.gif" />
                </div>
                <div id="nomoreajaxloader" style="display: none;">
                    <img src="../Images/end.png" style="width: 80px;" />
                </div>
            </div>
            <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
        </div>
    </div>
</asp:Content>