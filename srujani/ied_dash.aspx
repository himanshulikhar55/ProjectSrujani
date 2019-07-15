<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/layout.master" CodeFile="ied_dash.aspx.cs" Inherits="ieddash" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/StyleSheet.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:Panel CssClass="pane" ID="Panel" runat="server">
            <div class="form">
                
                <div class="field">
                    <asp:DropDownList ID="emp_dept" runat="server" AppendDataBoundItems="True" DataSourceID="DepartmentCodes" DataTextField="dept_dept_cd" DataValueField="dept_dept_cd" AutoPostBack="true">
                        <asp:ListItem Value="">Choose a Department</asp:ListItem>
                    </asp:DropDownList>
                    <div class="validator">
                    </div>
                    <asp:SqlDataSource ID="DepartmentCodes" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT [dept_dept_cd], [dept_name] FROM [dept]"></asp:SqlDataSource>
                </div>
                <div class="field">
                    <asp:DropDownList ID="FinancialYear" OnSelectedIndexChanged="selectcommand" runat="server" AppendDataBoundItems="True" DataSourceID="FinancialYears" DataTextField="finyr" DataValueField="finyr" AutoPostBack="true">
                        <asp:ListItem Value="">Choose a Financial Year</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="FinancialYears" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [finyr] FROM [suggestions] WHERE [eval_status] = 'E'"></asp:SqlDataSource>
                    <div class="validator">
                        <asp:RequiredFieldValidator ID="finyr" InitialValue="Choose a Financial Year" runat="server" ErrorMessage="Choose a Financial Year" ControlToValidate="FinancialYear" ValidationGroup="1"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="field">
                        <asp:DropDownList ID="SuggnoDropDown" AppendDataBoundItem="False" runat="server" DataTextField="SuggNo" DataValueField="SuggNo" DataSourceID="SqlDataSource1"  AutoPostBack="true">
                            <asp:ListItem Value="">Choose a Srujani Number</asp:ListItem>
                         </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="FinancialYear" Name="finyr1" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
                        </SelectParameters>
                        </asp:SqlDataSource>
                    <div class="validator">
                    </div>
                </div>
                <div class="field">
                        <asp:DropDownList ID="emplno" runat="server" AppendDataBoundItems="True"  DataTextField="emp_name" DataValueField="emp_plno" DataSourceID="SqlDataSource2"  AutoPostBack="true">
                            <asp:ListItem Value="">Choose Employee Name</asp:ListItem>
                         </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT [emp_plno],[emp_name] FROM [employee_master]">
                        </asp:SqlDataSource>
                    <div class="validator">
                    </div>
                </div>
            <!--<asp:Button ID="LoadView" runat="server" CausesValidation="true" ValidationGroup="1" Text="Go" />-->
            </div>
          </asp:Panel>
        <div class="pane table">
            <asp:UpdatePanel ID="AsyncGrid" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="suggno" DataSourceID="SqlDataSource3" AllowPaging="True">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkSelect" runat="server"  onclick="CheckOne(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="emp_plno" HeaderText="Emp_PlNo" SortExpression="emp_plno" />
                            <asp:TemplateField HeaderText="Employee" SortExpression="emp_plno" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"emp_plno") %>' Text='<%# GlobalFunctions.RenderEmpName(DataBinder.Eval(Container.DataItem,"emp_plno")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department" SortExpression="depcode">
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"emp_dept") %>' Text='<%# GlobalFunctions.RenderDepName(DataBinder.Eval(Container.DataItem,"emp_dept")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="suggno" HeaderText=" Suggestion No. " InsertVisible="False" ReadOnly="True" SortExpression="suggno" />
                            <asp:TemplateField HeaderText="Evaluator Name" SortExpression="eval_plno" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"eval_plno") %>' Text='<%# GlobalFunctions.RenderEvalName(DataBinder.Eval(Container.DataItem,"eval_plno")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="evaldecision" SortExpression="eval_decision" >
                                <ItemTemplate>
                                    <asp:Label runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem,"eval_decision") %>' Text='<%# GlobalFunctions.RenderEval(DataBinder.Eval(Container.DataItem,"eval_decision")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="eval_imp_cost" HeaderText="Imp Cost" SortExpression="eval_imp_cost" />
                            <asp:BoundField DataField="sugg_imp_mth" HeaderText="Imp Month" SortExpression="sugg_imp_mth" />
                            <asp:BoundField DataField="sugg_imp_days" HeaderText="Imp Days" SortExpression="sugg_imp_days" />
                            <asp:BoundField DataField="sugg_imp_type" HeaderText="Imp Type" SortExpression="sugg_imp_type" />
                            <asp:BoundField DataField="savings_onetime" HeaderText="OneTime Savings" SortExpression="savings_onetime" />
                            <asp:BoundField DataField="savings_recurring" HeaderText="Recurring Savings" SortExpression="savings_recurring" />
                            <asp:BoundField DataField="savings_intangible" HeaderText="Intangible Savings" SortExpression="savings_intangible" />
                            <asp:BoundField DataField="eval_comments" HeaderText="Evaluator's Comments" SortExpression="eval_comments" />
                        </Columns>
                        <EmptyDataTemplate>
                            <br />
                            NO RECORDS FOUND WITH GIVEN CONSTRAINTS 
                            <br />
                        </EmptyDataTemplate>
                    </asp:GridView>
                  <asp:Button ID="LoadSrujani" runat="server" OnClick="SrujaniLoader" Text="Select" AutoPostBack="true"/>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="pane formview">
            <asp:UpdatePanel ID="AsyncForm" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                <ContentTemplate>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="suggno" DefaultMode="Edit" DataSourceID="Autofill">
                        <EmptyDataTemplate>
                            <div class="empty">
                                      Please Select a Srujani
                            </div>
                        </EmptyDataTemplate>
                        <EditItemTemplate>
                            <span>
                                <label>Level</label>
                                <asp:DropDownList ID="Level" runat="server" SelectedValue='<%# Bind("sugg_level") %>' >                                 
                                    <asp:ListItem Value="1">Departmental</asp:ListItem>
                                    <asp:ListItem Value="2">Zonal</asp:ListItem>
                                    <asp:ListItem Value="3">Apex</asp:ListItem>
                                    <asp:ListItem Value="4">CEO Approval</asp:ListItem>
                                </asp:DropDownList>
                                
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            
                                <label>Suggestion Status</label>
                                <asp:DropDownList ID="Status" runat="server" SelectedValue='<%# Bind("sugg_type") %>'>
                                    <asp:ListItem Value="F">Fresh</asp:ListItem>
                                    <asp:ListItem Value="A">Alive</asp:ListItem>
                                    <asp:ListItem Value="D">Dormant</asp:ListItem>
                                    <asp:ListItem Value="C">Closed</asp:ListItem>
                                </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Award Type</label>
                                <asp:DropDownList ID="suggaward" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ReflectToAward" SelectedValue='<%# Bind("sugg_award") %>'>
                                    <asp:ListItem Value="">Select suggestion award</asp:ListItem>
                                    <asp:ListItem Value="TO">Token</asp:ListItem>
                                    <asp:ListItem Value="TD">Token & Closed</asp:ListItem>
                                    <asp:ListItem Value="TC">Token & Cash</asp:ListItem>
                                    <asp:ListItem Value="TN">Token Earlier Cash Now</asp:ListItem>
                                    <asp:ListItem Value="RH">Refer for Higher</asp:ListItem>
                                    <asp:ListItem Value="RO">Refer to Other Dept</asp:ListItem>
                                    <asp:ListItem Value="NA">Not Accepted</asp:ListItem>
                                </asp:DropDownList>
                                
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label>Award</label>
                                <asp:TextBox ID="Award" runat="server" Enabled="False"/>
                                    <div class="validator">
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Award" ErrorMessage="Enter 7 digit number " MaximumValue="9999999.99" MinimumValue="0.99" Type="Double">
                        </asp:RangeValidator></div>
                                </span>
                                <span style="bottom:15px"> 
                                    NOTE: Award Amount to be entered in Rs. is according to the following rule: 1)If Level is "Departmental" the maximum amount will be 300. 2) If level is "Zonal" maximum amount will be 2,000. 3) If level is "Apex" amount maximum mount will be 10,000. 4) If level is "CEO Approval" the amount will be anything less than 99,00,000.
                                </span>
                            <br />
                            <asp:Button ID="updatesrujani" runat="server" OnClick="Updater" Text="Update" AutoPostBack="true"/>  
                        </EditItemTemplate>
                    </asp:FormView>
                </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="LoadSrujani" />
                        </Triggers>
            </asp:UpdatePanel>
        </div>
    <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" CancelSelectOnNullParameter="false" SelectCommand="SELECT * FROM [suggestions] WHERE ((([emp_plno]=@empplno) OR (@empplno IS NULL)) AND (([finyr]=@finyr) OR (@finyr IS NULL)) AND (([suggno]=@suggno) OR (@suggno IS NULL)) AND (([emp_dept]=@emp_dept) OR (@emp_dept IS NULL)) AND eval_status ='E' AND sugg_type != 'C')">
        <SelectParameters>
            <asp:ControlParameter ControlID="emp_dept" Name="emp_dept" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="FinancialYear" Name="finyr" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="SuggnoDropDown" Name="suggno" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="emplno" Name="empplno" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="Autofill" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" CancelSelectOnNullParameter="false"
            SelectCommand="">
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
</div>
</asp:Content>
