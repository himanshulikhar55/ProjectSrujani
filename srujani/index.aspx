<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/layout.master" CodeFile="index.aspx.cs" Inherits="index" %>
<asp:Content ID="contentHead" ContentPlaceHolderID="head" runat="server">
    <title>Login</title>
    <link rel="stylesheet" href="../css/home.css" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" runat="server">
    <div class="wrapper">
        <div class="pane">
            <asp:UpdatePanel runat="server" ID="LoginPanel" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <span class="title">Login</span>
                    <span class="subtitle"></span>
                    <div class="form">
                        <div class="field">
                            <asp:Label AssociatedControlId="EmpNoToLogin" runat="server" Text="Employee No."/>
                            <asp:TextBox ID="EmpNoToLogin" MaxLength="6"  runat="server"></asp:TextBox>
                            <div class="validator">
                                <asp:RequiredFieldValidator ID="EmpNoRequiredToLogin" runat="server" ErrorMessage="Fill in your employee no" ControlToValidate="EmpNoToLogin" ValidationGroup="2"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="EmpNoToLogin" ErrorMessage="Enter Valid Employee Plno" MaximumValue="999999" MinimumValue="999" Type="Integer">
                                </asp:RangeValidator>
                             </div>
                        </div>
                        
                        <div class="field">
                            <asp:Label AssociatedControlId="PasswordToLogin" runat="server" Text="Password"/>
                            <asp:TextBox ID="PasswordToLogin" runat="server" TextMode="Password"></asp:TextBox>
                            <div class="validator">
                                <asp:RequiredFieldValidator ID="PasswordRequiredToLogin" runat="server" ErrorMessage="Fill in your password" ControlToValidate="PasswordToLogin" ValidationGroup="2"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div>
                            <asp:DropDownList ID="EmpType" runat="server" AppendDataBoundItems="True" DataTextField="finyr" DataValueField="emptype" SelectedValue='<%# Bind("emptype") %>'>
                            <asp:ListItem Value="0">Choose a type of login</asp:ListItem>
                            <asp:ListItem Value="1">Employee</asp:ListItem>
                            <asp:ListItem Value="2">Coordinator</asp:ListItem>
                            <asp:ListItem Value="3">Evaluator</asp:ListItem>
                            <asp:ListItem Value="4">IED Convenor</asp:ListItem>
                            </asp:DropDownList>
                            <div class ="validator">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select Login type" ControlToValidate="EmpType" ValidationGroup="2"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <br />
                        <asp:Button ID="Login" runat="server" Text="LOGIN" ValidationGroup="1" OnClick="login_action_handler"/>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Login" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

