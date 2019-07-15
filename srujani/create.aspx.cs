using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

public partial class create : System.Web.UI.Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
        //Stop Caching
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (Session["user"] == null)
        {
            Response.Redirect("index.aspx");
        }
        
        DateTime d = new DateTime();
        d = DateTime.Now;
        string finyr;
        if (d.Month <= 3)
        {
            finyr = d.AddYears(-1).Year.ToString() + d.Year.ToString().Substring(2);
        }
        else
        {
            finyr = d.Year.ToString() + d.AddYears(1).Year.ToString().Substring(2);
        }
        DateTime currentdate = new DateTime();
        currentdate = DateTime.Now;
        if ((currentdate.Month >= 4))
        {
            SqlConnection selectconnection = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
            selectconnection.Open();
            String selectquery = "select top 1 finyr as asd from suggestions ORDER BY finyr Desc;";
            SqlCommand cmd1 = new SqlCommand(selectquery, selectconnection);
            SqlDataReader reader = cmd1.ExecuteReader();
            if (reader.HasRows)
                while (reader.Read())
                {

                    if (Convert.ToString(reader["asd"]) == finyr)
                    {

                    }
                    else
                    {
                        SqlConnection updateidentity = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                        updateidentity.Open();
                        String updatequery = "DBCC CHECKIDENT ('suggestions', RESEED, 0)";
                        SqlCommand cmd2 = new SqlCommand(updatequery, updateidentity);
                        cmd2.ExecuteNonQuery();
                        updateidentity.Close();
                    }
                }
            selectconnection.Close();
        }
            if ((String)Session["session_access_level"] == "2")
        {
            ((TextBox)FormView1.FindControl("SubmitDate")).Text = d.ToString("dd-MM-yyyy");
            ((TextBox)FormView1.FindControl("SubmitDate")).Enabled = true;
        }
        if (FormView1.CurrentMode == FormViewMode.Insert)
        {
            ((TextBox)FormView1.FindControl("FinancialYear")).Text = finyr;
            if ((String)Session["session_access_level"] == "1")
            {
                ((TextBox)FormView1.FindControl("SubmitDate")).Text = d.ToString("yyyy-MM-dd");
                ((TextBox)FormView1.FindControl("SubmitDate")).Enabled = false;
            }

            ((TextBox)FormView1.FindControl("SubmittedBy")).ToolTip = (String)Session["user"];
            ((TextBox)FormView1.FindControl("SubmittedBy")).Text = GlobalFunctions.RenderEmpName(Session["user"]);
        }

        if ((string) Session["asemployee"] == "1")
        {
            TextBox EmpNo = FormView1.FindControl("EmployeeNo") as TextBox;
            EmpNo.Text = (String)Session["user"];
            EmpNo.Enabled = false;
            autofill((String)Session["user"]);
            return;
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    public void MsgBox(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "'); location.href = 'create.aspx'", true);
        //Response.Redirect("create.aspx");
    }
    protected void autofill(String empno)
    {
        refreshlist();
        if (empno.Length != 6)
        {
            return;
        }
        string query = "select emp_name, emp_dept, emp_plno from employee_master where emp_plno=" + empno.ToString().Trim();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();

        if (reader.HasRows)
        {

            while (reader.Read())
            {
                if ((String)Session["session_access_level"] == "2")
                {
                    if ((decimal)Session["dept_dept_cd"] != Convert.ToDecimal(reader["emp_dept"]))
                    {
                        MsgBox("The Employee is of another department. You can add employee of your department only", false, "");
                        refreshlist();
                        return;
                    }

                }
                if (reader["emp_plno"] != null)
                    ((TextBox)FormView1.FindControl("DepartmentCode")).ToolTip = reader["emp_dept"].ToString();
                ((TextBox)FormView1.FindControl("DepartmentCode")).Text = GlobalFunctions.RenderDepName(reader["emp_dept"].ToString());
                ((TextBox)FormView1.FindControl("Employeename")).Text = reader["emp_name"].ToString();
            }
        }
        else
        {

            refreshlist();
        }
        FormPanel.Update();

    }
    protected void onValidated(object sender, EventArgs e)
    {
        refreshlist();
        autofill(((TextBox)FormView1.FindControl("EmployeeNo")).Text);
    }

    protected void refreshlist()
    {
        ((TextBox)FormView1.FindControl("DepartmentCode")).ToolTip = "";
        ((TextBox)FormView1.FindControl("DepartmentCode")).Text = "";
        ((TextBox)FormView1.FindControl("Employeename")).Text = "";
        FormPanel.Update();

    }
    
    protected void OnInserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string newId = e.Command.Parameters["@Identity"].Value.ToString();
        MsgBox("Your Srujani was submitted. Srujani No. - " + newId, true, "");
    }
}