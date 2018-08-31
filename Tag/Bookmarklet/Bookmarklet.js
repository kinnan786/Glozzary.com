CreateBookmarklet();

function CreateBookmarklet() {
    if (document.getElementById("divbookmarklet") == null) {
        var div = document.createElement("div");
        div.id = "divbookmarklet";
        div.style.backgroundColor = "white";
        div.style.opacity = "opacity:0.8";
        div.style.boxShadow = "0px 0px 10px #666";
        div.style.padding = "0px 0px 0px 0px";
        div.style.margin = "0px 0px 0px 0px";
        div.style.width = "100%";
        div.style.height = "50px";
        div.style.position = "fixed";
        div.style.zIndex = "9999999";

        var divtag = document.createElement("div");
        divtag.style.width = "100%";
        divtag.style.height = "40px";
        divtag.style.paddingTop = "15px";
        divtag.style.textAlign = "center";

        var btntag = document.createElement("a");
        btntag.id = "btntag";
        btntag.href = "javascript:OpenTag()";
        btntag.style.textAlign = "center";
        btntag.style.padding = "10px";
        btntag.style.border = "1px solid #608925";
        btntag.style.fontWeight = "bold";
        btntag.style.borderRadius = "5px";
        btntag.style.color = "#FFF";
        btntag.style.textDecoration = "none";
        btntag.style.opacity = ".85";
        btntag.style.zIndex = "-1";
        btntag.style.width = "110px";
        btntag.style.backgroundColor = "#8db832";
        btntag.style.marginRight = "10px";
        btntag.innerHTML = "&nbsp;&nbsp;<img src='http://www.glozzary.com/images/Glyphishpro/Glyphish Pro/mini-icons/19-tag.png'>&nbsp;&nbsp;TAG ";
        divtag.appendChild(btntag);

        var btnemotion = document.createElement("a");
        btnemotion.id = "btnemotion";
        btnemotion.href = "javascript:OpenEmotion()";
        btnemotion.innerText = "Emotion";
        btnemotion.style.textAlign = "center";
        btnemotion.style.padding = "10px";
        btnemotion.style.border = "1px solid #608925";
        btnemotion.style.fontWeight = "bold";
        btnemotion.style.borderRadius = "5px";
        btnemotion.style.color = "#FFF";
        btnemotion.style.backgroundColor = "#8db832";
        btnemotion.style.textDecoration = "none";
        btnemotion.style.opacity = ".85";
        btnemotion.style.zIndex = "-1";
        btnemotion.style.width = "110px";
        btnemotion.innerHTML = "&nbsp;&nbsp;<img src='http://www.glozzary.com/images/Glyphishpro/Glyphish Pro/mini-icons/08-heart.png'>&nbsp;Emotion ";

        divtag.appendChild(btnemotion);

        var divclose = document.createElement("div");
        divclose.style.width = "100%";
        divclose.style.height = "10px";
        divclose.style.textAlign = "right";

        var btnclose = document.createElement("img");
        btnclose.id = "btnclose";
        btnclose.style.paddingRight = "10px";
        btnclose.style.textDecoration = "none";
        btnclose.style.width = "10px";
        btnclose.style.cursor = "pointer";
        btnclose.addEventListener('click', function () {
            javascript: CloseBookmarklet();
        });
        //"javascript:CloseBookmarklet()";
        btnclose.tooltip = "Close Bookmarklet";
        btnclose.src = "http://www.glozzary.com/images/glyphiconsfree/glyphicons/png/glyphicons_207_remove_2.png";

        divclose.appendChild(btnclose);

        divtag.appendChild(divclose);
        div.appendChild(divtag);

        document.body.insertBefore(div, document.body.childNodes[0]);
    }
}

function getMetaContent() {
    var metas = document.getElementsByTagName('meta');

    if (metas == null)
        metas = document.getElementsByTagName('META');

    if (metas != null) {
        for (var i = 0; i < metas.length; i++) {
            if (metas[i].getAttribute("property") == "og:url") {
                return metas[i].getAttribute("content");
            } else if (metas[i].getAttribute("property") == "url")
                return metas[i].getAttribute("content");
        }
    }
    return parent.window.location;
}

function CloseBookmarklet() {
    if (document.getElementById("divbookmarklet") != null) {
        document.body.removeChild(document.getElementById("divbookmarklet"));
    }
}

function OpenTag() {
    window.open("http://www.glozzary.com/TAG.aspx?flow=bookmarklet&Premalink=" + getMetaContent(), "_blank", "toolbar=no, scrollbars=no, resizable=no,titlebar=no, top=100, left=400, width=600, height=400");
}

function OpenEmotion() {
    window.open("http://www.glozzary.com/Emotion.aspx?flow=bookmarklet&Premalink=" + getMetaContent(), "_blank", "toolbar=no, scrollbars=no, resizable=no,titlebar=no, top=100, left=400, width=600, height=400");
}