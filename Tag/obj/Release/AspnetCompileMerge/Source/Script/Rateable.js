var url = "";
var websitename = "";
var rateabletagId = "";

window.onload = function() {
    createEmotion();
};

if (Websitename_shortname != "")
    websitename = Websitename_shortname;

if (RateabletagId != "")
    rateabletagId = RateabletagId;

url = 'http://work4sale.tumblr.com/post/87523490471';


function createEmotion() {
    if (document.getElementById("emotioniframe") == null) {
        var srcs786 = 'http://localhost/RateableTag.aspx';
        if (websitename != null && websitename != "" && rateabletagId != null && rateabletagId != "") {
            srcs786 += '?Websitename=' + websitename;
            srcs786 += '&RateabletagId=' + rateabletagId;
            srcs786 += '&url=' + url;
        } else
            return false;

        document.getElementById("rateablehead").innerHTML = "<iframe frameborder='0' id='emotioniframe' src='" + srcs786 + "' scrolling='yes' style='width:100%; height:100px;' ></iframe>";
        document.getElementById("rateablehead").style.padding = "0px";
        document.getElementById("rateablehead").style.margin = "0px";
    }
}