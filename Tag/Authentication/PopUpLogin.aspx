<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PopUpLogin.aspx.cs" ClientIDMode="Static" Inherits="Tag.Authentication.PopUpLogin" %>
<html>
    <head>
        <title>Login In</title>
        <script src="../Script/StandardJavascript.js"></script>
        <link href="../Styles/StyleSheet2.css" rel="stylesheet" />
        <script src="../Script/jquery-1.11.0.js"></script>
        <link href="../Script/bootstrap3.2.0/bootstrap.min.css" rel="stylesheet" />
        <script src="../Script/bootstrap3.2.0/bootstrap.min.js"></script>
        <script type="text/javascript">
            //$('#myTab a').click(function(e) {
            //    e.preventDefault();
            //    $(this).tab('show');

            //});

        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div class="container">
                <div class="row">
                    <ul id="myTab" class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">User</a></li>
                        <li role="presentation" class=""><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">Website/Blog</a></li>
                    </ul>
                    <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
                            <br/>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="text-align: center; width: 100%;" colspan="2">
                                        <script type="text/javascript">

                                            //console.log("Session = " + "<%= Session.SessionID %>");
                                            // This is called with the results from from FB.getLoginStatus().
                                            function statusChangeCallback(response) {
                                                //  console.log('statusChangeCallback');
                                                //  console.log(response);
                                                // The response object is returned with a status field that lets the
                                                // app know the current login status of the person.
                                                // Full docs on the response object can be found in the documentation
                                                // for FB.getLoginStatus().
                                                if (response.status === 'connected') {
                                                    // Logged into your app and Facebook.
                                                    testAPI();
                                                } else if (response.status === 'not_authorized') {
                                                    // The person is logged into Facebook, but not your app.
                                                    // document.getElementById('status').innerHTML = 'Please log ' +
                                                    //   'into this app.';
                                                } else {
                                                    // The person is not logged into Facebook, so we're not sure if
                                                    // they are logged into this app or not.
                                                    // document.getElementById('status').innerHTML = 'Please log ' +
                                                    //   'into Facebook.';
                                                }
                                            }

                                            // This function is called when someone finishes with the Login
                                            // Button.  See the onlogin handler attached to it in the sample
                                            // code below.
                                            function checkLoginState() {
                                                FB.getLoginStatus(function(response) {
                                                    statusChangeCallback(response);
                                                });
                                            }

                                            window.fbAsyncInit = function() {
                                                FB.init({
                                                    appId: '336328663198319',
                                                    cookie: true, // enable cookies to allow the server to access// the session
                                                    xfbml: true, // parse social plugins on this page
                                                    version: 'v2.0', // use version 2.0
                                                    scope: "public_profile, email"
                                                });

                                                // Now that we've initialized the JavaScript SDK, we call
                                                // FB.getLoginStatus().  This function gets the state of the
                                                // person visiting this page and can return one of three states to
                                                // the callback you provide.  They can be:
                                                //
                                                // 1. Logged into your app ('connected')
                                                // 2. Logged into Facebook, but not your app ('not_authorized')
                                                // 3. Not logged into Facebook and can't tell if they are logged into
                                                //    your app or not.
                                                //
                                                // These three cases are handled in the callback function.

                                                //  FB.getLoginStatus(function (response) {
                                                //      statusChangeCallback(response);
                                                //  });

                                            };

                                            // Load the SDK asynchronously
                                            (function(d, s, id) {
                                                var js, fjs = d.getElementsByTagName(s)[0];
                                                if (d.getElementById(id)) return;
                                                js = d.createElement(s);
                                                js.id = id;
                                                js.src = "//connect.facebook.net/en_US/sdk.js";
                                                fjs.parentNode.insertBefore(js, fjs);
                                            }(document, 'script', 'facebook-jssdk'));

                                            // Here we run a very simple test of the Graph API after login is
                                            // successful.  See statusChangeCallback() for when this call is made.
                                            function testAPI() {
                                                //console.log('Welcome!  Fetching your information.... ');
                                                FB.api('/me', function(response) {

                                                    $.ajax({
                                                        type: "POST",
                                                        url: "PopUpLogin.aspx/FaceBookAuthentication",
                                                        data: "{id:'" + response.id + "',email:'" + response.email + "',firstName:'" + response.first_name + "',lastName:'" + response.last_name + "'}",
                                                        contentType: "application/json; charset=utf-8",
                                                        dataType: "json",
                                                        async: true,
                                                        cache: false,
                                                        success: function(n) {

                                                            if (n.d == 1) {
                                                                alert("User Created Kindly Verify your Email: " + response.email);
                                                            } else if (n.d == -1) {
                                                                alert('Email Associated With Other User or Email Not Verified');
                                                            } else if (n.d == -3) {
                                                                alert('Email Not Verified');
                                                            } else if (n.d > 1) {
                                                                parent.window.location = "http://localhost/MainPage.aspx";
                                                            }
                                                        },
                                                        error: function(e) {
                                                            alert(e.responseText);
                                                        }
                                                    });

                                                });
                                            }
                                        </script>
                                        <fb:login-button scope="public_profile,email" onlogin="checkLoginState();" max_rows="1" size="xlarge" show_faces="false" auto_logout_link="false">
                                        </fb:login-button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="divclass" colspan="2">OR
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%;"></td>
                                    <td style="width: 80%;">
                                        <asp:TextBox ID="TxtLEmail" class="form-control textbox" placeholder="Em@il" runat="server" Width="400px" MaxLength="50" ValidationGroup="A"
                                                     CausesValidation="True"></asp:TextBox>
                                       
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="text-align: left;">
                                        <br />
                                        <asp:TextBox ID="TxtLPassword" class="form-control textbox" placeholder="Password" runat="server" Width="400px" MaxLength="50" TextMode="Password"
                                                     ValidationGroup="A" CausesValidation="True"></asp:TextBox>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <!-- ... your HTML <body> content ... -->
                                        <div id="recaptcha_div"></div>
                                        <script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>
                                        <!-- Wrapping the Recaptcha create method in a javascript function -->
                                        <script type="text/javascript">
                                            showRecaptcha('recaptcha_div');

                                            function showRecaptcha(element) {
                                                Recaptcha.create("6Lep5PkSAAAAAEjBi3NxLdBfj6lCkzXjz68odOJV", element, {
                                                    theme: "red"
                                                });
                                            }
                                        </script>
                                        <asp:RequiredFieldValidator ID="RequiredFieldLUserName" runat="server" ErrorMessage="Email Required" Text="*" ValidationGroup="A"
                                                                    ControlToValidate="TxtLEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldRUserName" runat="server" ErrorMessage="Email Required" Text="*" ValidationGroup="B"
                                                                    ControlToValidate="TxtLEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Email Not in correct format" runat="server" ForeColor="Red" Text="*" ValidationGroup="A" ControlToValidate="TxtLEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ErrorMessage="Email Not in correct format" runat="server" ForeColor="Red" Text="*" ValidationGroup="B" ControlToValidate="TxtLEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldLPassword" runat="server" Text="*" ValidationGroup="A" ErrorMessage="Password Required"
                                                                    ControlToValidate="TxtLPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Text="*" ValidationGroup="B" ErrorMessage="Password Required"
                                                                    ControlToValidate="TxtLPassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="Password must consists of at least 8 characters and not more than 15 characters." runat="server" ForeColor="Red" Text="*" ValidationGroup="A" ControlToValidate="TxtLPassword" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:RegularExpressionValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ErrorMessage="Password must consists of at least 8 characters and not more than 15 characters." runat="server" ForeColor="Red" Text="*" ValidationGroup="B" ControlToValidate="TxtLPassword" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:RegularExpressionValidator>
                                        <!-- ... more of your HTML  content ... -->
                                        <p class="bg-danger">
                                        <asp:Label ID="LblAutentication" EnableViewState="true" runat="server" Visible="False" Font-Bold="True"
                                                   ForeColor="Red"></asp:Label>
                                        <asp:ValidationSummary ID="ValidationSummary1" ForeColor="Red" runat="server" ValidationGroup="A" />
                                        <asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" runat="server" ValidationGroup="B" />
                                        <p>

                                        <asp:LinkButton ID="lnkforgetpass" runat="server" PostBackUrl="~/Authentication/ForgotPassword.aspx">Forgot Password</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                            <div style="border-top: 1px solid #e5e5e5; float: right; height: 16.43px; padding: 15px; text-align: right; vertical-align: bottom; width: 100%">
                                <asp:Button ID="BtnLogin" runat="server" Text="Login" CssClass="simplebutton"
                                            OnClick="BtnLogin_Click" ValidationGroup="A" />
                                &nbsp;&nbsp;
                                <asp:Button ID="BtnRegister" runat="server" ValidationGroup="B" Text="Register" CssClass="simplebutton" OnClick="BtnRegister_Click1" />
                            </div>  
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
                            <br/>
                            <table style="width: 100%;"> 
                                <tr>
                                    <td style="width: 20%;"></td>
                                    <td style="width: 80%;">
                                        <fieldset>
                                            <legend>
                                                Login Information
                                            </legend>
                                            <asp:TextBox ID="txtwebemail" class="form-control textbox" placeholder="Em@il" runat="server" Width="400px" MaxLength="50" ValidationGroup="C"
                                                         CausesValidation="True"></asp:TextBox>
                                            <br />
                                            <asp:TextBox ID="txtwebpassword" class="form-control textbox" placeholder="Password" runat="server" Width="400px" MaxLength="50" TextMode="Password"
                                                         ValidationGroup="C" CausesValidation="True"></asp:TextBox>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="text-align: left;">
                                        <br/>
                                        <fieldset>
                                            <legend>
                                                Register
                                            </legend>
                                            <asp:TextBox ID="txtwebsiteurl" class="form-control textbox" placeholder="Website URL" runat="server" Width="400px" MaxLength="50" 
                                                         ValidationGroup="C" CausesValidation="True"></asp:TextBox>
                                        
                              
                                            <br />
                                            <asp:TextBox ID="txtwebsitename" class="form-control textbox" placeholder="Website Name" runat="server" Width="400px" MaxLength="50" 
                                                         ValidationGroup="C" CausesValidation="True"></asp:TextBox>
                                        
                                        </fieldset>
                                        
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td></td>
                                    <td>
                                        <div id="recaptcha_webdiv"></div>
                                        <script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>
                                        <!-- Wrapping the Recaptcha create method in a javascript function -->
                                        <script type="text/javascript">
                                            showRecaptcha('recaptcha_webdiv');

                                            function showRecaptcha(element)
                                            {
                                                Recaptcha.create("6Lep5PkSAAAAAEjBi3NxLdBfj6lCkzXjz68odOJV", element, {
                                                    theme: "red"
                                                });
                                            }
                                        </script>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Email Required" Text="*" ValidationGroup="C" ControlToValidate="txtwebemail" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Email Required" Text="*" ValidationGroup="D" ControlToValidate="txtwebemail" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ErrorMessage="Email Not in correct format" runat="server" ForeColor="Red" Text="*" ValidationGroup="C" ControlToValidate="txtwebemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ErrorMessage="Email Not in correct format" runat="server" ForeColor="Red" Text="*" ValidationGroup="D" ControlToValidate="txtwebemail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Text="*" ValidationGroup="C" ErrorMessage="Password Required" ControlToValidate="txtwebpassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Text="*" ValidationGroup="D" ErrorMessage="Password Required" ControlToValidate="txtwebpassword" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ErrorMessage="Password must consists of at least 8 characters and not more than 15 characters." runat="server" ForeColor="Red" Text="*" ValidationGroup="C" ControlToValidate="txtwebpassword" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:RegularExpressionValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ErrorMessage="Password must consists of at least 8 characters and not more than 15 characters." runat="server" ForeColor="Red" Text="*" ValidationGroup="D" ControlToValidate="txtwebpassword" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Text="*" ValidationGroup="D" ErrorMessage="Website Name Required" ControlToValidate="txtwebsitename" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Text="*" ValidationGroup="D" ErrorMessage="WebsiteUrl Required" ControlToValidate="txtwebsiteurl" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ErrorMessage="Website Url Not in Correct Format" runat="server" ForeColor="Red" Text="*" ValidationGroup="D" ControlToValidate="txtwebsiteurl" ValidationExpression="^(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,6}(?:\/?|(?:\/[\w\-]+)*)(?:\/?|\/\w+\.[a-zA-Z]{2,4}(?:\?[\w]+\=[\w\-]+)?)?(?:\&[\w]+\=[\w\-]+)*)$"></asp:RegularExpressionValidator>
                                       
                                         <!-- ... more of your HTML  content ... -->
                                        <p class="bg-danger">
                                        <asp:Label ID="lblwebauthentication" EnableViewState="true" runat="server" Visible="False" Font-Bold="True"
                                                   ForeColor="Red"></asp:Label>
                                        <asp:ValidationSummary ID="ValidationSummary3" ForeColor="Red" runat="server" ValidationGroup="C" />
                                        <asp:ValidationSummary ID="ValidationSummary4" ForeColor="Red" runat="server" ValidationGroup="D" />
                                        <p>

                                    </td>
                                </tr>

                            </table>
                            <div style="border-top: 1px solid #e5e5e5; float: right; height: 16.43px; padding: 15px; text-align: right; vertical-align: bottom; width: 100%">
                                <asp:Button ID="btnweblogin" runat="server" Text="Login" CssClass="simplebutton"
                                            ValidationGroup="C" OnClick="btnweblogin_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID=btnwebregister runat="server" ValidationGroup="D" Text="Register" CssClass="simplebutton" OnClick="btnwebregister_Click" />
                            </div>  
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>