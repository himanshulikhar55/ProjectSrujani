<%@ Page Title="Update a Srujani" Language="C#" MasterPageFile="~/Master/layout.master" AutoEventWireup="true" CodeFile="update.aspx.cs" Inherits="update" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/update.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <div class="pane">
            <div class="form">
                <div class="field">
                    <label>Srujani ID</label>
                    <asp:TextBox ID="SrujaniID" placeholder="Enter Srujani No." runat="server" Text='<%# Bind("suggno") %>'/>
                    <div class="validator">
                        <asp:RequiredFieldValidator ID="SrujaniNoRequired" runat="server" ErrorMessage="Fill in the Srujani no" ControlToValidate="SrujaniID" ValidationGroup="1"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="SrujaniPattern" runat="server" ErrorMessage="Invalid Srujani no" ControlToValidate="SrujaniID" ValidationGroup="1" ValidationExpression="([0-9]+)"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="field">
                    <label>Financial Year</label>
                    <asp:DropDownList ID="FinancialYear" runat="server" AppendDataBoundItems="True" DataSourceID="FinancialYears" DataTextField="finyr" DataValueField="finyr">
                        <asp:ListItem Value="Choose a Financial Year"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="FinancialYears" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [finyr] FROM [suggestions]"></asp:SqlDataSource>
                    <div class="validator">
                        <asp:RequiredFieldValidator ID="finyr" InitialValue="Choose a Financial Year" runat="server" ErrorMessage="Choose a Financial Year" ControlToValidate="FinancialYear" ValidationGroup="1"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <asp:Button ID="LoadSrujani" runat="server" OnClick="SrujaniLoader" CausesValidation="true" ValidationGroup="1" Text="Go" />
            </div>
        </div>
        <div class="pane formview">
            <asp:UpdatePanel ID="AsyncForm" UpdateMode="Conditional" ChildrenAsTriggers="false" runat="server">
                <ContentTemplate>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="suggno" DataSourceID="Autofill" DefaultMode="Edit" OnItemUpdated="OnUpdated">
                        <EmptyDataTemplate>
                            <div class="empty">
                                      Select a Srujani No. and the Financial year
                            </div>
                        </EmptyDataTemplate>
                        <EditItemTemplate>
                            <div class="field">
                                <label>Employee no.</label>
                                <asp:TextBox ID="EmployeeNo" runat="server" Enabled="False" Text='<%# Bind("emp_plno") %>' />
                            </div>    
                            <div class="field">
                                <label>Department</label>
                                <asp:TextBox ID="DepartmentCode" runat="server" Enabled="False" Text='<%# GlobalFunctions.RenderDepName(DataBinder.Eval(Container.DataItem,"emp_dept")) %>' />
                            </div>
                            <div class="field stretch">
                                <label>Subject</label>
                                <asp:TextBox TextMode="MultiLine" Rows="5" ID="sru_subjectTextBox" runat="server" Enabled="False" Text='<%# Bind("sugg_topic") %>' />
                            </div>
                            <div class="field">
                                <label>Award Amount</label>
                                <asp:TextBox ID="AwardAmount" runat="server" Text='<%# Bind("sugg_award_amt") %>'></asp:TextBox>
                            </div>
                            <div class="field">
                                <label>Evaluator Remarks</label>
                                <asp:DropDownList ID="EvaluatorRemarks" runat="server" SelectedValue='<%# Bind("eval_status") %>'>
                                    <asp:ListItem Value="0">Not Evaluated</asp:ListItem>
                                    <asp:ListItem Value="21">E1 - Adoptable</asp:ListItem>
                                    <asp:ListItem Value="22">E2 - Not New Idea</asp:ListItem>
                                    <asp:ListItem Value="23">E3 - New, Expensive</asp:ListItem>
                                    <asp:ListItem Value="24">E4 - Not A Srujani</asp:ListItem>
                                    <asp:ListItem Value="25">I5 - Reward Recom</asp:ListItem>
                                    <asp:ListItem Value="26">I6 - Imp in Progress</asp:ListItem>
                                    <asp:ListItem Value="27">I7 - Imp &amp; Effective</asp:ListItem>
                                    <asp:ListItem Value="28">I8 - No Desired Benefit</asp:ListItem>
                                    <asp:ListItem Value="29">I9 - Can&#39;t be Implemented</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="field">
                                <label>Committee Remarks</label>
                                <asp:DropDownList ID="CommitteeRemarks" AutoPostBack="true" runat="server" SelectedValue='<%# Bind("sugg_award") %>'>
                                    <asp:ListItem Value="0">Not Evaluated</asp:ListItem>
                                    <asp:ListItem Value="41">C - Cash</asp:ListItem>
                                    <asp:ListItem Value="42">CCN - Cash + Cash Now</asp:ListItem>
                                    <asp:ListItem Value="43">TCL - CFL+Closed</asp:ListItem>
                                    <asp:ListItem Value="44">RE - Ref to Eval</asp:ListItem>
                                    <asp:ListItem Value="45">NA - Not Accepted</asp:ListItem>
                                    <asp:ListItem Value="46">T - CFL</asp:ListItem>
                                    <asp:ListItem Value="47">TC - CFL + Cash</asp:ListItem>
                                    <asp:ListItem Value="48">TCN - CFL +Cash Now</asp:ListItem>
                                    <asp:ListItem Value="49">TSC - CFL + Shirt + Cash</asp:ListItem>
                                    <asp:ListItem Value="50">O - Other</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="field checkbox">
                                <label>Level</label>
                                <asp:DropDownList OnLoad="SetLevelAccess" ID="Level" runat="server" SelectedValue='<%# Bind("sugg_level") %>' >
                                    <asp:ListItem Value="0">Departmental</asp:ListItem>
                                    <asp:ListItem Value="1">Zonal</asp:ListItem>
                                    <asp:ListItem Value="2">Apex</asp:ListItem>
                                    <asp:ListItem Value="3">CEO</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:LinkButton CssClass="button" ID="UpdateButton" runat="server" CausesValidation="False" CommandName="Update" Text="Update"/>
                        </EditItemTemplate>
                    </asp:FormView>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="LoadSrujani" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    <asp:SqlDataSource ID="Autofill" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" UpdateCommand="UPDATE [suggestions] SET [last_updated]=(getdate()), [eval_status] = @eval_status, [sugg_award] = @sugg_award, [sugg_award_amt] = @sugg_award_amt, [eval_status] = @eval_status, [sugg_level] = @sugg_level WHERE [suggno] = @suggno" CancelSelectOnNullParameter="true">
            <SelectParameters>
                <asp:ControlParameter ControlID="finyr" Name="finyr" PropertyName="Text" Type="Decimal" />
                <asp:ControlParameter ControlID="SrujaniID" Name="suggno" PropertyName="Text" Type="Decimal" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="eval_status" Type="Decimal" />
                <asp:Parameter Name="sugg_award_amt" Type="Decimal" />
                <asp:Parameter Name="sugg_award" Type="Decimal" />
                <asp:Parameter Name="eval_status" Type="Decimal" />
                <asp:Parameter Name="sugg_level" Type="Int32" />
                <asp:Parameter Name="suggno" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
</asp:Content>

