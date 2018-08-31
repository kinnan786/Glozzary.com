<%@ Page Title="" Language="C#" MasterPageFile="~/WebsiteAdmin/WebsiteAdmin.Master" AutoEventWireup="true" CodeBehind="EditRateableTag.aspx.cs" Inherits="Tag.WebsiteAdmin.EditRateableTag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

        window.onload = function() {
            Maketaghtml();
        };

        function Maketaghtml() {
            var hdntags = (document.getElementById("<%= hdntag.ClientID %>").value).split('|');
            document.getElementById("divtag").innerHTML = "";
            var table = document.getElementById("divtag");
            if (hdntags != "" && hdntags.length > 1) {
                for (var i = 1; i < hdntags.length; i++) {
                    var onemo = hdntags[i].split(',');

                    var ht = "<li style='display: inline-block;'><span class='checkoutbutton'>"
                        + "<a id='anchor" + onemo[0] + "' style='color: white; cursor: pointer; text-decoration: none;'>&nbsp;&nbsp;"
                        + onemo[0] + "&nbsp;&nbsp;<img id='img" + onemo[0] + "' src='http://www.glozzary.com/Images/tagclose.png' onclick='DeleteTag(&quot;" + onemo[1] + "&quot;,&quot;" + onemo[0] + "&quot;)'/></a></span></li>&nbsp;";

                    table.innerHTML += ht;
                }
            }
        }

        $(document).ready(function() {
            $("#<%= txtinputtag.ClientID %>").autocomplete({
                source: function(e, t) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "EditRateableTag.aspx/RateableEmotionIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + e.term + "'}",
                        success: function(e1) {
                            if (e1.d != "") {
                                t($.map(e1.d, function(e2) {
                                    return {
                                        label: e2.Name,
                                        value: e2.Value,
                                        name: e2.Name
                                    };
                                }));
                            } else {
                                var n = ["No Suggestions"];
                                t(n);
                            }
                        }
                    });
                },
                minLength: 2,
                select: function(e, t) {
                    AddTag(t.item.name, t.item.value);
                },
                open: function() {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function() {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function(e, t, n) {
                    alert(t);
                }
            });
        });

        var UserID, TagId = 0;

        function AddTag(ctrlname, ctrlvalue) {

            if (ctrlname.length > 2) {

                var htag = document.getElementById("<%= hdntag.ClientID %>").value.split('|');

                if (htag.length > 30) {
                    alert("Cannot associate more than 30 tags!!!");
                    return false;
                }

                for (var i = 1; i < htag.length; i++) {
                    var onetag = htag[i].split(',');

                    if (onetag[0].toLowerCase() == ctrlname.toLowerCase()) {
                        alert("Already Exist!!!");
                        return false;
                    }
                }

                if (checkDuplicate(ctrlname)) {
                    alert("Duplicate Tags !!!");
                    return false;
                }
                document.getElementById("<%= hdntag.ClientID %>").value += '|' + ctrlname + ',' + ctrlvalue + ',' + '0,0';
                maketaghtmls();
            } else
                alert('Tag Too Small');
            return false;
        }


        function checkDuplicate(str) {

            var hdnvalue = (document.getElementById("<%= hdntag.ClientID %>").value).split('|');
            for (var j = 0; j < hdnvalue.length; j++) {
                if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
                    return true;
                }
            }
            return false;
        }

        function maketaghtmls() {
            var hdntags = (document.getElementById("<%= hdntag.ClientID %>").value).split('|');
            document.getElementById("divtag").innerHTML = "";
            document.getElementById("<%= txtinputtag.ClientID %>").value = "";

            if (hdntags.length > 1) {
                for (var i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');

                    var ul = document.getElementById("divtag");
                    var li = document.createElement('li');
                    li.style.display = "inline-block";

                    var ht = "<li style='display: inline-block;'><span class='checkoutbutton'>"
                        + "<a id='anchor" + ontag[0] + "' style='color: white; cursor: pointer; text-decoration: none;'>&nbsp;&nbsp;"
                        + ontag[0] + "&nbsp;&nbsp;<img id='img" + ontag[0] + "' src='http://www.glozzary.com/Images/tagclose.png' onclick='DeleteTag(&quot;" + ontag[1] + "&quot;,&quot;" + ontag[0] + "&quot;)'/></a></span></li>&nbsp;";

                    li.innerHTML = ht;
                    ul.appendChild(li);
                }
            }
        }

        function DeleteTag(tagid, tagname) {
            var hdntags = (document.getElementById("<%= hdntag.ClientID %>").value).split('|');
            var temp = "";

            if (hdntags.length > 1) {
                for (var i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');

                    if ((ontag[1] != tagid) && (ontag[0] != tagname))
                        temp += "|" + hdntags[i];
                    else if ((tagid == 0) && (tagname != ontag[0]))
                        temp += "|" + hdntags[i];
                }
            }
            document.getElementById("<%= hdntag.ClientID %>").value = temp;
            maketaghtmls();
        }

        function AddNewTag() {
            if (document.getElementById("<%= txtinputtag.ClientID %>") != null) {
                if (document.getElementById("<%= txtinputtag.ClientID %>").value.length > 2) {
                    if (checkDuplicate(document.getElementById("<%= txtinputtag.ClientID %>").value)) {
                        alert("Duplicate Tag !!!");
                        return false;
                    }
                    document.getElementById("<%= hdntag.ClientID %>").value += '|' + document.getElementById("<%= txtinputtag.ClientID %>").value + ',0,0,0';
                    maketaghtmls();
                } else {
                    alert('Tag Too Small');
                    return false;
                }
            }
            return false;
        }


    </script>

    <div id="wrapper">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Rateable Tag
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">

                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 20%;">Name</td>
                                <td style="width: 80%;">
                                    <asp:TextBox ID="txtRateGrouName" placeholder="Group Name" runat="server" CssClass="form-control" MaxLength="50"  Style="width: 100%;" /> 
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtRateGrouName" Text="*"></asp:RequiredFieldValidator>
                                    <br/>
                                </td>
                            </tr>
                            <tr>
                                <td>Rateable Tag</td>
                                <td>
                                    <div class="input-group" style="width: 100%;">
                                        <div class="input-group" style="width: 100%;">
                                            <input type="text" id="txtinputtag" runat="server" class="form-control textbox" style="width: 100%;" placeholder="New" MaxLength="50" />
                                            <span class="input-group-btn">
                                                <button id="btnAddtag" title="Add New Tag" onclick=" AddNewTag() " class="btn btn-default" type="button">Add</button>
                                            </span>
                                        </div>
                                    </div>
                                    <br/>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td> <ul id="divtag" class="unorderlist">
                                     </ul>
                                    <br/>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><asp:Button ID="btnadd" runat="server" Text="Save" CssClass="btn btn-default" OnClick="btnadd_Click" /></td>    
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <br/>
                                    <textarea id="txtscript" runat="server" enableviewstate="true" style="height: 150px; width: 100%;" class="textbox" disabled="disabled"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><asp:Button ID="btnGenerateScript" runat="server" Text="Generate Script" CssClass="btn btn-default" OnClick="btnGenerateScript_Click" /><br/></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="hdntag" type="hidden" runat="server" value="" />
</asp:Content>