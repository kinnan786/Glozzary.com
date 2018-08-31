function clickfunction(Maskid) {
    document.getElementById(Maskid).style.opacity = 0;
}

function blurfunction(Maskid, inputid) {
    if (document.getElementById(inputid).value == "")
        document.getElementById(Maskid).style.opacity = 1;
}

function ClosePopup(prevurl) {
    if (prevurl == '')
        prevurl = '../Default.aspx';

    parent.window.location = prevurl;
    this.window.close();
}

function checkTabPress(e) {
    if (e.keyCode == 9) {
        var ele = document.activeElement;
        if (ele.type == 'text' || ele.type == 'password') {
            document.getElementById(ele.id + 'span').style.opacity = 0;
        }
    }
}

document.addEventListener('keyup', function (e) {
    checkTabPress(e);
}, false);

function checkCookie() {
    if (document.cookie.split('=')[2] != null) {
        return true;
    }
    else {
        return false;
    }
}