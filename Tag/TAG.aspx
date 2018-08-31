<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TAG.aspx.cs" Inherits="Tag.TAG" %>

<html>
<head>
    <title>Glozzary</title>
    <link rel="shortcut icon" href="Images/icon.ico" />
    
    <script src="Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <script src="Script/jquery-ui-1.10.4/jquery-ui-1.10.4.min.js"></script>
    <link href="Styles/css/smoothness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />

    <link href="Styles/StyleSheet2.css" rel="stylesheet" />
    <link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="Script/StandardJavascript.js"></script>

    <script type="text/javascript">
        function voteTag(e, t) {
            if (checkCookie()) {
                $(document).ready(function() {
                    $.ajax({
                        type: "POST",
                        url: "TAG.aspx/voteTag",
                        data: "{'premalink': '<%= ViewState["Premalink"].ToString() %>','tagId':'" + e + "','vote':'" + t + "','flow':'<%= ViewState["flow"].ToString()%>','TagId':'<%= Convert.ToInt64(ViewState["TagId"])%>','profileUserId':'<%= Convert.ToInt64(ViewState["ProfileUserID"])%>'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(n) {
                            if (n != null) {
                                if (t == "UpVote") document.getElementById("div" + e).innerText = parseInt(document.getElementById("div" + e).innerText) + 1;
                                else document.getElementById("div" + e).innerText = parseInt(document.getElementById("div" + e).innerText) - 1;
                            }
                        },
                        error: function(e, t, n) {
                            alert(e.responseText);
                        }
                    });
                });
            } else {
                window.location = "Default.aspx?prevurl=" + document.forms[0].action
            }
        }

        function StartcontentTags() {
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "TAG.aspx/GetwallTags",
                    data: "{Premalink:'<%=ViewState["Premalink"].ToString()%>'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(e) {
                        var dataArray = jQuery.parseJSON(e.d);
                        document.getElementById("hdntag").value = "";
                        for (var i = 0; i < dataArray.Tag.Item.length; i++) {
                            document.getElementById("hdntag").value += "|" + dataArray.Tag.Item[i].TagName + "," + dataArray.Tag.Item[i].Id + "," + dataArray.Tag.Item[i].Vote + ",0";
                            
                        }
                        maketaghtmls();
                    },
                    error: function(e, t, n) {
                        console.log(e.responseText);
                    }
                });
            });
        }

        function StartinlineTags() {
            $(document).ready(function() {
                $.ajax({
                    type: "POST",
                    url: "http://www.glozzary.com/TAG.aspx/GetTagsbyPremalink",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : '<%= ViewState["Premalink"].ToString() %>'}",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(e) {
                        if (e.d != null) {
                            dataArray = jQuery.parseJSON(e.d);
                            document.getElementById("hdntag").value = "";
                            for (i = 0; i < dataArray.Tag.Item.length; i++) document.getElementById("hdntag").value += "|" + dataArray.Tag.Item[i].TagName + "," + dataArray.Tag.Item[i].Id + "," + dataArray.Tag.Item[i].Vote + ",0";
                            maketaghtmls();
                        }
                    },
                    error: function(e, t, n) {
                        console.log(e.responseText);
                    }
                });
            });
        }

        $(document).ready(function() {
            $("#txtinputtag").autocomplete({
                source: function(e, t) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "TAG.aspx/TagIntellisense",
                        dataType: "json",
                        data: "{'PrefixText': '" + e.term + "', Premalink : '<%= ViewState["Premalink"].ToString() %>'}",
                        success: function(e) {
                            if (e.d != "") {
                                t($.map(e.d, function(e) {
                                    return {
                                        label: e.Name,
                                        value: e.Value,
                                        name: e.Name
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

        function StartTaggedTags() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "TAG.aspx/GetTagged",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'tagId' : '<%= Convert.ToInt64(ViewState["TagId"]) %>'}",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        document.getElementById("hdntag").value = "";
                        document.getElementById("hdntag").value = msg.d;
                        maketaghtmls();
                    },
                    error: function(request, status, error) {
                        console.log(request.responseText);
                    }
                });
            });
        }

        var UserID, TagId = 0;
        function AddTag(ctrlname, ctrlvalue) {

            if (ctrlname.length > 2) {

                var htag = document.getElementById("hdntag").value.split('|');

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
                document.getElementById("hdntag").value += '|' + ctrlname + ',' + ctrlvalue + ',' + '1,1';
                maketaghtmls();
            }
            else
                alert('Tag Too Small');
        }

        function StartUserProfileTags() {

            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "TAG.aspx/GetUserTags",
                    data: "{'profileUserId': '<%=Convert.ToInt64(ViewState["ProfileUserID"]) %>'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(msg) {

                        document.getElementById("hdntag").value = "";
                        document.getElementById("hdntag").value += msg.d;
                        maketaghtmls();
                    },
                    error: function(request, status, error) {
                        console.log(request.responseText);
                    }
                });
            });

        }

        function StartBookmarkletTags() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "http://www.glozzary.com/TAG.aspx/GetTagsbyPremalink",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : '<%= ViewState["Premalink"].ToString()%>'}",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function(msg) {
                        if (msg.d != null) {
                            dataArray = jQuery.parseJSON(msg.d);

                            document.getElementById("hdntag").value = "";
                            for (i = 0; i < dataArray.Tag.Item.length; i++)
                                document.getElementById("hdntag").value += '|' + dataArray.Tag.Item[i].TagName + ',' + dataArray.Tag.Item[i].Id + ',' + dataArray.Tag.Item[i].Vote + ',0';

                            maketaghtmls();
                        }
                    },
                    error: function(request, status, error) {
                        console.log(request.responseText);
                    }
                });
            });
        }

        function checkDuplicate(str) {

            var hdnvalue = (document.getElementById("hdntag").value).split('|');
            for (var j = 0; j < hdnvalue.length; j++) {
                if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
                    return true;
                }
            }
            return false;
        }

        function maketaghtmls() {
            var hdntags = (document.getElementById("hdntag").value).split('|');
            document.getElementById("divtag").innerHTML = "";
            document.getElementById("txtinputtag").value = "";

            if (hdntags.length > 1)
            {
                for (var i = 1; i < hdntags.length; i++)
                {
                    var ontag = hdntags[i].split(',');
                    var len = parseInt(Math.floor((ontag[0].length) / 2));
                    var first = "";
                    var second = "";
                    
                    for (var x = 0 ; x < len; x++) {
                        first += String(ontag[0][x]);
                    }

                    for (var j = len ; j < ontag[0].length; j++) {
                        second += String(ontag[0][j]);
                    }

                    var ul = document.getElementById("divtag");
                    var li = document.createElement('li');
                    li.style.display = "inline-block";
                    
                    if (ontag[3] == 1)
                        li.innerHTML = "<span class='PinItCount' ><span Id='div" + ontag[1] + "' class='CountBubble'>0</span></span><br/><span class='checkoutbutton'><img id='img'" + ontag[1] + " onclick='DeleteTag(&quot;" + ontag[1] + "&quot;,&quot;" + ontag[0] + "&quot;)' src= 'http://www.glozzary.com/Images/tagclose.png' /><a style='color:white; text-decoration:none;'>&nbsp;&nbsp;&nbsp;" + first + second + "&nbsp;&nbsp;&nbsp;</a></span>&nbsp;&nbsp;";
                    else
                        li.innerHTML = "<span class='PinItCount' ><span Id='div" + ontag[1] + "'  class='CountBubble'>" + ontag[2] + "</span></span><br/><span class='checkoutbutton'><a id='anchordown" + ontag[1] + "' title='Down Vote' class='downVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchorup" + ontag[1] + "' title='Up Vote' class='upVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span>&nbsp;&nbsp;";

                    ul.appendChild(li);

                    first = "";
                    second = "";
                }
            }
        }

        function DeleteTag(tagid, tagname) {
            var hdntags = (document.getElementById("hdntag").value).split('|');
            var temp = "";

            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');

                    if ((ontag[1] != tagid) && (ontag[0] != tagname))
                        temp += "|" + hdntags[i];
                    else if ((tagid == 0) && (tagname != ontag[0]))
                        temp += "|" + hdntags[i];
                }
            }
            document.getElementById("hdntag").value = temp;
            maketaghtmls();
        }

        function AddNewTag() {
            if (document.getElementById("txtinputtag") != null) {
                if (document.getElementById("txtinputtag").value.length > 2) {
                    if (checkDuplicate(document.getElementById("txtinputtag").value)) {
                        alert("Duplicate Tag !!!");
                        return false;
                    }
                    document.getElementById("hdntag").value += '|' + document.getElementById("txtinputtag").value + ',0,0,1';
                    maketaghtmls();
                }
                else {
                    alert('Tag Too Small');
                    return false;
                }
            }
        }

        function closewindow() {
            this.close();
        }
    </script>
