<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Master/layout.master" CodeFile="ied_dash2.aspx.cs" Inherits="ieddash2" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/StyleSheet.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:Panel CssClass="pane" ID="Panel" runat="server">
            <div class="form">
              
                <div class="field">
                    <asp:DropDownList ID="Level" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("sugg_level") %>' DataTextField="sugg_level" DataValueField="sugg_level" AutoPostBack="true">
                        <asp:ListItem Value="">Choose a Level</asp:ListItem>
                        <asp:ListItem Value="1">Departmental</asp:ListItem>
                        <asp:ListItem Value="2">Zonal</asp:ListItem>
                        <asp:ListItem Value="3">Apex</asp:ListItem>
                        <asp:ListItem Value="4">CEO Approval</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="D1" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [sugg_level] FROM [suggestions]">
                    </asp:SqlDataSource>
      
                </div>
                <div class="field">
                        <asp:DropDownList ID="Sugg_stat" runat="server" AppendDataBoundItems="True"  DataTextField="sugg_type" DataValueField="sugg_type" SelectedValue='<%# Bind("sugg_type") %>'  AutoPostBack="true">
                            <asp:ListItem Value="">Choose Suggesstion Status</asp:ListItem>
                            <asp:ListItem Value="F">Fresh</asp:ListItem>
                            <asp:ListItem Value="A">Alive</asp:ListItem>
                            <asp:ListItem Value="D">Dormant</asp:ListItem>
                            <asp:ListItem Value="C">Closed</asp:ListItem>
                         </asp:DropDownList>
                        <asp:SqlDataSource ID="D2" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [sugg_type] FROM [Suggestions]">
                        </asp:SqlDataSource>
                    
                </div>
                <div class="field">
                        <asp:DropDownList ID="Sugg_award" runat="server" AppendDataBoundItems="True"  DataTextField="sugg_award" DataValueField="sugg_award" SelectedValue='<%# Bind("sugg_award") %>'  AutoPostBack="true">
                            <asp:ListItem Value="">Choose the Award Type</asp:ListItem>                          
                            <asp:ListItem Value="TO">Token</asp:ListItem>
                            <asp:ListItem Value="TD">Token & Closed</asp:ListItem>
                            <asp:ListItem Value="TC">Token & Cash</asp:ListItem>
                            <asp:ListItem Value="TN">Token Earlier Cash Now</asp:ListItem>
                            <asp:ListItem Value="RH">Refer for Higher</asp:ListItem>
                            <asp:ListItem Value="RO">Refer to Other Dept</asp:ListItem>
                            <asp:ListItem Value="NA">Not Accepted</asp:ListItem>
                         </asp:DropDownList>
                        <asp:SqlDataSource ID="D3" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT DISTINCT [sugg_award] FROM [suggestions]">
                        </asp:SqlDataSource>
                    
                </div>
            
            </div>
          </asp:Panel>
        <div class="pane table">
            <asp:UpdatePanel ID="AsyncGrid" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="suggno" DataSourceID="SqlDataSource3" AllowPaging="True">
                        <Columns>
                            
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
                  
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
       
    <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" CancelSelectOnNullParameter="false" SelectCommand="SELECT * FROM [suggestions] WHERE ((([sugg_level]=@sugg_level) OR (@sugg_level IS NULL)) AND (([sugg_type]=@sugg_type) OR (@sugg_type IS NULL)) AND (([sugg_award]=@sugg_award) OR (@sugg_award IS NULL)))">
        <SelectParameters>
            <asp:ControlParameter ControlID="Level" Name="sugg_level" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="Sugg_stat" Name="sugg_type" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="Sugg_award" Name="sugg_award" ConvertEmptyStringToNull="true" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Autofill" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" CancelSelectOnNullParameter="false"
            SelectCommand="">
        </asp:SqlDataSource>

    </div>
</asp:Content>
