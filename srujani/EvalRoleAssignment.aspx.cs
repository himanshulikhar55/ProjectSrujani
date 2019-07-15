
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

public partial class button2 : System.Web.UI.Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("~/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView3.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("CheckBox1");
            if (chk != null & chk.Checked)
            {
                Int32 suggno = Int32.Parse(row.Cells[1].Text);
                SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con1.Open();
                string query1 = "UPDATE Suggestions SET eval_plno = " + DropDownList1.SelectedValue + " WHERE SuggNo= " + suggno;

                //string query2 = "Select dept_emp_type from Suggestions where EvalPlno = @plno"
                SqlCommand cmd2 = new SqlCommand(query1, con1);
                cmd2.ExecuteNonQuery();
                con1.Close();

            }

        }
        Response.Redirect("EvalRoleAssignment.aspx");
    }
}