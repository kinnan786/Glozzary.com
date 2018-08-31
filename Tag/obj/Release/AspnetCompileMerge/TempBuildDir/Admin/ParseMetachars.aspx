<%@ Page Title="" Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="ParseMetachars.aspx.cs" Inherits="Tag.Admin.ParseMetachars" %>

<html>
    <head>
        <script src="../Script/jquery-ui-1.10.4/jquery-1.10.2.js"></script>
        <script type="text/javascript">
            function Parse() {
                $(document).ready(function() {
                    var links = new Array();
                    var imgs = document.getElementsByTagName("img");
                    var maxw = 0, h = 1, index = 0, s = 0;
                    var flag = 0;
                    var hdnid;
                    for (var i = 0; i < imgs.length; i++) {
                        var imid = imgs[i].name.substr(3, 1);

                        if (imid == index) {
                            if (imgs[i].width > maxw) {
                                maxw = imgs[i].width;
                                h = i;
                            }
                        } else if (imid != index) {
                            hdnid = imgs[h].name.split('_')[1];
                            if (document.getElementById(hdnid) != null) {
                                links[s] = "|premalink=" + document.getElementById(hdnid).value + ",imageurl=" + imgs[h].src;
                                index += 1;
                                maxw = 0;
                                s += 1;
                                flag = 1;
                            }
                        }
                    }

                    if (flag == 0) {
                        hdnid = imgs[h].name.split('_')[1];
                        if (document.getElementById(hdnid) != null) {
                            links[s] = "|" + document.getElementById(hdnid).value + "," + imgs[h].src;
                        }
                    }

                    var theIds = JSON.stringify(links);
                    console.log(theIds);

                    $.ajax({
                        type: "POST",
                        url: "ParseMetachars.aspx/done",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{values:'" + theIds + "'}",
                        async: false,
                        cache: false,
                        error: function(e, t, n) {
                            alert(e.responseText);
                        }
                    });
                });
            }
        </script>
        <title></title>
    </head>
    <body>
        <form runat="server" id="frm1">
            <div style="text-align: center">
                <asp:Button ID="btnstart" Width="180px" runat="server" Text="Start Parsing 50 Link" OnClick="btnstart_Click" />
            </div>
            <asp:Literal ID="ltrl" runat="server"></asp:Literal>
        </form>
    </body>
</html>