function StartTaggedTags() {
    $(document).ready(function () {
        $.ajax({
            type: "POST",
            url: "TAG.aspx/GetTagged",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
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
            data: "{Premalink : 'http://localhost/HTMLPage4.htm'}",
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
    for (j = 0; j < hdnvalue.length; j++) {
        if (hdnvalue[j].split(',')[0].toLowerCase() == str.toLowerCase()) {
            return true;
        }
    }
    return false;
}

function maketaghtmls() {
    var te = 0;
    var icell = 0;
    var irow = 0;

    var hdntags = (document.getElementById("hdntag").value).split('|');
    document.getElementById("divtag").innerHTML = "";
    document.getElementById("txtinputtag").value = "";

    if (hdntags.length > 1) {
        for (i = 1; i < hdntags.length; i++) {
            var ontag = hdntags[i].split(',');
            var len = parseInt(Math.floor((ontag[0].length) / 2));
            var first = second = "";
            var tagvote = 0;
            var row, col;

            for (x = 0 ; x < len; x++) {
                first += String(ontag[0][x]);
            }

            for (j = len ; j < ontag[0].length; j++) {
                second += String(ontag[0][j]);
            }

            var table = document.getElementById("divtag");

            if (icell == 0) {
                row = table.insertRow(irow);
                col = row.insertCell(icell);
                icell = icell + 1;
            }
            else if (icell == 10) {
                irow = irow + 1;
                row = table.insertRow(irow);
                icell = 0;
                col = row.insertCell(icell);
                icell = icell + 1;
            }
            else {
                row = table.rows[irow];
                col = row.insertCell(icell);
                icell = icell + 1;
            }

            if (ontag[3] == 1)
                col.innerHTML = "<span class='PinItCount' style='display: block;'><span Id='div" + ontag[1] + "' class='CountBubble'>0</span></span><span class='checkoutbutton'><img id='img'" + ontag[1] + " onclick='DeleteTag(&quot;" + ontag[1] + "&quot;,&quot;" + ontag[0] + "&quot;)' src= 'http://www.glozzary.com/Images/tagclose.png'/><a>&nbsp;&nbsp;&nbsp;" + first + second + "&nbsp;&nbsp;&nbsp;</a></span></td>";
            else
                col.innerHTML = "<span class='PinItCount' style='display: block;'><span Id='div" + ontag[1] + "'  class='CountBubble'>" + ontag[2] + "</span></span><span class='checkoutbutton'><a id='anchordown" + ontag[1] + "' title='Down Vote' class='downVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;DownVote&quot;)'>&nbsp;&nbsp;&nbsp;" + first + "</a><a id='anchorup" + ontag[1] + "' title='Up Vote' class='upVote' onclick='voteTag(&quot;" + ontag[1] + "&quot;,&quot;UpVote&quot;)'>" + second + "&nbsp;&nbsp;&nbsp;</a></span></td>";

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