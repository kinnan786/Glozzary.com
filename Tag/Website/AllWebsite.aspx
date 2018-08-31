<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Member.Master" AutoEventWireup="true" CodeBehind="AllWebsite.aspx.cs" Inherits="Tag.Website.AllWebsite" %>
<%@ Import Namespace="DTO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
    <script type="text/javascript">

        function pagging() {
            $(document).ready(function() {
                $.ajax({
                    type: "GET",
                    url: "Pagging.aspx?PageNo=" + document.getElementById('<%= hdnpagenumber.ClientID %>').value + "&searchterm=" + document.getElementById('<%= txtinputtagfollow.ClientID %>').value,
                    contentType: "text/html; charset=utf-8",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        if (msg != "") {
                            $('#ultag').append(msg);
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
                });
            });
        }

        $(document).ready(function() {
            $("#<%= txtinputtagfollow.ClientID %>").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "AllWebsite.aspx/SearchWebsite",
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
                    search(ui.item.name);
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

        function search(name) {
            window.location = "ALLWebsite.aspx?searchterm=" + name;
        }
    </script>
    <div style="padding-bottom: 50px; padding-top: 50px; text-align: center;">
         <div class="row" style="position: relative; right: -330px">    
            <div class="col-lg-6">
                <div class="input-group">
                     <input type="text" id="txtinputtagfollow" class="form-control" placeholder="Search All Websites" style="width: 430px;" runat="server" />
                    <span class="input-group-btn">
                         <asp:Button ID="btnsearch" class="btn btn-default" runat="server" Text="Search" OnClick="btnsearch_Click" />
                    </span>
                </div><!-- /input-group -->
            </div><!-- /.col-lg-6 -->
        </div>     
        <div id="roundborder" style="margin: 20px;">
            <% if (Lstdtowebsite != null)
               { %>
                <ul id="ultag" class="unorderlist">

                    <% foreach (DtoWebsite item in Lstdtowebsite)
                       { %>
                        <li class="liststyle">
                            <div style="text-align: center;">
                                <a href="Website.aspx?WebsiteId=<%= item.WebsiteId.ToString() %>">
                                    <img src="../Images/no-img-available-icons.jpg" style="height: 100%; width: 100%;" />        
                                </a>
                                <hr />
                                <a id="Lnkwebsiteurl<%= item.WebsiteId.ToString() %>" href="Website.aspx?WebsiteId=<%= item.WebsiteId.ToString() %>" class="title" style="color: black; text-decoration: none;"><%= item.WebSiteName %></a><br />    
                            </div>
                        
                        </li>
                    <%
                       } %>
                </ul>
            <%
               } %>
        </div>    
    <br />
    <div id="loadmoreajaxloader" class="btn-group">
        <a class="btn btn-lg btn-success" id="anchorgettags" runat="server" style="color: white; text-decoration: none;" href="javascript:pagging();">More</a>
    </div>
    <div id="gifloader" style="display: none;">
        <img src="../Images/loader.gif" />
    </div>
    <br />
    <br />
    <div id="nomoreajaxloader" style="display: none; padding-left: 625px; width: 150px;">
        <img src="../Images/end.png" />
    </div>
</div>
    
    <input type="hidden" id="hdnpagenumber" runat="server" value="2" />
</asp:Content>