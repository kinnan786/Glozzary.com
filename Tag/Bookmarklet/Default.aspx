<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tag.Bookmarklet.Default" %>
<html>
<head>
    <link href="../Script/jquery-ui.css" rel="stylesheet" />
    <script src="../Script/jquery-1.10.2.js"></script>
    <script src="../Script/jquery-ui.js"></script>
    <link href="../Styles/StyleSheet2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        
        $(document).ready(function () {
            Main();
        });

        ////////////////////////////////////////////////////////////////////Emotion///////////////////////////////////////////////////////////////////////////

        function RateEmotion(Id, rate)
        {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "Default.aspx/RateEmotion",
                        contentType: "application/json; charset=utf-8",
                        data: "{Premalink : 'http://localhost:15064/HTMLPage4.htm',EmotionId :" + parseInt(Id) + ",Rate : '" + rate + "' }",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            if (msg.d != null) {
                                if (msg.d > 0) {
                                    if (rate == 'plus') {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) + 1
                                        console.log("1")
                                        $(document.getElementById("lnkemo" + Id)).prepend("<img id='imgemo1' src='../Images/tagclose.png'>");

                                        $(document.getElementById("lnkemo" + Id)).removeAttr("onclick");
                                        $(document.getElementById("lnkemo" + Id)).attr("onclick", "RateEmotion('" + Id + "','minus')");

                                    } else {
                                        document.getElementById("divemo" + Id).innerText = parseInt(document.getElementById("divemo" + Id).innerText) - 1

                                        var htm = document.getElementById("lnkemo" + Id);
                                        console.log(htm);

                                        for (i = 0 ; i < htm.children.length; i++)
                                        {
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
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
            else
                alert("not Login");
        }

        function GetEmotion() {
            var dataArray = "";

            var div = document.createElement("div");
            div.id = "emotiondiv";
            div.innerHTML = "";

            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetPremalinkEmotions",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : 'http://localhost:15064/HTMLPage4.htm' }",
                    dataType: "json",
                    async: false,
                    cache: false,
                    success: function (msg)
                    {
                        if (msg.d != null)
                        {
                            dataArray = jQuery.parseJSON(msg.d);
                            for (var Item in dataArray.Emotion.Item) {
                                document.getElementById("hdnemo").value += '|' + dataArray.Emotion.Item[Item].Name + ',' + dataArray.Emotion.Item[Item].Id + ',' + dataArray.Emotion.Item[Item].Vote + ',' + dataArray.Emotion.Item[Item].UserEmotion.toString();
                            }
                            div.innerHTML = CreateEmotion();
                        }
                        else
                            alert('error');
                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                    }
                })
            });

            return div;
        }

        function CreateEmotion() {
            
            var html = "";
            if (document.getElementById("hdnemo") != null) {

                var hdnemoa = document.getElementById("hdnemo").value.split('|');
                
                    for (i = 1; i < hdnemoa.length; i++) {
                        var oneemo = hdnemoa[i].split(',');
                        if (oneemo[3].toString() == "true")
                            html += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','minus')\" ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                        else
                            html += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=\"lnkemo" + oneemo[1] + "\" onclick=\"RateEmotion('" + oneemo[1] + "','plus')\" >" + oneemo[0] + "</a></span></span>";
                    }
            }
            return html;
        }

        function AddEmotion(Name,Id)
        {
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

                    document.getElementById("hdnemo").value += '|' + Name + ',' + Id + ',' + '0, new';
                    MakeEditableEmotionHtml()

                }
                else
                    alert('Emotion Too Small');
        }

        function MakeEditableEmotionHtml()
        {
            var hdnemo = (document.getElementById("hdnemo").value).split('|');

            if (hdnemo.length > 1) {
                for (i = (hdnemo.length) - 1; i == (hdnemo.length) - 1; i--) {
                    var oneemo = hdnemo[i].split(',');
                    document.getElementById("emotiondiv").innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=lnkemo'" + oneemo[1] + "' onclick='DeleteEmotion(&quot;" + oneemo[1] + "&quot;)' ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                    }
                }
        }

        function DeleteEmotion(emoid)
        {
                var hdnemo = (document.getElementById("hdnemo").value).split('|');
                var temp = "";
        
                if (hdnemo.length > 1) {
                    for (i = 1; i < hdnemo.length; i++) {
                        var onemo = hdnemo[i].split(',');
                        if (onemo[1] != emoid)
                            temp += "|" + hdnemo[i];
                    }
                }

                var h;
                var htm = document.getElementById("emotiondiv");
            
                for (i = 0 ; i < htm.children.length; i++)
                {
                    if (htm.children[i].nodeName.toUpperCase() == "DIV")
                        h = htm.children[i];
                }

                document.getElementById("hdnemo").value = temp;
        
                htm.innerHTML = "";
                for (i = 1; i < temp.split('|').length; i++) 
                {
                    var oneemo = temp.split('|')[i].split(',');
                    
                        if (oneemo[3] == "new")
                            htm.innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id='lnkemo" + oneemo[1] + "' onclick='DeleteEmotion(&quot;" + oneemo[1] + "&quot;)' ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                        else if (oneemo[3] == "true")
                            htm.innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id='lnkemo" + oneemo[1] + "' onclick=\"RateEmotion('" + oneemo[1] + "','minus')\" ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                        else if (oneemo[3] == "false")
                            htm.innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divemo" + oneemo[1] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=lnkemo'" + oneemo[1] + "' onclick=\"RateEmotion('" + oneemo[1] + "','plus')\" >" + oneemo[0] + "</a></span></span>";
                }

                $(htm).prepend(h);

        }

        ////////////////////////////////////////////////////////////////////Begin Emotion////////////////////////////////////////////////////////////////////////


        ////////////////////////////////////////////////////////////////////Begin Tag///////////////////////////////////////////////////////////////////////////

        function Tag() {

            var div = document.createElement("div");
            div.id = "tagdiv";
            div.innerHTML = "";

            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetTagsbyPremalink",
                    contentType: "application/json; charset=utf-8",
                    data: "{Premalink : 'http://localhost:15064/HTMLPage4.htm' }",
                    dataType: "json",
                    async: true,
                    cache: false,
                    success: function (msg) {
                        if (msg.d != null) {

                            var dataArray = jQuery.parseJSON(msg.d);
                            for (var Item in dataArray.Tag.Item) {
                                document.getElementById("hdntag").value += '|' + dataArray.Tag.Item[Item].TagName + ',' + dataArray.Tag.Item[Item].Id + ',' + dataArray.Tag.Item[Item].Vote + ",old" ;
                            }
                            div.innerHTML = CreateTag();
                        }
                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                    }
                })
            });

            return div;
        }

        function tagcreate(t)
        {
            var str = "";

            for (i = 1; i < t.length; i++) {

                var len = parseInt(Math.floor((t[0].length) / 2));
                var first = second = "";
                var tagvote = 0;

                for (x = 0 ; x < len; x++) {
                    first += String(t[0][x]);
                }

                for (j = len ; j < t[0].length; j++) {
                    second += String(t[0][j]);
                }

                str += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divtag" + t[0] + "' class='stBubble_count'>" + t[2] + "</div></div><span class='post-tag' ><a id='anchortag" + t[0] + "' class='downVote' title='Down Vote' onclick='voteTag(&quot;" + t[0] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchortag'" + t[1] + " title='Up Vote' class='upVote' onclick='voteTag(&quot;" + t[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span></span>";

                first = "";
                second = "";
            }

            return str;
        }

        function CreateTag() {

            var hdntag = document.getElementById("hdntag").value.split('|');
            var str = "";

            for (i = 1; i < hdntag.length; i++) {

                var ontag = hdntag[i].split(',');
                var len = parseInt(Math.floor((ontag[0].length) / 2));
                var first = second = "";
                var tagvote = 0;

                for (x = 0 ; x < len; x++) {
                    first += String(ontag[0][x]);
                }

                for (j = len ; j < ontag[0].length; j++) {
                    second += String(ontag[0][j]);
                }

                str += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divtag" + ontag[0] + "' class='stBubble_count'>" + ontag[2] + "</div></div><span class='post-tag' ><a id='anchortag" + ontag[0] + "' class='downVote' title='Down Vote' onclick='voteTag(&quot;" + ontag[0] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchortag'" + ontag[1] + " title='Up Vote' class='upVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span></span>";

                first = "";
                second = "";
            }
            return str;
        }

        function DeleteTag(tagid) {

            var hdntags = (document.getElementById("hdntag").value).split('|');
            var temp = "";

            if (hdntags.length > 1)
            {
                for (i = 1; i < hdntags.length; i++)
                {
                    var ontag = hdntags[i].split(',');
                    if (ontag[1] != tagid)
                        temp += "|" + hdntags[i];
                }
            }

            var h;
            var htm = document.getElementById("tagdiv");

            for (i = 0 ; i < htm.children.length; i++) {
                if (htm.children[i].nodeName.toUpperCase() == "DIV")
                    h = htm.children[i];
            }

            document.getElementById("hdntag").value = temp;
            htm.innerHTML = "";

            for (i = 1; i < temp.split('|').length; i++)
            {
                var oneemo = temp.split('|')[i].split(',');
                
                if (oneemo[3] == "new") {
                    htm.innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divtag" + oneemo[0] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id=lnkemo'" + oneemo[1] + "' onclick='DeleteTag(&quot;" + oneemo[1] + "&quot;)' ><img id='imgemo" + oneemo[1] + "' src='../Images/tagclose.png'>" + oneemo[0] + "</img></a></span></span>";
                }
                else if (oneemo[3] == "old") {

                        var len = parseInt(Math.floor((oneemo[0].length) / 2));
                        var first = second = "";
                        var tagvote = 0;

                        for (x = 0 ; x < len; x++) {
                            first += String(oneemo[0][x]);
                        }

                        for (j = len ; j < oneemo[0].length; j++) {
                            second += String(oneemo[0][j]);
                        }

                        htm.innerHTML += "<span style='text-decoration:none;color:#000000;display:inline-block;' class='stButton'><div class='stBubble' style='display: block;'><div id='divtag" + oneemo[0] + "' class='stBubble_count'>" + oneemo[2] + "</div></div><span class='post-tag' ><a id='anchortag" + oneemo[0] + "' class='downVote' title='Down Vote' onclick='voteTag(&quot;" + oneemo[0] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchortag'" + oneemo[1] + " title='Up Vote' class='upVote' onclick='voteTag(&quot;" + oneemo[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span></span>";

                        first = "";
                        second = "";
                }
            }
            $(htm).prepend(h);
        }

        function MakeEditableTagHtml()
        {
            var hdntags = (document.getElementById("hdntag").value).split('|');
            
            if (hdntags.length > 1)
            {
                for (i = (hdntags.length) - 1; i == (hdntags.length) - 1; i--)
                {
                    var ontag = hdntags[i].split(',');
                    var span = document.createElement("span");
                    span.style.textDecoration = "none";
                    span.style.color = "#000000";
                    span.style.display = "inline-block";
                    span.className = "stButton";

                    var div = document.createElement("div");
                    div.className = "stBubble"
                    div.style.display = "block";
                    
                    var div1 = document.createElement("div");
                    div1.id = "divemo" + ontag[1];
                    div1.className = "stBubble_count";
                    div1.innerText = ontag[2];
                    div.appendChild(div1);

                    span.appendChild(div)

                    var span1 = document.createElement("span");
                    span1.className = "post-tag";

                    var a = document.createElement("a");
                    a.id = "lnkemo" + ontag[1];
                    a.innerText = "";
                    a.addEventListener("click", function (e) { DeleteTag(ontag[1]) }, false);

                    var label = document.createElement("label");
                    label.innerText = ontag[0]

                    var img = document.createElement("img");
                    img.id = "imgemo"+ ontag[1];
                    img.src="../Images/tagclose.png";
                    a.appendChild(img);
                    a.appendChild(label);
                    span1.appendChild(a);
                    span.appendChild(span1);

                    document.getElementById("tagdiv").appendChild(span);

                }
            }
        }

        function AddTag(ctrlname, ctrlvalue) {
            
            if (ctrlname.length > 2) {
            
                var hdntags = (document.getElementById("hdntag").value).split('|');

                if (hdntags.length > 30) {
                    alert("Cannot associate more than 30 tags!!!");
                    return false;
                }

                for (i = 1; i < hdntags.length; i++) {
                    var onetag = hdntags[i].split(',');

                    if (onetag[0].toLowerCase() == ctrlname.toLowerCase()) {
                        alert("Already Exist!!!");
                        return false;
                    }
                }
                if (checkDuplicate(ctrlname)) {
                    alert("Duplicate Tags !!!");
                    return false;
                }

                document.getElementById("hdntag").value += '|' + ctrlname + ',' + ctrlvalue + ',' + '0,new';
                MakeEditableTagHtml()
            }
            else
                alert('Tag Too Small');
        }

        function checkDuplicate(str) {
                var hdnvalue = (document.getElementById("hdntag").value).split('|');
                for (j = 0; j < hdnvalue.length; j++) {
                    if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
                        return true;
                    }
                }
            return false;
        }

        function voteTag(id, vote) {
            if (checkCookie()) {
                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: "../Checked.aspx/voteTag",
                        data: "{'websitename': 'work4saletumblr','premalink': 'http://localhost:15064/HTMLPage4.htm','TagId':'" + id + "','vote':'" + vote + "','UserID':'" + getCookie("Tagged").split('=')[1] + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (msg) {
                            if (msg.d != null) {
                                if (vote == "UpVote")
                                    document.getElementById("divtag" + id).innerText = parseInt(document.getElementById("divtag" + id).innerText) + 1;
                                else
                                    document.getElementById("divtag" + id).innerText = parseInt(document.getElementById("divtag" + id).innerText) - 1;
                            }
                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                });
            }
            else {
                window.open("../Authentication/PopUpLogin1.aspx", "", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=500px, height=500px, top=10, left=10');
            }
        }

        ////////////////////////////////////////////////////////////////////End Tag///////////////////////////////////////////////////////////////////////////

        function EditBookmarklet()
        {
            if (checkCookie())
            {
                var span = document.createElement("span");
                var div = document.createElement("div");

                var input = document.createElement("input");
                input.id = "inpttag";
                input.type = "text";
                input.style.width = "150px";
                
                $(input).autocomplete({

                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../Tag/TagPage.aspx/TagIntellisense",
                            dataType: "json",
                            async: true,
                            cache: false,
                            data: "{'PrefixText': '" + request.term + "','Premalink': 'http://localhost:15064/HTMLPage4.htm'}",
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
                        select: function (event, ui) 
                        {
                            console.log("begin");
                            AddTag(ui.item.name, ui.item.value);
                            console.log("end");
                         
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
                
                span.appendChild(input);
                div.appendChild(span);

                span = document.createElement("span");
                var button = document.createElement("input");
                button.id = "btnaddtag";
                button.type = "button";
                button.value = "Add";
                button.style.width = "50px";
                button.addEventListener("click", function (e) { AddTag(document.getElementById("inpttag").innerText,"0") }, false);

                span.appendChild(button);
                div.appendChild(span);


                $("#tagdiv").prepend(div);

                span = document.createElement("span");
                div = document.createElement("div");
                input = document.createElement("input");
                input.id = "inptemotion";
                input.type = "text";
                input.style.width = "150px";

                $(input).autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "Default.aspx/EmotionIntellisense",
                            dataType: "json",
                            data: "{'PrefixText': '" + request.term + "','Premalink': 'http://localhost:15064/HTMLPage4.htm'}",
                            success: function (data)
                            {
                                response($.map(data.d, function (item)
                                {
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

                span.appendChild(input);
                div.appendChild(span);

                span = document.createElement("span");
                button = document.createElement("input");
                button.id = "btnaddemotion";
                button.type = "button";
                button.value = "Add";
                button.style.width = "50px";
                button.addEventListener("click", function (e) { AddTag(document.getElementById("inpttag").innerText, "0") }, false);

                span.appendChild(button);
                div.appendChild(span);

                $("#emotiondiv").prepend(div);

                document.getElementById("divactions").innerHTML = "";

                var anchor = document.createElement("a");
                anchor.id = "lnkCancel";
                anchor.innerText = "Cancel";
                anchor.href = "javascript:Cancel()";
                document.getElementById("divactions").appendChild(anchor);

                anchor = document.createElement("a");
                anchor.id = "lnkSave";
                anchor.innerText = "Save";
                anchor.href = "javascript:Save()";
                document.getElementById("divactions").appendChild(anchor);

            }
            else
                alert("Not Login");
        }

        function Save(){
            alert('Save');
        }

        function Cancel() {

            
        }

        function Main()
        {
            
            var div = document.createElement("div");
            div.id = "divbookmarklet";
            div.style.backgroundColor = "green";
            div.style.padding = "0px 0px 0px 0px";
            div.style.margin = "0px 0px 0px 0px";
            div.style.width = "100%";
            div.style.height = "300px";

            var table = document.createElement("table");
            table.width = "100%";

            //Begin ROW 1
            var row = document.createElement("tr");
            var column = document.createElement("td");
            column.width = "5%";
            row.appendChild(column);
            column = document.createElement("td");
            column.width = "90%";
            row.appendChild(column);
            column = document.createElement("td");
            column.width = "5%";
            row.appendChild(column);
            table.appendChild(row);
            //End ROW 1

            //Begin ROW 2
            row = document.createElement("tr");
            column = document.createElement("td");
            var label = document.createElement("label");
            label.innerText = "Tag";
            column.appendChild(label);
            row.appendChild(column);

            column = document.createElement("td");
            row.appendChild(column);

            column = document.createElement("td");
            var acdiv = document.createElement("div");
            acdiv.id = "divactions";
            var anchor = document.createElement("a");
            anchor.id = "lnkEdit";
            anchor.innerText = "Edit";
            anchor.href = "javascript:EditBookmarklet()";
            acdiv.appendChild(anchor);
            column.appendChild(acdiv);
            row.appendChild(column);
            table.appendChild(row);
            //End Row 2

            //Begin Row 3
            row = document.createElement("tr");
            column = document.createElement("td");
            var hidden = document.createElement("input");
            hidden.type = "hidden"
            hidden.id = "hdntag";
            hidden.value = "";
            column.appendChild(hidden);
            row.appendChild(column);

            column = document.createElement("td");
            column.appendChild(Tag());
            row.appendChild(column);

            column = document.createElement("td");
            row.appendChild(column);
            table.appendChild(row);
            //End Row 3

            //Begin Row 4
            row = document.createElement("tr");
            column = document.createElement("td");
            label = document.createElement("label");
            label.innerText = "Emotions";
            column.appendChild(label);
            row.appendChild(column);

            column = document.createElement("td");
            row.appendChild(column);

            column = document.createElement("td");
            row.appendChild(column);
            table.appendChild(row);
            //End Row 4

            //Begin Row 5
            row = document.createElement("tr");
            column = document.createElement("td");
            hidden = document.createElement("input");
            hidden.type = "hidden"
            hidden.id = "hdnemo";
            hidden.value = "";
            column.appendChild(hidden);
            row.appendChild(column);

            column = document.createElement("td");
            column.appendChild(GetEmotion());
            row.appendChild(column);

            column = document.createElement("td");
            row.appendChild(column);
            table.appendChild(row);
            //End Row 5

            div.appendChild(table);

            $("body").prepend(div);
        }

        function closebookmarklet() {
            $(document).ready(function () {
                $("#divbookmarklet").slideUp("1000");
            });
        }

        function checkCookie() {
            //var username = getCookie("Tagged");
            //if (username != null && username != "") {
            //    return true;
            //}
            //else {
            //    return false;
            //}
            return true;
        }

        function getCookie(c_name) {
            var i, x, y, ARRcookies = document.cookie.split(";");
            for (i = 0; i < ARRcookies.length; i++) {
                x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
                y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
                x = x.replace(/^\s+|\s+$/g, "");
                if (x == c_name) {
                    return unescape(y);
                }
            }
        }

        //function UnSelectedTab(ele) {
        //    var atr = document.createAttribute("aria-selected");
        //    atr.nodeValue = "false";

        //    $(ele).removeClass("ui-state-default ui-corner-top ui-tabs-active ui-state-active");
        //    $(ele).addClass("ui-state-default ui-corner-top");

        //    ele.attributes.setNamedItem(atr);
        //}

        //function SelectedTab(ele) {
        //    var atr = document.createAttribute("aria-selected");
        //    atr.nodeValue = "true";

        //    $(ele).removeClass("ui-state-default ui-corner-top");
        //    $(ele).addClass("ui-state-default ui-corner-top ui-tabs-active ui-state-active");
        //    ele.attributes.setNamedItem(atr);
        //}


        //function showtab(tab) {

        //    if (tab == "1") {
        //        $(document).ready(function () {

        //            $("#tabs-1").css("display", "block");
        //            $("#tabs-2").css("display", "none");
        //            $("#tabs-3").css("display", "none");

        //            $("li").each(function (index) {
        //                if (index == 0)
        //                    SelectedTab(this);
        //                else if (index == 1)
        //                    UnSelectedTab(this);
        //                else if (index == 2)
        //                    UnSelectedTab(this);
        //            });

        //        });

        //    }
        //    else if (tab == "2") {
        //        $(document).ready(function () {

        //            $("#tabs-1").css("display", "none");
        //            $("#tabs-2").css("display", "block");
        //            $("#tabs-3").css("display", "none");

        //            $("li").each(function (index) {
        //                if (index == 0)
        //                    UnSelectedTab(this);
        //                else if (index == 1)
        //                    SelectedTab(this);
        //                else if (index == 2)
        //                    UnSelectedTab(this);
        //            });
        //        });

        //    }
        //    else if (tab == "3") {
        //        $(document).ready(function () {

        //            $("#tabs-1").css("display", "none");
        //            $("#tabs-2").css("display", "none");
        //            $("#tabs-3").css("display", "block");

        //            $("li").each(function (index) {
        //                if (index == 0)
        //                    UnSelectedTab(this);
        //                else if (index == 1)
        //                    UnSelectedTab(this);
        //                else if (index == 2)
        //                    SelectedTab(this);
        //            });
        //        });
        //    }
        //}



        //function GetAllPages() {
        //    $(document).ready(function () {
        //        $.ajax
        //                      ({
        //                          type: "POST",
        //                          url: "Default.aspx/GetAllPages",
        //                          contentType: "application/json; charset=utf-8",
        //                          dataType: "json",
        //                          async: true,
        //                          cache: false,
        //                          success: function (msg) {

        //                              if (msg.d != null) {
        //                                  var dataArray = jQuery.parseJSON(msg.d);

        //                                  var selectbox = document.createElement("select");
        //                                  selectbox.id = "selectid";
        //                                  selectbox.style.width = "200px";
        //                                  selectbox.addEventListener("change", function (e) { createTabs(this.selectedIndex); }, false);

        //                                  var optn = document.createElement("OPTION");
        //                                  optn.text = "Select";
        //                                  optn.value = "-1";
        //                                  selectbox.options.add(optn);

        //                                  for (var i in dataArray.Pages.item) {
        //                                      optn = document.createElement("OPTION");
        //                                      optn.text = dataArray.Pages.item[i].type;
        //                                      optn.value = dataArray.Pages.item[i].id;
        //                                      selectbox.options.add(optn);
        //                                  }

        //                                  var div = document.createElement("div");
        //                                  div.id = "divbookmarklet";
        //                                  div.style.padding = "0px 0px 0px 0px";
        //                                  div.style.width = "100%";
        //                                  div.style.height = '300px';


        //                                  div.appendChild(selectbox);

        //                                  var divss = document.createElement("div");
        //                                  divss.id = "tabs";
        //                                  divss.className = "ui-tabs ui-widget ui-widget-content ui-corner-all";

        //                                  var ul = document.createElement("ul");
        //                                  var li = document.createElement("li");
        //                                  var a = document.createElement("a");
        //                                  ul.className = "ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all";
        //                                  ul.setAttribute("role", "tablist")

        //                                  a.href = "#tabs-1";
        //                                  a.innerText = "Tags";
        //                                  a.className = "ui-tabs-anchor";
        //                                  a.setAttribute("role", "presentation");
        //                                  a.tabIndex = -1;
        //                                  a.id = "ui-id-1";

        //                                  li.className = "ui-state-default ui-corner-top ui-tabs-active ui-state-active";
        //                                  li.tabIndex = 0;
        //                                  li.setAttribute("aria-controls", "tabs-1");
        //                                  li.setAttribute("aria-labelledby", "ui-id-1");
        //                                  li.setAttribute("aria-selected", "true");
        //                                  li.addEventListener("click", function (e) { showtab("1"); }, false);

        //                                  li.appendChild(a);
        //                                  ul.appendChild(li);

        //                                  li = document.createElement("li");
        //                                  a = document.createElement("a");
        //                                  a.href = "#tabs-2";
        //                                  a.innerText = "Emotions";
        //                                  a.tabIndex = -1;
        //                                  a.id = "ui-id-2";
        //                                  a.className = "ui-tabs-anchor";
        //                                  a.setAttribute("role", "presentation");

        //                                  li.className = "ui-state-default ui-corner-top";
        //                                  li.tabIndex = -1;
        //                                  li.setAttribute("aria-controls", "tabs-2");
        //                                  li.setAttribute("aria-labelledby", "ui-id-2");
        //                                  li.setAttribute("aria-selected", "false");
        //                                  li.setAttribute("role", "tab");
        //                                  li.addEventListener("click", function (e) { showtab("2"); }, false);

        //                                  li.appendChild(a);
        //                                  ul.appendChild(li);

        //                                  li = document.createElement("li");
        //                                  a = document.createElement("a");
        //                                  a.href = "#tabs-3";
        //                                  a.innerText = "Meta";
        //                                  a.tabIndex = -1;
        //                                  a.id = "ui-id-3";
        //                                  a.className = "ui-tabs-anchor";
        //                                  a.setAttribute("role", "presentation");

        //                                  li.className = "ui-state-default ui-corner-top";
        //                                  li.tabIndex = -1;
        //                                  li.setAttribute("aria-controls", "tabs-3");
        //                                  li.setAttribute("aria-labelledby", "ui-id-3");
        //                                  li.setAttribute("aria-selected", "false");
        //                                  li.setAttribute("role", "tab");
        //                                  li.addEventListener("click", function (e) { showtab("3"); }, false);

        //                                  li.appendChild(a);
        //                                  ul.appendChild(li);

        //                                  divss.appendChild(ul);

        //                                  var divs = document.createElement("div");
        //                                  divs.id = "tabs-1";
        //                                  divs.setAttribute("aria-labelledby", "ui-id-1");
        //                                  divs.setAttribute("class", "ui-tabs-panel ui-widget-content ui-corner-bottom");
        //                                  divs.setAttribute("role", "tabpanel");
        //                                  divs.setAttribute("aria-expanded", "true");
        //                                  divs.setAttribute("aria-hidden", "false");
        //                                  divs.style.display = "block";

        //                                  divs.innerHTML = "<p>Tags</p>";
        //                                  divss.appendChild(divs);
        //                                  divs = document.createElement("div");
        //                                  divs.id = "tabs-2";
        //                                  divs.className = "ui-tabs-panel ui-widget-content ui-corner-bottom";
        //                                  divs.setAttribute("aria-labelledby", "ui-id-2");
        //                                  divs.setAttribute("class", "ui-tabs-panel ui-widget-content ui-corner-bottom");
        //                                  divs.setAttribute("role", "tabpanel");
        //                                  divs.setAttribute("aria-expanded", "false");
        //                                  divs.setAttribute("aria-hidden", "tru");
        //                                  divs.style.display = "none";

        //                                  divs.innerHTML = "<p>Emotions</p>";
        //                                  divss.appendChild(divs);

        //                                  divs = document.createElement("div");
        //                                  divs.id = "tabs-3";
        //                                  divs.className = "ui-tabs-panel ui-widget-content ui-corner-bottom";
        //                                  divs.setAttribute("aria-labelledby", "ui-id-3");
        //                                  divs.setAttribute("class", "ui-tabs-panel ui-widget-content ui-corner-bottom");
        //                                  divs.setAttribute("role", "tabpanel");
        //                                  divs.setAttribute("aria-expanded", "false");
        //                                  divs.setAttribute("aria-hidden", "tru");
        //                                  divs.style.display = "none";

        //                                  divs.innerHTML = "<p>Meta</p>";
        //                                  divss.appendChild(divs);

        //                                  div.appendChild(divss);

        //                                  $("body").prepend(div);
        //                              }
        //                          },
        //                          error: function (request, status, error) {
        //                              alert(request.responseText);
        //                          }
        //                      })
        //    });
        //}
        //
        //function createTabs(selectedIndex) {
        //    alert(selectedIndex);
        //}


    </script>

</head>
<body>

    <%--
        <table>
            <tr>
                <td>
                    <a id="anchoredit" href="javascript:EditBookmarklet();" style="cursor: pointer;">Edit</a>
                    <a id="anchorclose" href="javascript:closebookmarklet();" style="cursor: pointer;">Close</a>
                </td>
            </tr>
        </table>
    --%>
</body>
</html>
