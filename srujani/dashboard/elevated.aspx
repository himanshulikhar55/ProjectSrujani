<%@ Page Title="Elevated Actions" Language="C#" MasterPageFile="~/Master/layout.master" AutoEventWireup="true" CodeFile="elevated.aspx.cs" Inherits="dashboard_elevated" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="/css/dashboard.css" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <div class="pane">
            <h1>Select an action</h1>
            <asp:HyperLink runat="server" CssClass="button" NavigateUrl="/update.aspx" Text="Update A Srujani"></asp:HyperLink>
            <asp:HyperLink runat="server" CssClass="button" ID="View" NavigateUrl="/view.aspx" Text="View Department wise Srujanis"></asp:HyperLink>
        </div>
    </div>
</asp:Content>

