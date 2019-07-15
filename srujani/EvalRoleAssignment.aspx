<%@ Page Title="" Language="C#" MasterPageFile="~/Master/layout.master" EnableEventValidation="false" AutoEventWireup="true" codeFile="EvalRoleAssignment.aspx.cs" Inherits="button2" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Assign Srujani to Evaluators</title>
    <style type="text/css">
        .auto-style2 {
            position: absolute;
            top: 50%;
            left: 75%;
            z-index: 1;
            width: 206px;
            height: 76px;
        }
            
        .auto-style3 {
            width: 149px;
            height: 37px;
            position: absolute;
            top: 460px;
            left: 1242px;
            z-index: 1;
            font-size: medium;
        }
        .auto-style4 {
            position: absolute;
            top: 60%;
            left: 75%;
            z-index: 1;
            width: auto;
            height: auto;
        }
            
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="mainContentPlaceholder" Runat="Server">
    <div class="wrapper">
        <asp:UpdatePanel runat="server" ID="UpdatePanel1" >
           <ContentTemplate>
              <div>
               <div class="pane">
               <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableModelValidation="True" Width="500px" BackColor="White">
                   <Columns>
                       <asp:TemplateField>
                           <ItemTemplate>
                               <asp:CheckBox ID="CheckBox1" runat="server" />
                           </ItemTemplate>
                       </asp:TemplateField>
                       <asp:BoundField DataField="SuggNo" HeaderText="Suggestion No." ReadOnly="True" SortExpression="SuggNo" InsertVisible="False" />
                       <asp:BoundField DataField="sugg_topic" HeaderText="Suggestion Topic" SortExpression="sugg_topic" ItemStyle-Width="60%"/>
                   </Columns>
                       <EmptyDataTemplate>
                            <br />
                            NO SRUJANIS FOUND IN YOUR DEPARTMENT
                            <br />
                        </EmptyDataTemplate>
               </asp:GridView>
                   <asp:Button ID="Button4" runat="server" CssClass="auto-style4" OnClick="Button4_Click" Text="Assign" />
                   </div>
                  <asp:DropDownList ID="DropDownList1" CssClass="auto-style2" runat="server" DataSourceID="SqlDataSource4" DataTextField="emp_name" DataValueField="emp_plno" Height="30px" Width="210px">
                  </asp:DropDownList>
               </div>   
               <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT SuggNo,sugg_topic FROM Suggestions  WHERE emp_dept=@dept_code AND eval_plno IS NULL">
                   <SelectParameters>
                       <asp:SessionParameter Name="dept_code" SessionField="dept_dept_cd" />
                   </SelectParameters>
               </asp:SqlDataSource>
               

               <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SrujaniDBConnectionString1 %>" SelectCommand="SELECT emp_name,emp_plno FROM Employee_master WHERE (emp_plno IN (SELECT EvalPlno FROM Evaluator)AND emp_dept=@dept_code)">
                   <SelectParameters>
                       <asp:SessionParameter Name="dept_code" SessionField="dept_dept_cd" />
                   </SelectParameters>
               </asp:SqlDataSource>


               <br />
               
             
          
            </ContentTemplate>
            </asp:UpdatePanel>
            </div>
    </asp:Content>