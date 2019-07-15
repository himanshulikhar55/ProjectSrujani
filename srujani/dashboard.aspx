    <%@ Page Title="" Language="C#" MasterPageFile="~/Master/layout.master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="_Default" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <title>Dashboard</title>
    <link rel="stylesheet" href="../css/dashboard.css" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <div class="pane">
            <h1>Select an action</h1>
            <asp:HyperLink ID ="newsur" runat="server" CssClass="button" NavigateUrl="create.aspx" Text="Enter New Srujani"></asp:HyperLink>
            <asp:HyperLink ID="View" runat="server" CssClass="button" NavigateUrl="view.aspx" Text="View all your Srujanis"></asp:HyperLink>
            <asp:HyperLink ID="Elevator" runat="server" CssClass="button" NavigateUrl="dashboard/elevated.aspx" Text="View Evaluator Dashboard"></asp:HyperLink>
            <asp:HyperLink ID="AssignEval" runat="server" CssClass="button" NavigateUrl="EvalRoleAssignment.aspx" Text="Assign Srujani a Evaluator"></asp:HyperLink>
            <asp:HyperLink ID="EvalRoleAssignment" runat="server" CssClass="button" NavigateUrl="AssignEval.aspx" Text="Assign Employee as Evaluator"></asp:HyperLink>
            <asp:HyperLink ID="Process" runat="server" CssClass="button" NavigateUrl="coord_eval_data.aspx" Text="Enter Evaluation Details"></asp:HyperLink>
            <asp:HyperLink runat="server" CssClass="button" ID="HyperLink1" NavigateUrl="/view.aspx" Text="View Your Department's Srujanis"></asp:HyperLink>
            <asp:HyperLink runat="server" CssClass="button" ID="HyperLink2" NavigateUrl="/ied_dash.aspx" Text="Evaluate Srujani"></asp:HyperLink>
            <asp:HyperLink runat="server" CssClass="button" ID="HyperLink3" NavigateUrl="/ied_dash2.aspx" Text="View all Srujani"></asp:HyperLink>
        </div>
    </div>
</asp:Content>