</head>
<body style="width: 100%; text-align: center;">
    <form id="form1" runat="server" style="width: 100%; text-align: center;">
        <br />
        <div style="width: 100%; text-align: center">
            <div class="row">
                <div class="col-lg-6">
                    <div class="input-group">
                        <div class="input-group" style="width: 100%;">
                            <input type="text" id="txtinputtag" runat="server" class="form-control textbox" style="width: 500px;" placeholder="Add New Tag" />
                            <span class="input-group-btn">
                                <button id="btnAddtag" title="Add New Tag" onclick="AddNewTag()" class="simplebutton" type="button">Add</button>
                            </span>
                        </div>
                    </div>
                    <!-- /input-group -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
            <br/>
             <ul id="divtag" class="unorderlist">
             </ul>
        </div>
        <br/><br/><br/><br/><br/><br/>
        <div class="divprecaution">
            "NOTE : NO <span class="auto-style1">Abusive and offensive Tags</span>. It will be Deleted within 24 hours and a warning or suspension will be issued to the user ."
        </div>
        <div style="height: 16.43px; padding: 15px; border-top: 1px solid #e5e5e5; float: right; vertical-align: bottom; text-align: right; width: 100%">
            <asp:Button ID="btnSave" runat="server" Text="Save" class="simplebutton" Style="width: 100px;" OnClick="btnSave_Click" />
        </div>
        <input id="hdntag" type="hidden" runat="server" value="" />
    </form>
</body>
</html>