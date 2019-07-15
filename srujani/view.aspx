<%@ Page Language="C#" MasterPageFile="~/Master/layout.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="view.aspx.cs" Inherits="view" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/view.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:Panel CssClass="pane" ID="Panel" runat="server">
            <div class="form">
                <div class="field">
                    <asp:DropDownList ID="finyr" runat="server" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="FinancialYears" DataTextField="finyr" DataValueField="finyr">
                        <asp:ListItem Value="">Choose a Financial Year</asp:ListItem>
                    </asp:DropDownList>
                    <div class="validator">
                    </div>
                    <asp:SqlDataSource ID="FinancialYears" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [finyr] FROM [suggestions]"></asp:SqlDataSource>
                </div>
                <div class="field">
                    <asp:DropDownList ID="emp_dept" runat="server" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="DepartmentCodes" DataTextField="dept_name" DataValueField="dept_dept_cd">
                        <asp:ListItem Value="">Choose a Department</asp:ListItem>
                    </asp:DropDownList>
                    <div class="validator">
                    </div>
                    <asp:SqlDataSource ID="DepartmentCodes" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [dept_dept_cd],[dept_name] FROM [dept]"></asp:SqlDataSource>
                </div>
                <div class="field">
                    <asp:DropDownList ID="sugg_level" runat="server" AutoPostBack="true">
                        <asp:ListItem Value="">Choose a Level</asp:ListItem>
                        <asp:ListItem Value="1">Departmental</asp:ListItem>
                        <asp:ListItem Value="2">Zonal</asp:ListItem>
                        <asp:ListItem Value="3">Apex</asp:ListItem>
                        <asp:ListItem Value="4">CEO</asp:ListItem>
                    </asp:DropDownList>
                    <div class="validator">
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="pane table">
            <asp:UpdatePanel ID="AsyncGrid" runat="server">

                <ContentTemplate>
                    <div class="field">
                    <asp:DropDownList ID="finyrdrop" runat="server" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="Fin" DataTextField="finyr" DataValueField="finyr">
                        <asp:ListItem Value="">Choose a Financial Year</asp:ListItem>
                    </asp:DropDownList>
                    <div class="validator">
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [finyr] FROM [suggestions]"></asp:SqlDataSource>
                </div>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="suggno" DataSourceID="SqlDataSource1" AllowPaging="True">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkSelect" runat="server"  onclick="CheckOne(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="suggno" HeaderText=" Suggestion No. " InsertVisible="False" ReadOnly="True" SortExpression="suggno" />
                            <asp:BoundField DataField="finyr" HeaderText="Year" SortExpression="finyr" />
                            <asp:TemplateField HeaderText="Employee" SortExpression="emp_plno" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"emp_plno") %>' Text='<%# GlobalFunctions.RenderEmpName(DataBinder.Eval(Container.DataItem,"emp_plno")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="emp_plno" HeaderText="Emp_PlNo" SortExpression="emp_plno" />
                            <asp:TemplateField HeaderText="Department" SortExpression="depcode">
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"emp_dept") %>' Text='<%# GlobalFunctions.RenderDepName(DataBinder.Eval(Container.DataItem,"emp_dept")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="sugg_topic" HeaderText="Subject" SortExpression="sugg_topic" />
                            <asp:TemplateField HeaderText="Level" SortExpression="level">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# GlobalFunctions.RenderLevel(DataBinder.Eval(Container.DataItem,"sugg_level")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Evaluator Name" SortExpression="eval_plno" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"eval_plno") %>' Text='<%# GlobalFunctions.RenderEvalName(DataBinder.Eval(Container.DataItem,"eval_plno")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Eval Status" SortExpression="eval_status">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# GlobalFunctions.EvalStatus(DataBinder.Eval(Container.DataItem,"eval_status")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Submitted By" SortExpression="sugg_submitted_by" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"sugg_submitted_by") %>' Text='<%# GlobalFunctions.RenderEmpName(DataBinder.Eval(Container.DataItem,"sugg_submitted_by")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                        <EmptyDataTemplate>
                            <br />
                            NO RECORDS FOUND WITH GIVEN CONSTRAINTS 
                            <br />
                        </EmptyDataTemplate>
                    </asp:GridView>

                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <div class="actions">
            <asp:Button ID="Print" runat="server" Text="Print" ValidationGroup="1" OnClick="PrintThisPage"/>
                </div>
        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" CancelSelectOnNullParameter="false" SelectCommand="SELECT * FROM [suggestions] WHERE ((([finyr]=@finyr) OR (@finyr IS NULL)) AND (([emp_dept]=@emp_dept) OR (@emp_dept IS NULL)) AND (([sugg_level]=@sugg_level) OR (@sugg_level IS NULL)))">
        <SelectParameters>
            <asp:ControlParameter ControlID="finyrdrop" Name ="finyrdrop" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="finyr" Name="finyr" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="emp_dept" Name="emp_dept" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="sugg_level" Name="sugg_level" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        function CheckOne(obj) {
            var grid = obj.parentNode.parentNode.parentNode;
            var inputs = grid.getElementsByTagName("input");
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "checkbox") {
                    if (obj.checked && inputs[i] != obj && inputs[i].checked) {
                        inputs[i].checked = false;
                    }
                }
            }
        }
    </script>
</asp:Content>

