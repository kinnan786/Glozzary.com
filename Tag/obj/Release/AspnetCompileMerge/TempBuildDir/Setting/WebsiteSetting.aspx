<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ThreeLayerLayout.Master" AutoEventWireup="true" CodeBehind="WebsiteSetting.aspx.cs" Inherits="Tag.Setting.WebsiteSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="padding: 0px; background-color: white; width: 100%; -webkit-border-radius: 15px; border-collapse: collapse;">
        <tr>
            <td colspan="2" style="text-align: center; font-weight: bold; font-size: 18px; width: 100%;"><br />Website/ Blog
           <hr />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%; padding: 0px;">
                    <tr>
                        <td colspan="3" style="padding: 10px 10px 10px 10px">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">STEP 1</h3>
                                </div>
                                <div class="panel-body">
                                    <p>Basic Information of your Website/Blog. All the Fields are Mandatory</p>
                                    <ol>
                                        <li>
                                            <p><strong>ShortName : </strong>must be Unique it is used to identify your Website/Blog</p>
                                        </li>
                                        <li>
                                            <p><strong>Webiste/Blog Url : </strong>is the URL of you Website/Blog</p>
                                        </li>
                                        <li>
                                            <p><strong>Type : </strong>Defines The type of Website/Blog it is.</p>
                                        </li>
                                    </ol>
                                    <asp:Image ID="imgweblogo" runat="server" ImageUrl="../Images/no-img-available-icons.jpg" Style="width: 150px; height: 100px;" />
                                    <asp:FileUpload ID="ImgUpload" runat="server" Style="display: inline; " /><br />
                                    <asp:Label ID="lbluplderrmsg" runat="server" ForeColor="Red"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control textbox" placeholder="Short Name" Style="width: 400px;" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                        ErrorMessage="WebsiteName Required" ForeColor="Red" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                    <br/><br/>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control textbox" placeholder="Website / Blog Url" Style="width: 400px;" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Website Url Required" ForeColor="Red" SetFocusOnError="True" ValidationGroup="A">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2"
                                        ErrorMessage="Url Not in correct format" ForeColor="Red" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"
                                        ValidationGroup="A">*</asp:RegularExpressionValidator>
                                    <span class="help-block"><strong>Correct Format:</strong> http://www.google.com</span>
                                    <br/>
                                    <p><strong>Type</strong></p>
                                    <asp:DropDownList ID="dplstwebsitetype" CssClass="textbox" runat="server" Width="370px" OnSelectedIndexChanged="dplstwebsitetype_SelectedIndexChanged" AutoPostBack="True" DataValueField="WebsiteID" DataTextField="WebsiteName">
                                    </asp:DropDownList>
                                    &nbsp;
                             <asp:CompareValidator ID="RequiredFieldValidator10" runat="server" ValueToCompare="0" ControlToValidate="dplstwebsitetype"
                                 ErrorMessage="*" ForeColor="Red" ValidationGroup="A" Operator="NotEqual"></asp:CompareValidator>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td colspan="2" style="text-align: center; font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-weight: bold; font-size: 18px; width: 100%; padding: 20px;">Services
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding: 10px 10px 10px 10px">

                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">STEP 2</h3>
                                </div>
                                <div class="panel-body">
                                    <p>Kindly Select the services that you want to have on your Website or blog. Select atleast one services</p>
                                    <br />
                                    <p>
                                        <asp:CheckBox ID="chktag" runat="server" Text="  Tags" Font-Bold="true" />
                                    </p>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkrateable" runat="server" style="display: inline-block;" /><label id="lbltagrate" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Rate Tags in my Website/Blog</strong></p>
                                    </label>
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkaddable" runat="server" style="display: inline-block;" /><label id="lbltagadd" runat="server" style="display: inline-block;"><p><strong>&nbsp;Allow User to Add New Tags in my Website/Blog</strong></p>
                                    </label>
                                    <br /><br/>
                                    <asp:CheckBox ID="chkemotion" runat="server" Text=" Emotions" Font-Bold="true" />
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkemoaddable" runat="server" style="display: inline-block;" /><label id="lblemoadd" style="display: inline-block;" runat="server"><p><strong>&nbsp;Allow User to Add New Emotions in my Website/Blog</strong></p>
                                    </label>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td colspan="2" style="text-align: center; font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-weight: bold; font-size: 18px; width: 100%; padding: 20px;">Meta-Character
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding: 10px 10px 10px 10px">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">STEP 3</h3>
                                </div>
                                <div class="panel-body">
                                    <p>Add these Meta-Character in your website or blog for archiving task. These Meta-Character ar very important and allow user to serch for a particular Link in your website and blogs</p>
                                    <br/>
                                    <p><strong>Recommended</strong></p>
                                    <textarea id="txtrecommended" runat="server" enableviewstate="true" style="width: 100%; height: 150px;" class="textbox" disabled="disabled"></textarea><br/><br/>
                                    <p><strong>Optional</strong></p>
                                    <textarea id="txtoptional" enableviewstate="true" runat="server" style="width: 100%; height: 150px;" class="textbox" disabled="disabled"></textarea>
                                    <asp:Label ID="LblRegisterWebsite" Visible="False" runat="server" ForeColor="Red"></asp:Label>
                                    <br /><br/>
                                    <div style="text-align: center;">
                                    <asp:Button ID="BtnRegister" runat="server" OnClick="Button1_Click" Visible="false"
                                        CssClass="simplebutton" Text="Register" ValidationGroup="A" />
                                    <asp:Button ID="BtnDone" runat="server" OnClick="Button1_Click1" Visible="false"
                                        CssClass="simplebutton" Text="Save" ValidationGroup="A" />
                                </div>
                                    </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center; font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-weight: bold; font-size: 18px; width: 100%; padding: 20px;">Code
                <hr />
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding: 10px 10px 10px 10px">
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h3 class="panel-title">STEP 4</h3>
                    </div>
                    <div class="panel-body">
                        Copy Paste this Code to your Website/Blog donot modify this code as the services will not work on your Website/Blog<br/><br/>
                        <textarea id="txtcode" runat="server" style="width: 100%; height: 150px;" class="textbox" disabled="disabled"></textarea>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold; font-size: 18px; width: 100%; padding: 20px;">Search
            <hr />
            </td>
        </tr>
        <tr>
            <td>
                <table style="border-collapse: collapse; width: 100%; padding: 0px;">
                    <tr>
                        <td style="width: 5%;"></td>
                        <td style="font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-size: 12px; text-align: center;">Search for the link in your website and blog and find out how many tags are attached to it to customize them.<br/><br/>
                            <asp:TextBox ID="TxtSearch" runat="server" CssClass="form-control textbox" placeholder="Search / Add Tag" Style="width: 350px;" />
                            <asp:Button ID="BtnSearch" runat="server" Text="Search" OnClick="BtnSearch_Click" CssClass="simplebutton" />
                        </td>
                        <td></td>
                        <td style="width: 5%;"></td>
                    </tr>
                    <tr>
                        <td style="width: 10%;"></td>
                        <td style="width: 80%;" colspan="2">
                            <br/><br/>
                            <asp:GridView ID="GridPremalink" runat="server" CellPadding="0" ForeColor="#333333" Style="font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-size: 12px;"
                                BorderStyle="None" AllowPaging="true" BorderWidth="0px" Width="100%" AutoGenerateColumns="False">
                                <EmptyDataTemplate>
                                    No Links
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField HeaderText="Permalink">
                                        <ItemTemplate>
                                            <a id="LnkPremaLInk" href='<%# Eval("PremalinkID","../PremaLink/PremaLink.aspx?PremalinkID={0}") %>'>
                                                <%# Eval("Link")%>
                                            </a>
                                        </ItemTemplate>
                                        <ItemStyle Width="90%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tags">
                                        <ItemTemplate>
                                            <asp:Label ID="LblTagCount" runat="server" Text='<%# Eval("TagCount")%>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <HeaderStyle BackColor="#4c8f3d" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            </asp:GridView>
                        </td>
                        <td style="width: 10%;"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center; font-family: Helvetica, Arial, 'lucida grande',tahoma,verdana,arial,sans-serif; color: #141823; font-weight: bold; font-size: 18px; width: 100%; padding: 20px;">
                <hr />
                END
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function ClosePopup() {
            parent.document.getElementById("btnClose").onclick();
        }
    </script>
</asp:Content>