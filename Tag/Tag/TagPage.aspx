<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TagPage.aspx.cs" Inherits="Tag.Tag.TagPage" %>

<html>
<head>
    <title>Glozzary</title>
    <link rel="shortcut icon" href="../Images/icon.ico" />
    <link href="Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <link href="Styles/css/smoothness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
    <script src="Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <script src="Script/jquery-ui-1.10.4/jquery-ui-1.10.4.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            Maketaghtml();
        })

        $(document).ready(function () {
            $("#Howtag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/HowTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "How");
                 },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        $(document).ready(function () {
            $("#Whotag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/WhoTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "Who");
                 },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        $(document).ready(function () {
            $("#Whytag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/WhyTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "Why");
                 },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        $(document).ready(function () {
            $("#Whentag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/WhenTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "When");
                },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        $(document).ready(function () {
            $("#Wheretag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/WhereTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "Where");
                },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        $(document).ready(function () {
            $("#Whattag").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TagPage.aspx/WhatTagIntellisense",
                        dataType: "json",
                        data: "{'prefixText': '" + request.term + "','websitename': '<%=WebsiteName%>'}",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.Name,
                                    value: item.Value,
                                    name: item.Name
                                }
                            }))
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddTag(ui.item.name, ui.item.value, "What");

                },
                open: function () {
                    $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
                },
                close: function () {
                    $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        });

        function maketaghtmls(act) {

            var divid = "div" + act + "tag"
                , hdnid = "hdn" + act + "tag"
                , txtid = act + "tag";

            var Howhdntags = (document.getElementById(hdnid).value).split('|');
            document.getElementById(divid).innerHTML = "";

            document.getElementById(txtid).value = "";

            if (Howhdntags.length > 1) {
                for (i = 1; i < Howhdntags.length; i++) {
                    var ontag = Howhdntags[i].split(',');

                    if (ontag[2] == "0")
                        document.getElementById(divid).innerHTML += "<span  class='post-tag'><a id='anchor" + ontag[1] + "'>" + ontag[0] + "</a></span>";
                    else if (ontag[2] == "1")
                        document.getElementById(divid).innerHTML += "<span  class='post-tag'><a id='anchor" + ontag[1] + "'>" + ontag[0] + "</a><img id='img" + ontag[1] + "' style='cursor:pointer;' title='unTagIt' onclick='DeleteTags(&quot;" + ontag[1] + "&quot;,&quot;" + act + "&quot;)' src='Images/tagclose.png' /></span>";

                }
            }

        }

        function Maketaghtml() {

            maketaghtmls("What");
            maketaghtmls("Where");
            maketaghtmls("When");
            maketaghtmls("Why");
            maketaghtmls("Who");
            maketaghtmls("How");

        }

        function Makeeditabletaghtml(act) {
            var divid = "div" + act + "tag"
                , hdnid = "hdn" + act + "tag"
                , txtid = act + "tag";

            var hdntags = (document.getElementById(hdnid).value).split('|');

            if (hdntags.length > 1) {
                for (i = (hdntags.length) - 1; i == (hdntags.length) - 1; i--) {
                    var ontag = hdntags[i].split(',');
                    document.getElementById(divid).innerHTML += "<span  class='post-tag'><a id='anchor" + ontag[1] + "'>" + ontag[0] + "</a><img id='img" + ontag[1] + "' style='cursor:pointer;' title='unTagIt' onclick='DeleteTags(&quot;" + ontag[1] + "&quot;,&quot;" + act + "&quot;)' src='Images/tagclose.png' /></span>";
                }
            }
            document.getElementById(txtid).value = "";
        }

        function closewindow() {
            this.close();
        }

        function AddTag(ctrlname, ctrlvalue, act) {

            if (ctrlname.length > 2) {
                var divid = "div" + act + "tag",
                    hdnid = "hdn" + act + "tag";

                var htag = document.getElementById(hdnid).value.split('|');

                if (htag.length > 30) {
                    alert("Cannot associate more than 30 tags!!!");
                    return false;
                }

                for (i = 1; i < htag.length; i++) {
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

                document.getElementById(hdnid).value += '|' + ctrlname + ',' + ctrlvalue + ',' + '1';
                Makeeditabletaghtml(act)

            }
            else
                alert('Tag Too Small');
        }

        function checkDuplicate(str) {
            var arr = ["hdnWhattag", "hdnWheretag", "hdnWhentag", "hdnWhotag", "hdnWhytag", "hdnHowtag"];

            for (i = 0; i < arr.length; i++) {

                var hdnvalue = (document.getElementById(arr[i]).value).split('|');
                for (j = 0; j < hdnvalue.length; j++) {
                    if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
                        return true;
                    }
                }
            }
            return false;
        }

        function DeleteTags(tagid, act) {

            var hdnid = "hdn" + act + "tag";
            var hdntags = (document.getElementById(hdnid).value).split('|');
            var temp = "";

            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');
                    if (ontag[1] != tagid)
                        temp += "|" + hdntags[i];
                }
            }

            document.getElementById(hdnid).value = temp;

            switch (act) {
                case "What":
                    maketaghtmls("What");
                    break;

                case "Where":
                    maketaghtmls("Where");
                    break;

                case "When":
                    maketaghtmls("When");
                    break;

                case "Why":
                    maketaghtmls("Why");
                    break;

                case "Who":
                    maketaghtmls("Who");
                    break;

                case "How":
                    maketaghtmls("How");
                    break;

                default:
                    break;

            }
        }

        function btnaddtags(id, act) {
            var divid = "div" + act + "tag",
                hdnid = "hdn" + act + "tag",
                txtid = act + "tag";

            if (document.getElementById(txtid) != null) {
                if (document.getElementById(txtid).value.length > 2) {
                    if (checkDuplicate(document.getElementById(txtid).value)) {
                        alert("Duplicate Tag !!!");
                        return false;
                    }
                    document.getElementById(hdnid).value += '|' + document.getElementById(txtid).value + ',0,1';
                    maketaghtmls(act);
                }
                else {
                    alert('Tag Too Small');
                    return false;
                }
            }

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table border="0" style="width: 100%; text-align: left;">
            <tr>
                <td>What
                    :
                </td>
                <td>Where : </td>
            </tr>
            <tr>
                <td>
                    <input id="Whattag" type="text" style="width: 250px;">
                    &nbsp;&nbsp;&nbsp;
                    <input id="btnAddwhattag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'What')">
                </td>
                <td>
                    <input id="Wheretag" type="text" style="width: 250px;">
                    &nbsp;&nbsp;&nbsp;
                    <input id="btnAddwheretag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'Where')">
                </td>
            </tr>
            <tr>
                <td>
                    <span id="divWhattag" runat="server" class="second"></span>
                </td>
                <td><span id="divWheretag" runat="server" class="second"></span>
                </td>
            </tr>
            <tr>
                <td>Who : </td>
                <td>When : </td>
            </tr>
            <tr>
                <td>
                    <input id="Whotag" type="text" style="width: 250px;">
                    &nbsp;&nbsp;&nbsp;
                    <input id="btnAddwhotag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'Who')">
                </td>
                <td>
                    <input id="Whentag" type="text" style="width: 250px;">&nbsp;&nbsp;&nbsp;
                    <input id="btnAddwhentag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'When')" />
                </td>
            </tr>
            <tr>
                <td>
                    <span id="divWhotag" runat="server"></span>
                </td>
                <td><span id="divWhentag" runat="server"></span>
                </td>
            </tr>
            <tr>
                <td>Why : </td>
                <td>How : </td>
            </tr>
            <tr>
                <td>
                    <input id="Whytag" type="text" style="width: 250px;">
                    &nbsp;&nbsp;&nbsp;
                    <input id="btnAddwhytag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'Why')">
                </td>
                <td>
                    <input id="Howtag" type="text" style="width: 250px;">
                    &nbsp;&nbsp;&nbsp;
                    <input id="btnAddhowtag" type="button" title="Add" value="Add" onclick="btnaddtags(this.id, 'How')">
                </td>
            </tr>
            <tr>
                <td>
                    <span id="divWhytag" runat="server"></span>
                </td>
                <td><span id="divHowtag" runat="server"></span>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClientClick="closewindow();" OnClick="btnSave_Click" Width="100px" />&nbsp;
                  <%--  <a id="lnkaddtag" title="Tag Not Found" target="_blank" href="TagPage/AddTag.aspx">Tag Not Found </a>--%>
                </td>
            </tr>
        </table>
        <input id="hdnWhattag" type="hidden" runat="server" value="" />
        <input id="hdnWheretag" type="hidden" runat="server" value="" />
        <input id="hdnWhentag" type="hidden" runat="server" value="" />
        <input id="hdnWhotag" type="hidden" runat="server" value="" />
        <input id="hdnWhytag" type="hidden" runat="server" value="" />
        <input id="hdnHowtag" type="hidden" runat="server" value="" />
    </form>
</body>
</html>