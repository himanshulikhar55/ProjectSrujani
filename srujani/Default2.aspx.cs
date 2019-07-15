using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string s = Request["suggno"];
        autofill(s);
        ((TextBox)FindControl("textbox3")).Enabled = false;
        ((TextBox)FindControl("textbox6")).Enabled = false;
        ((TextBox)FindControl("textbox5")).Enabled = false;
        ((TextBox)FindControl("textbox4")).Enabled = false;
        ((TextBox)FindControl("textbox7")).Enabled = false;
        ((TextBox)FindControl("textbox10")).Enabled = false;
        ((TextBox)FindControl("textbox123")).Enabled = false;
        ((TextBox)FindControl("textbox9")).Enabled = false;
        ((TextBox)FindControl("textbox14")).Enabled = false;
        ((TextBox)FindControl("textbox12")).Enabled = false;
        ((TextBox)FindControl("textbox15")).Enabled = false;
        ((TextBox)FindControl("textbox16")).Enabled = false;
        ((TextBox)FindControl("textbox2")).Enabled = false;
        ((TextBox)FindControl("textbox8")).Enabled = false;
        ((TextBox)FindControl("textbox1")).Enabled = false;
    }
    protected void autofill(string suggno)
    {
        string query = "Select S.SuggNo,S.sugg_submit_date,S.emp_plno,E.emp_name,E.emp_sclcd,S.emp_type,D.dept_name,S.emp_payoffice,S.sugg_topic,S.sugg_desc FROM Suggestions S, Employee_Master E,Dept D WHERE S.emp_plno=E.emp_plno AND E.emp_type=D.dept_emp_type AND E.emp_payoffice=D.dept_payoffice AND E.emp_dept=D.dept_dept_cd AND E.emp_cc=D.demp_cc AND suggno = " + suggno;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                ((TextBox)FindControl("textbox3")).Text = reader["SuggNo"].ToString().Trim();
                ((TextBox)FindControl("textbox6")).Text = reader["SuggNo"].ToString().Trim();
                ((TextBox)FindControl("textbox7")).Text = reader["sugg_submit_date"].ToString().Trim();
                ((TextBox)FindControl("textbox4")).Text = reader["sugg_submit_date"].ToString().Trim();
                ((TextBox)FindControl("textbox5")).Text = reader["emp_plno"].ToString().Trim();
                ((TextBox)FindControl("textbox10")).Text = reader["emp_plno"].ToString().Trim();
                ((TextBox)FindControl("textbox123")).Text = reader["emp_name"].ToString().Trim();
                ((TextBox)FindControl("textbox9")).Text = reader["emp_name"].ToString().Trim();
                ((TextBox)FindControl("textbox14")).Text = reader["dept_name"].ToString().Trim();
                ((TextBox)FindControl("textbox12")).Text = reader["dept_name"].ToString().Trim();
                ((TextBox)FindControl("textbox15")).Text = reader["emp_payoffice"].ToString().Trim();
                ((TextBox)FindControl("textbox16")).Text = reader["emp_sclcd"].ToString().Trim();
                ((TextBox)FindControl("textbox2")).Text = reader["sugg_topic"].ToString().Trim();
                ((TextBox)FindControl("textbox8")).Text = reader["sugg_topic"].ToString().Trim();
                ((TextBox)FindControl("textbox1")).Text = reader["sugg_desc"].ToString().Trim();

            }

        }
    }
}