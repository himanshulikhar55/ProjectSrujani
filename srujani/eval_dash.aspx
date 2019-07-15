<%@ Page Title="Evaluator Dashboard" Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/layout.master" CodeFile="eval_dash.aspx.cs" Inherits="eval_dash" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <title>Evaluator Dashboard</title>
    <link href="css/evaldash.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
        }
        #grid-view-container{
            height:auto;
        }
        .auto-style2 {
            font-size: medium;
        }
        .auto-style3 {
            margin-top: 0px;
        }
        .new-class{
            margin-left:0%;
        }
        .new-class-1{
            margin-right:1%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="mainContentPlaceholder">
    <div class="wrapper">
        <br/>
        <asp:Panel runat="server">
            <span class="auto-style2">Choose Financial Year First And Then The Srujani Number:
            
                <asp:DropDownList ID="finyr" runat="server" AppendDataBoundItems="True" AutoPostBack="true" CssClass="auto-style3" DataSourceID="FinancialYears" DataTextField="finyr" DataValueField="finyr" onselectedindexchanged="finyr_SelectedIndexChanged"> 
                    <asp:ListItem Value="">Choose a Financial Year</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="SuggNo" runat="server" AppendDataBoundItems="True" AutoPostBack="true" ControlID="selectsrujani" DataSourceID="SqlDataSource2" DataTextField="SuggNo" DataValueField="SuggNo" Width="204px">
                <asp:ListItem Value="">Choose a Srujani number</asp:ListItem>
            </asp:DropDownList>
             </span>
                
                </asp:Panel>
                    
                        <asp:SqlDataSource ID="FinancialYears" runat="server"  ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [finyr] FROM [suggestions] WHERE eval_status = 'P'"></asp:SqlDataSource>
                    <br/>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [SuggNo] FROM [Suggestions] WHERE eval_plno = @eval_plno AND eval_status = 'P' AND finyr = @finyr">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="finyr" Name="finyr" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
                                <asp:SessionParameter Name="eval_plno" SessionField="user" Type="Decimal" />
                            </SelectParameters>
            </asp:SqlDataSource>
            <div class="pane table" aria-multiline="True" aria-orientation="horizontal">
                <asp:UpdatePanel ID="AsyncGrid" runat="server">
                <ContentTemplate>
                 <div id="grid-view-container" style="word-wrap:break-word;">
                     <div class="pane table">
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" style=" margin-left: 10px; margin-right: 10px; margin-top: 3px; height:60px " CellPadding="0" HorizontalAlign="Center" >
                <Columns>
                    <asp:BoundField DataField="finyr" HeaderText="Fin Year" SortExpression="finyr" />
                    <asp:BoundField DataField="emp_name" HeaderText="Emp Name" SortExpression="emp_name" />
                    <asp:BoundField DataField="emp_plno" HeaderText="Emp Pl No." SortExpression="emp_plno" />
                            <asp:TemplateField HeaderText="Level" SortExpression="level">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# GlobalFunctions.RenderLevel(DataBinder.Eval(Container.DataItem,"sugg_level")) %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                    <asp:BoundField DataField="sugg_topic" HeaderText="Topic" SortExpression="Sugg_topic" />
                    <asp:BoundField DataField="sugg_desc" HeaderText="Description" SortExpression="sugg_desc" />
                </Columns>
                <EmptyDataTemplate>
                            NO RECORDS FOUND WITH GIVEN CONSTRAINTS 
                </EmptyDataTemplate>
            </asp:GridView>
                     </div>
                     </div>
            </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <br/>
        <br/>
    <div class="custom">
        <asp:DropDownList ID="DropDownList1" runat="server" style="border-color:black">
            <asp:ListItem Value="A1">Choose an option</asp:ListItem>
            <asp:ListItem Value="E1">New idea recommended for implementation</asp:ListItem>
            <asp:ListItem Value="E2">Not a new idea / Not accepted</asp:ListItem>
            <asp:ListItem Value="I6">Implementation in progress</asp:ListItem>
            <asp:ListItem Value="I7">Implemented and found effective</asp:ListItem>
            <asp:ListItem Value="I8">No desired benefit</asp:ListItem>
            <asp:ListItem Value="I9">Can&#39;t be implemented</asp:ListItem>
        </asp:DropDownList>
            <div class="validator">
                <asp:RequiredFieldValidator ID="DropDownList1Validator" runat="server" InitialValue="A1" ErrorMessage="Please choose a value" ControlToValidate="DropDownList1" ValidationGroup="2"></asp:RequiredFieldValidator>
            </div>
        <span class="new-class">
            <asp:Label ID="imp_cost_label" runat="server" Text="Implementation Cost"></asp:Label>
            <asp:TextBox ID="imp_cost_value" runat="server" MaxLength="12" BorderColor="Black" Height="30px"></asp:TextBox>
            
            <asp:RangeValidator ID="rvclass" runat="server" ControlToValidate="imp_cost_value" ErrorMessage="Enter numeric value " MaximumValue="999999999.99" MinimumValue="0.00" Type="Double"></asp:RangeValidator>
        </span>
        <span class="new-class-1">
            <asp:Label ID="doi_iai" runat="server" Text="Date of Implementation (if already implemented)"></asp:Label>
                <asp:TextBox ID="doi_iai_value" runat="server" BorderColor="Black" Height="30px" TextMode="Date"></asp:TextBox>
            <br />
            </span>
      <br />
        <span class="new-class">
            <asp:Label ID="imp_dur_label" runat="server" Text="Implementation Duration (Months)"></asp:Label>
            <asp:TextBox ID="imp_dur_value" runat="server" BorderColor="Black" Height="30px"></asp:TextBox>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="imp_dur_value" ErrorMessage="Enter 3 digit number " MaximumValue="999" MinimumValue="0" Type="Integer"></asp:RangeValidator>
        </span>
        <span class="new-class-1">
            <asp:Label ID="imp_dur_month" runat="server" Text="Implementation Duration (Days)"></asp:Label>
            <asp:TextBox ID="imp_dur_mon_value" runat="server" BorderColor="Black" Height="30px"></asp:TextBox>
            <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="imp_dur_mon_value" ErrorMessage="Enter 3 digit number " MaximumValue="999" MinimumValue="0" Type="Integer"></asp:RangeValidator>
        <br />
        </span>
           <br />
        <span class="new-class">
            <asp:Label ID="sav_reccur" runat="server" Text="Savings Recurring"></asp:Label>
            <asp:TextBox ID="sav_recurr_val" runat="server" BorderColor="Black" BorderStyle="Solid" Height="30px"></asp:TextBox>
            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="sav_recurr_val" ErrorMessage="Enter numeric value" MaximumValue="999999999.99" MinimumValue="0.00" Type="Double"></asp:RangeValidator>
        </span>
        <span class="new-class-1">
            <asp:Label ID="sav_ot" runat="server" Text="Savings One Time"></asp:Label>
            <asp:TextBox ID="sav_ot_val" runat="server" BorderColor="Black" Height="30px"></asp:TextBox>
            <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="sav_ot_val" ErrorMessage="Enter numeric value" MaximumValue="999999999.99" MinimumValue="0.00" Type="Double"></asp:RangeValidator>
       
            <br />
       
            </span>
        <br />
        <span>
            <asp:Label ID="sav_intan" runat="server" Text="Savings Intangible"></asp:Label>
            <asp:TextBox ID="sav_intang_val" runat="server" BorderColor="Black" Height="30px"></asp:TextBox>
            <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="sav_intang_val" ErrorMessage="Enter numeric value" MaximumValue="999999999.99" MinimumValue="0.00" Type="Double"></asp:RangeValidator>
        </span>
        <span>
            <asp:Label ID="sugg_imp" runat="server" Text="Suggestion Implementation Type"></asp:Label>
            <asp:DropDownList ID="sugg_imp_type" runat="server" style="border-color:black">
                <asp:ListItem Value="">Choose an option</asp:ListItem>
                <asp:ListItem Value="I">Inhouse</asp:ListItem>
                <asp:ListItem Value="O">Other</asp:ListItem>
            </asp:DropDownList>
         </span>
    </div>
        <br/>
        <div>
            <asp:Label ID="evalcomments" runat="server" Text="Evaluator Comments:"></asp:Label>
            
            <br />
            
            <asp:TextBox ID="Eval_Comments" placeholder="Max Length 200 characters" Maxlength="200" runat="server" Height="60px" Width="1200px" BorderColor="Black" onkeyDown="return checkTextAreaMaxLength(this,event,'200');" onblur="checkLength(this, '200')" TextMode="multiLine" CssClass="textArea"></asp:TextBox>
        </div>

        <script type="text/javascript">

        function checkTextAreaMaxLength(textBox, e, length) {

            var mLen =  length;
            
            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                    {
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
    <br />

  <asp:Button ID="submit" Text="Submit" runat="server" OnClick="InsertIntoDatabase" ValidationGroup="2"/>
            
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" CancelSelectOnNullParameter="true" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT E.finyr,N.emp_name,E.emp_plno,E.sugg_level,E.sugg_topic,E.sugg_desc FROM Suggestions E, Employee_master N WHERE N.emp_plno = E.emp_plno AND (((Suggno = @Suggno) OR (Suggno IS NULL)) AND (([finyr]=@finyr) OR (@finyr IS NULL) ))">
                <SelectParameters>
                                <asp:ControlParameter ControlID="Suggno" Name="Suggno" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
                                <asp:ControlParameter ControlID="finyr" Name="finyr" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
                </SelectParameters>
            </asp:SqlDataSource>
    
    </div>
</asp:Content>

