using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;




public partial class AssignEval : System.Web.UI.Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("~/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
        if(Session["session_access_level"] == null || Session["user"] == null )
        {
            Response.Redirect("index.aspx");
        }
    }
    protected void btnGetRecord_Click1(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("CheckBox1");
            if (chk != null & chk.Checked)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                Int32 plno = Int32.Parse(row.Cells[1].Text);
                string query1 = "Insert into evaluator(EvalPlno, dept_emp_type, dept_payoffice, dept_dept_cd, demp_cc) values ((Select emp_plno From Employee_master where emp_plno=@plno),(Select emp_type From Employee_master where emp_plno=@plno),(Select emp_payoffice From Employee_master where emp_plno=@plno) ,(Select emp_dept From Employee_master where emp_plno=@plno), (Select emp_cc From Employee_master where emp_plno=@plno))";
                //string query2 = "Select dept_emp_type from Suggestions where EvalPlno = @plno"
                SqlCommand cmd = new SqlCommand(query1, con);
                cmd.Parameters.AddWithValue("@plno", plno);
                //cmd.Parameters.AddWithValue("@a", plno);
                //cmd.Parameters.AddWithValue("@b", plno);
                //cmd.Parameters.AddWithValue("@c", plno);
                //cmd.Parameters.AddWithValue("@d", plno);
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        Response.Redirect("AssignEval.aspx");
    }
    protected void btnGetRecord_Click2(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView2.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("CheckBox2");
            if (chk != null & chk.Checked)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                Int32 plno = Int32.Parse(row.Cells[1].Text);
                string query1 = "Delete From Evaluator Where EvalPlno = @plno";
                //string query2 = "Select dept_emp_type from Suggestions where EvalPlno = @plno"
                SqlCommand cmd = new SqlCommand(query1, con);
                cmd.Parameters.AddWithValue("@plno", plno);
                //cmd.Parameters.AddWithValue("@a", plno);
                //cmd.Parameters.AddWithValue("@b", plno);
                //cmd.Parameters.AddWithValue("@c", plno);
                //cmd.Parameters.AddWithValue("@d", plno);
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }
        Response.Redirect("AssignEval.aspx");
    }
}
