<%@ Page Title="" Language="C#" MasterPageFile="~/Master/layout.master" AutoEventWireup="true" CodeFile="AssignEval.aspx.cs" Inherits="AssignEval" EnableEventValidation ="false"%>

<asp:Content ID="contentHead" ContentPlaceHolderID="head" Runat="Server">
    <title>Choose Evaluators from your Department</title>
</asp:Content>

<asp:Content ID="contentBody" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:UpdatePanel ID="AsyncGrid" runat="server">
           
            <ContentTemplate>
               <div style="margin-left:30%; padding-top:20px ">
               
                       <asp:GridView runat="server" AutoGenerateColumns="false" DataKeyNames="emp_plno" CssClass="GridPosition" DataSourceID="SqlDataSource1" Width="500px" AllowPaging="True" ID="GridView1" BackColor="White">
                           <Columns>
                               <asp:TemplateField>
                                   <ItemTemplate>
                                       <asp:CheckBox ID="CheckBox1" runat="server" />
                                   </ItemTemplate>
                               </asp:TemplateField>
                               <asp:BoundField DataField="emp_plno" HeaderText="Employee PlNo" ReadOnly="True" SortExpression="emp_plno" />
                               <asp:BoundField DataField="emp_name" HeaderText="Employee Name" SortExpression="emp_name" ItemStyle-Width="60%"/>
                           </Columns>
                   
                        <EmptyDataTemplate>
                            <br />
                                    No Employees Left To Be Assigned As Evaluator
                                    <br />
                        </EmptyDataTemplate>
                       </asp:GridView>
                           </div>
                       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT emp_plno, emp_name FROM Employee_master WHERE (emp_plno NOT IN (SELECT EvalPlno FROM Evaluator)AND emp_dept=@dept_code AND emp_sclcd IN('501','502','503','504','505','506','507','508','509','601','602'))">
                           <SelectParameters>
                               <asp:SessionParameter Name="dept_code" SessionField="dept_dept_cd" DefaultValue="0000" />
                           </SelectParameters>
                       </asp:SqlDataSource>
               
             
                       <br />
               
             
                       <asp:Button ID="Button2" runat="server" Text="Make Evaluator" Width="217px" OnClick="btnGetRecord_Click1" />
                       <br />
                       <br/>
               
                       <div style="margin-left:30%" >
                       <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="false" DataKeyNames="emp_plno" DataSourceID="SqlDataSource2" Width="500px" BackColor="White">
                           <Columns>
                               <asp:TemplateField>
                                   <ItemTemplate>
                                       <asp:CheckBox ID="CheckBox2" runat="server" />
                                   </ItemTemplate>
                               </asp:TemplateField>
                               <asp:BoundField DataField="emp_plno" HeaderText="Evaluator PlNo" ReadOnly="True" SortExpression="emp_plno" />
                               <asp:BoundField DataField="emp_name" HeaderText="Evaluator Name" SortExpression="emp_name" ItemStyle-Width="60%"/>
                           </Columns>
                        <EmptyDataTemplate>
                            <br />
                                    No one assigned as Evaluator
                                    <br />
                        </EmptyDataTemplate>
                       </asp:GridView> 
                   
                </div>
               <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT emp_plno, emp_name FROM Employee_master WHERE (emp_plno IN (SELECT EvalPlno FROM Evaluator)AND emp_dept=@dept_code )">
                   <SelectParameters>
                       <asp:SessionParameter Name="dept_code" SessionField="dept_dept_cd" DefaultValue="0000" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <br />
               <asp:Button ID="Button3" runat="server" Text="Remove Evaluator" Width="217px" OnClick="btnGetRecord_Click2"/>
                
               <br />
            </ContentTemplate>
            </asp:UpdatePanel>
            </asp:UpdatePanel>
            </div>
    </asp:Content>