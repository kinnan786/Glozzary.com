<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Emotion.aspx.cs" Inherits="Tag.Emotion" %>
<%@ Import Namespace="System.Runtime.Remoting.Messaging" %>
<html>
<head>
    <title>Glozzary</title>
    <link rel="shortcut icon" href="Images/icon.ico" />
    <script src="Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
    <script src="Script/jquery-ui-1.10.4/jquery-ui-1.10.4.min.js"></script>
    <link href="Styles/css/smoothness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
    <link href="Styles/StyleSheet2.css" rel="stylesheet" />
    <script src="Script/StandardJavascript.js"></script>
    <script type="text/javascript">

        function HidePopup() {
            parent.document.forms[0].submit();
        }

        ///////bookmarklet/////////////////////////////

        function RateEmotion(Id, rate) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Emotion.aspx/RateEmotion",
                        contentType: "application/json; charset=utf-8",
                        data: "{premalink : '" + window.location + "' ,EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1;
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1;

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (var i = 0; i < htm.children.length; i++) {
                                            console.log(htm.children[i].nodeName.toUpperCase());
                                            if (htm.children[i].nodeName.toUpperCase() == "IMG")
                                                htm.removeChild(htm.children[i]);
                                        }
                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','plus')");
                                    }
                                }
                            }
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    });
                });
            }
            else {
                window.location = "http://www.glozzary.com/Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        function RateEmotio(Id, rate) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Emotion.aspx/RateEmotion",
                        contentType: "application/json; charset=utf-8",
                        data: "{premalink : '<%= ViewState["premalink"].ToString() %>' ,EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1;
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1;

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (i = 0; i < htm.children.length; i++) {
                                            console.log(htm.children[i].nodeName.toUpperCase());
                                            if (htm.children[i].nodeName.toUpperCase() == "IMG")
                                                htm.removeChild(htm.children[i]);
                                        }
                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','plus')");
                                    }
                                }
                            }
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    });
                });
            }
            else {
                window.location = "http://www.glozzary.com/Default.aspx?prevurl=" + document.forms[0].action;
            }
        }
        function StartInlinecodeEmotion() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Emotion.aspx/GetPremalinkEmotions",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : '<%= ViewState["premalink"].ToString() %>' }",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function(msg) {
                        if (msg.d != null) {
                            var dataArray = "";
                            dataArray = jQuery.parseJSON(msg.d);
                            for (var Item in dataArray.Emotion.Item) {
                                document.getElementById("hdnemo").value += '|' + dataArray.Emotion.Item[Item].Name + ',' + dataArray.Emotion.Item[Item].Id + ',' + dataArray.Emotion.Item[Item].Vote + ',' + dataArray.Emotion.Item[Item].UserEmotion.toString();
                            }
                            maketaghtmls("bookmarklet");
                        }
                    },
                    error: function(request, status, error) {
                        console.log(request.responseText);
                    }
                });
            });
        }

        function StartBookmarkletEmotion() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Emotion.aspx/GetPremalinkEmotions",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : '<%= ViewState["premalink"].ToString() %>' }",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function(msg) {
                        if (msg.d != null) {
                            var dataArray = "";
                            dataArray = jQuery.parseJSON(msg.d);
                            for (var Item in dataArray.Emotion.Item) {
                                document.getElementById("hdnemo").value += '|' + dataArray.Emotion.Item[Item].Name + ',' + dataArray.Emotion.Item[Item].Id + ',' + dataArray.Emotion.Item[Item].Vote + ',' + dataArray.Emotion.Item[Item].UserEmotion.toString();
                            }
                            maketaghtmls("bookmarklet");
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);

                    }
                });
            });
        }

        function StartEmotion() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Emotion.aspx/GetEmotion",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'tagId' : '<%= Convert.ToInt64(ViewState["TagId"].ToString()) %>'}",
                    async: false,
                    cache: false,
                    success: function(msg) {
                        if (msg.d != null) {

                            document.getElementById("hdnemo").value = "";
                            document.getElementById("hdnemo").value = msg.d;

                            maketaghtmls("tagged");
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                });
            });
        }

        function StartcontentEmotion() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Emotion.aspx/GetPremalinkEmotions",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : '<%= ViewState["premalink"].ToString() %>' }",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function(msg) {
                        if (msg.d != null) {
                            var dataArray = "";
                            dataArray = jQuery.parseJSON(msg.d);
                            for (var Item in dataArray.Emotion.Item) {
                                document.getElementById("hdnemo").value += '|' + dataArray.Emotion.Item[Item].Name + ',' + dataArray.Emotion.Item[Item].Id + ',' + dataArray.Emotion.Item[Item].Vote + ',' + dataArray.Emotion.Item[Item].UserEmotion.toString();
                            }
                            maketaghtmls("bookmarklet");
                        }
                    },
                    error: function(request, status, error) {
                        alert(request.responseText);
                    }
                });
            });
        }

        function CreateEmotion() {

            var html = "";
            if (document.getElementById("hdnemo") != null) {

                var hdnemoa = document.getElementById("hdnemo").value.split('|');

                for (i = 1; i < hdnemoa.length; i++) {
                    var oneemo = hdnemoa[i].split(',');
                    if (oneemo[3].toString() == "true")
                        html += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','minus')\" ><img id='imgemo" + oneemo[1] + "' src='Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                    else
                        html += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','plus')\" >" + oneemo[0] + "</a></span></span>";
                }
            }
            return html;
        }

        function AddEmotion(Name, Id) {
            if (Name.length > 2) {

                var hdnemo = (document.getElementById("hdnemo").value).split('|');

                if (hdnemo.length > 30) {
                    alert("Cannot associate more than 30 Emotions!!!");
                    return false;
                }

                for (i = 1; i < hdnemo.length; i++) {
                    var oneemo = hdnemo[i].split(',');

                    if (oneemo[0].toLowerCase() == Name.toLowerCase()) {
                        alert("Already Exist!!!");
                        return false;
                    }
                }

                if (checkDuplicate(Name)) {
                    alert("Duplicate Emotion !!!");
                    return false;
                }

                document.getElementById("hdnemo").value += '|' + Name + ',' + Id + ',' + '0,new';
                MakeEditableEmotionHtml();
            }
            else
                alert('Emotion Too Small');
        }

        function MakeEditableEmotionHtml() {
            var hdnemo = (document.getElementById("hdnemo").value).split('|');

            if (hdnemo.length > 1) {
                for (var i = (hdnemo.length) - 1; i == (hdnemo.length) - 1; i--) {
                    var oneemo = hdnemo[i].split(',');

                    var ul = document.getElementById("divemotion");
                    var li = document.createElement('li');
                    li.style.display = "inline-block";


                    li.innerHTML = "<span class='PinItCount'><span Id='divemo" + oneemo[1] + "'  class='CountBubble'>" + oneemo[2] + "</span></span><br/><span class='checkoutbutton'><a id=lnkemo'" + oneemo[1] + "' onclick='DeleteEmotion(&quot;" + oneemo[1] + "&quot;)' ><img id='imgemo" + oneemo[1] + "' src='Images/tagclose.png'>" + oneemo[0] + "</img></a></span>&nbsp;&nbsp;";
                    ul.appendChild(li);
                }
            }
        }

        function RateTaggedEmotion(Id, rate) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Emotion.aspx/RateTaggedEmotion",
                        contentType: "application/json; charset=utf-8",
                        data: "{EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "',tagid:'<%= Convert.ToInt64(ViewState["TagId"]) %>' }",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function(msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1;
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateTaggedEmotion('" + Id + "','minus')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1;

                                        var htm = document.getElementById("lnkemo" + Id);

                                        for (i = 0; i < htm.children.length; i++) {
                                            console.log(htm.children[i].nodeName.toUpperCase());
                                            if (htm.children[i].nodeName.toUpperCase() == "IMG")
                                                htm.removeChild(htm.children[i]);
                                        }
                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateTaggedEmotion('" + Id + "','plus')");
                                    }
                                }
                            }
                        },
                        error: function(request, status, error) {
                            alert(request.responseText);
                        }
                    });
                });
            }
            else {
                window.location = "Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        function checkDuplicate(str) {

            var hdnvalue = (document.getElementById("hdnemo").value).split('|');
            for (j = 0; j < hdnvalue.length; j++) {
                if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
                    return true;
                }
            }
            return false;
        }

        function maketaghtmls(flow) {
            var hdntags = (document.getElementById("hdnemo").value).split('|');
            document.getElementById("divemotion").innerHTML = "";
            var Ratefunctionname = "";
            var Deletefunctionname = "";

            if (flow == "profile") {
                Ratefunctionname = "RateUserEmotion";
                Deletefunctionname = "DeleteUserEmotion";

            } else if (flow == "bookmarklet") {
                Ratefunctionname = "RateEmotio";
                Deletefunctionname = "DeleteEmotio";
            }
            else if (flow == "tagged") {
                Ratefunctionname = "RateTaggedEmotion";
                Deletefunctionname = "DeleteTaggedEmotion";
            }

          
            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var oneemo = hdntags[i].split(',');
                    
                    var ul = document.getElementById("divemotion");
                    var li = document.createElement('li');
                    li.style.display = "inline-block";


                    if (oneemo[3].toString() == "true")
                        li.innerHTML = "<span class='PinItCount'><span Id='divemo" + oneemo[1] + "'  class='CountBubble'>" + oneemo[2] + "</span></span><br/><span class='checkoutbutton'><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"" + Ratefunctionname + "('" + oneemo[1] + "','minus')\" ><img id='imgemo" + oneemo[1] + "' src='Images/tagclose.png'>" + oneemo[0] + "</img></a></span>&nbsp;&nbsp;";
                    else if (oneemo[3].toString() == "new")
                        li.innerHTML = "<span class='PinItCount'><span Id='divemo" + oneemo[1] + "'  class='CountBubble'>" + oneemo[2] + "</span></span><br/><span class='checkoutbutton'><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"" + Deletefunctionname + "('" + oneemo[1] + "')\" ><img id='imgemo" + oneemo[1] + "' src='Images/tagclose.png'>" + oneemo[0] + "</img></a></span>&nbsp;&nbsp;";
                    else
                        li.innerHTML = "<span class='PinItCount'><span Id='divemo" + oneemo[1] + "'  class='CountBubble'>" + oneemo[2] + "</span></span><br/><span class='checkoutbutton'><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"" + Ratefunctionname + "('" + oneemo[1] + "','plus')\" >" + oneemo[0] + "</a></span>&nbsp;&nbsp;";

                    ul.appendChild(li);

                }
            }
        }

        function DeleteEmotion(emoid) {
            var hdntags = (document.getElementById("hdnemo").value).split('|');
            var temp = "";

            if (hdntags.length > 1) {
                for (i = 1; i < hdntags.length; i++) {
                    var ontag = hdntags[i].split(',');
                    if (ontag[1] != emoid) {
                        temp += "|" + hdntags[i];
                    }
                }
            }

            document.getElementById("hdnemo").value = temp;
            maketaghtmls("bookmarklet");
        }

        function AddNewEmotion() {
            if (document.getElementById("txtinputEmotion") != null) {
                if (document.getElementById("txtinputEmotion").value.length > 2) {
                    if (checkDuplicate(document.getElementById("txtinputEmotion").value)) {
                        alert("Duplicate Emotion !!!");
                        return false;
                    }
                    document.getElementById("hdnemo").value += '|' + document.getElementById("txtinputEmotion").value + ',0,0,new';
                    maketaghtmls("bookmarklet");
                }
                else {
                    alert('Emotion Too Small');
                    return false;
                }
            }
        }

        ///////////////////////bookmarklet

        ////////////////////////profile

        function StartUserProfileEmotion() {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Emotion.aspx/GetUserEmotion",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{profileUserId :'<%=Convert.ToInt64(ViewState["ProfileUserID"]) %>'}",
                    async: true,
                    cache: false,
                    success: function (msg) {

                        if (msg.d != null) {
                            document.getElementById("hdnemo").value += msg.d;
                            maketaghtmls("profile");
                        }
                    },
                    error: function (request, status, error) {
                        console.log(request.responseText);
                    }
                })
            });
        }

        function RateUserEmotion(Id, rate) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Emotion.aspx/RateUserEmotion",
                        contentType: "application/json; charset=utf-8",
                        data: "{EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "',profileUserId:'<%=Convert.ToInt64(ViewState["ProfileUserID"]) %>' }",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateUserEmotion('" + Id + "','minus')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (i = 0 ; i < htm.children.length; i++) {
                                            console.log(htm.children[i].nodeName.toUpperCase());
                                            if (htm.children[i].nodeName.toUpperCase() == "IMG")
                                                htm.removeChild(htm.children[i]);
                                        }
                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateUserEmotion('" + Id + "','plus')");
                                    }
                                }
                            }
                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
            else {
                window.location = "Default.aspx?prevurl=" + document.forms[0].action;
            }
        }

        function checkCookie() {
            if (document.cookie.split('=')[2] != null) {
                return true;
            }
            else {
                return false;
            }
        }

        function closewindow() {
            this.close();
        }

        $(document).ready(function () {
            $("#txtinputEmotion").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "Emotion.aspx/EmotionIntellisense",
                        dataType: "json",
                        data: "{'PrefixText': '" + request.term + "', Premalink : '" + window.location + "'}",
                        success: function (data) {
                            if (data.d != "") {
                                response($.map(data.d, function(item) {
                                    return {
                                        label: item.Name,
                                        value: item.Value,
                                        name: item.Name
                                    };
                                }));
                            }
                            else {
                                var nosuggestion = ["No Suggestions"];
                                response(nosuggestion);
                            }
                        }
                    });
                },
                minLength: 2,
                select: function (event, ui) {
                    AddEmotion(ui.item.name, ui.item.value);
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <div style="width: 100%; text-align: center">
            <input type="text" id="txtinputEmotion" runat="server" style="width: 500px;" class="form-control textbox" placeholder="Add New Emotion" />&nbsp;
            <input id="btnAddEmotion" type="button" title="Add" value="Add" class="simplebutton" onclick="AddNewEmotion()" />
            <br/><br/>
             <ul id="divemotion" class="unorderlist">
             </ul>
        </div>
        <br/><br/><br/><br/><br/><br/>
        <div class="divprecaution">
            "NOTE : NO <span class="auto-style1">Abusive and offensive Emotions</span>. It will be Deleted within 24 hours and a warning or suspension will be issued to the user ."
        </div>
        <div style="height: 16.43px; padding: 15px; border-top: 1px solid #e5e5e5; float: right; vertical-align: bottom; text-align: right; width: 100%">
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="simplebutton" />&nbsp;
        </div>
        <input id="hdnemo" type="hidden" runat="server" value="" />
    </form>
</body>
</html>