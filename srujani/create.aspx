<%@ Page Title="" Language="C#" MasterPageFile="~/Master/layout.master" AutoEventWireup="true" CodeFile="create.aspx.cs" Inherits="create" EnableEventValidation ="false"%>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <title>Submit a new Srujani</title>
    <link rel="stylesheet" href="../css/create.css" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:UpdatePanel runat="server" ID="FormPanel" UpdateMode="Conditional" ChildrenAsTriggers="false">
           <ContentTemplate>
                <asp:formView ID="FormView1" runat="server" DataKeyNames="emp_plno" DataSourceID="SrujaniDB" DefaultMode="Insert" ForeColor="#333333" AllowPaging="True">
                    <InsertItemTemplate>
                      <div id ="print">
                        <div class="pane">
                            <div class="form" runat ="server">
                                <div class="field">
                                    <label>Employee no.</label>
                                    <asp:TextBox ID="EmployeeNo" placeholder="Enter 6-digit Employee No." runat="server" Enabled="True" AutoPostBack="true" MaxLength="6" OnTextChanged="onValidated" Text='<%# Bind("empplno") %>' />
                                    <div class="validator">
                                        <asp:RequiredFieldValidator ID="EmpNoRequired" runat="server" ValidationGroup="1" ErrorMessage="Fill in your employee no" ControlToValidate="EmployeeNo"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="EmpNoPatternValidator" runat="server" ErrorMessage="Invalid Employee no" ControlToValidate="EmployeeNo" ValidationGroup="1" ValidationExpression="(^[0-9]{6}$)"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>Employee Name </label>
                                    <asp:TextBox ID="Employeename" runat="server" Enabled="False"/>
                                    <div class="validator">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="" ControlToValidate="DepartmentCode" ValidationGroup="1"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pane">
                            <div class="form">
                                <div class="field">
                                    <label>Department </label>
                                    <asp:TextBox ID="DepartmentCode" runat="server" Enabled="False" ToolTip='<%# Bind("empdept") %>' />
                                    <div class="validator">
                                        <asp:RequiredFieldValidator ID="Validator" runat="server" ErrorMessage="" ControlToValidate="DepartmentCode" ValidationGroup="1"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>Financial year </label>
                                    <asp:TextBox ID="FinancialYear" runat="server" Enabled="False" Text='<%# Bind("finyr") %>' />
                                    <div class="validator"></div>
                                </div>
                            </div>
                        </div>
                        <div class="pane">
                            <div class="form">
                                <div class="field">
                                    <label>Submitted on </label>
                                    <asp:TextBox ID="SubmitDate" runat="server" Enabled="False" Text='<%# Bind("suggsubmitdate") %>' TextMode="Date" />
                                    <div class="validator">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Submit Date" ControlToValidate="SubmitDate" ValidationGroup="1"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>Submitted by: </label>
                                    <asp:TextBox ID="SubmittedBy" runat="server" Enabled="False" ToolTip='<%# Bind("suggsubmittedby") %>' />
                                    <div class="validator"></div>
                                </div>

                            </div>
                        </div>
                          <br />
                        <div class="pane stretch">
                            <div class="field">
                                <label>Enter Subject Below </label>
                                <asp:TextBox ID="Subject" runat="server"  MaxLength="200" Height="50px" Text='<%# Bind("suggtopic") %>' onkeyDown="return checkTextAreaMaxLength(this,event,'200');" onblur="checkLength(this, '200')" TextMode="multiLine"/>
                                <div class ="validator">
                                    <asp:RequiredFieldValidator ID="subjectvalidator" runat="server" ValidationGroup="1" ErrorMessage="Fill in your subject" ControlToValidate="Subject"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="pane stretch">
                            <div class="field">
                                <label>Enter Description below </label>
                                <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" MaxLength="500" Height="90px" Text='<%# Bind("suggdesc") %>' onkeydown = " return checkTextAreaMaxLength(this,event,'500');" onblur="checkLength(this, '500')"/>
                                <div class ="validator">
                                    <asp:RequiredFieldValidator ID="DescriptionValidator" runat="server" ValidationGroup="1" ErrorMessage="Fill in your description" ControlToValidate="Description" ></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                   </div>
                        <div class="actions">
                            <asp:LinkButton CssClass="button" ID="InsertButton" runat="server" CausesValidation="True" ValidationGroup="1" CommandName="Insert" Text="Submit"/>
                        </div>
                    </InsertItemTemplate>
                </asp:formView>
                    
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="SrujaniDB" runat="server" OnInserted="OnInserted" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>"
         InsertCommand="INSERT INTO [suggestions] ([finyr], [emp_plno], [emp_dept], [sugg_topic], [sugg_submitted_by],[sugg_desc],[sugg_submit_date],[sugg_level],[eval_status],[sugg_type]) 
        VALUES (@finyr, @empplno, @empdept, @suggtopic, @suggsubmittedby, @suggdesc, @suggsubmitdate, 1,'P','F') SET @Identity = @@Identity;
        UPDATE [suggestions] SET [emp_type]=(SELECT [emp_type] from Employee_Master where emp_plno=@empplno),
         [emp_payoffice]=(SELECT [emp_payoffice] from Employee_Master where emp_plno=@empplno),
         [emp_cc]=(SELECT [emp_cc] from Employee_Master where emp_plno=@empplno) WHERE SuggNo = @Identity;">
        <InsertParameters>
            <asp:Parameter Name="empplno" Type="Decimal" />
            <asp:Parameter Name="finyr" Type="Decimal" />
            <asp:Parameter Name="empdept" Type="Decimal" />
            <asp:Parameter Name="suggtopic" Type="String" />
            <asp:Parameter Name="suggdesc" Type="String" />
            <asp:Parameter Name="suggsubmitdate" Type="datetime" />
            <asp:Parameter Name="suggsubmittedby" Type="Decimal" />
            
            <asp:Parameter Name="SuggNo" Type="Decimal" Direction="Output" />        
            <asp:Parameter Name="Identity" Type="Decimal" Direction="Output" />         
        </InsertParameters>
    </asp:SqlDataSource>
    <!--<asp:sqldatasource ID ="ss" runat ="server"
        selectcommand =" SELECT emp_type,emp_payoffice,emp_cc from employee_master WHERE [emp_plno] = empplno;">
        <SelectParameters>
            <asp:Parameter Name ="empplno" Type ="Decimal" />
        </SelectParameters>
    </asp:sqldatasource>-->

<script type="text/javascript">
    function checkTextAreaMaxLength(textBox, e, length) {
            var mLen =  length;
            
            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                    {

                        alert("max length exceded");
                        e.returnValue = false;
                        return false;
                    }
                    else//Firefox
                        e.preventDefault();
                }
            }
        }
    function checkSpecialKeys(e) {

        if (e.keyCode != 9 && e.keyCode != 8 && e.keyCode != 46 &&
        e.keyCode != 35 && e.keyCode != 36 && e.keyCode != 37 &&
        e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
            return false;
        else
            return true;
    }
        function checkLength(textBox, length) {
            var mLen = length;
            
            var maxLength = parseInt(mLen);
            
            if (textBox.value.length > maxLength) {
                textBox.value = textBox.value.substring(0, maxLength);
            }
        }
        </script>
</asp:Content>

