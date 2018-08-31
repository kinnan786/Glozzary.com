var url786 = "";
var site_name786 = "";
var RateabletagId = "";

window.onload = function() {
    createiframe786();
};

function getMetaContent(property) {
    console.log("get meta content = " + property);
    var metas = document.getElementsByTagName('meta');
    for (i = 0; i < metas.length; i++) {
        if (metas[i].getAttribute("property") == property) {
            return metas[i].getAttribute("content");
        }
    }
    return null;
}

if (Websitename_shortname == "")
    site_name786 = getMetaContent("og:site_name");
else
    site_name786 = Websitename_shortname;

if (RateabletagId != "")
    RateabletagId = RateabletagId;

if (getMetaContent("og:url") != null)
    url786 = getMetaContent("og:url");
else
    url786 = parent.window.location;

function createiframe786() {
    if (document.getElementById("tagiframe") == null) {
        var srcs786 = '//www.glozzary.com/Checked.aspx';
        if (site_name786 != null & site_name786 != "") {
            srcs786 += '?Websitename=' + site_name786.replace("'", "^");
            srcs786 += '?RateabletagId=' + RateabletagId;
            srcs786 += '&url=' + url786;
        } else
            return false;

        document.getElementById("taghead").innerHTML = "<iframe frameborder='0' id='tagiframe' src='" + srcs786 + "' scrolling='yes' style='width:100%; height:100px;' ></iframe>";
        document.getElementById("taghead").style.padding = "0px";
        document.getElementById("taghead").style.margin = "0px";
    }
}