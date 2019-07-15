using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class ieddash : System.Web.UI.Page
{
    protected void selectcommand(object sender, EventArgs e)
    {
        if (FinancialYear.SelectedValue.ToString().Trim() != "")
            SqlDataSource1.SelectCommand = "SELECT [SuggNo] FROM [Suggestions] WHERE ((finyr = @finyr1 AND eval_status = 'E' AND sugg_type != 'C'))";
        else
        {
            SqlDataSource1.SelectCommand = "SELECT distinct [SuggNo] FROM [Suggestions] WHERE suggno in (Select suggno from suggestions where eval_status = 'E' AND sugg_type != 'C')";
            Response.Redirect("/ied_dash.aspx");
        }
    }
    
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage); ;
        if (Session["user"] == null || Convert.ToDecimal(Session["session_access_level"]) != 4)
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("index.aspx");
        }

    }
    public void MsgBoxUpdated(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "');location.href = 'ied_dash.aspx'", true);
    }
    public void MsgBox(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "');location.href = 'ied_dash.aspx'", true);
    }
    protected void OnUpdated()
    {
        MsgBoxUpdated("Updated Successfully", true, "");
        ((UpdatePanel)Master.FindControl("DialogBoxPanel")).Update();
        Autofill.SelectCommand = "";
        AsyncForm.Update();
    }
    protected void EnableCash(object sender, EventArgs e)
    {

    }
    protected void ReflectToAward(object sender, EventArgs e)
    {
        TextBox Award = ((TextBox)FormView1.FindControl("Award"));
        string a = ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value;
        if (a == "TC" || a == "TN")
        {
                Award.Enabled = true;
        }
        else
        {
            Award.Enabled = false;
        }
        AsyncForm.Update();
    }
    protected void SrujaniLoader(object sender, EventArgs e)
    {
        decimal asd = 0;
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
            if (chk != null & chk.Checked)
            {
                asd = Convert.ToDecimal(row.Cells[4].Text);
            }
        }
        string SelectCommand = "";
        string query = "select emp_dept from suggestions where suggno=" + asd.ToString().Trim();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                if (Session["dept_dept_cd"] != null)
                {
                        SelectCommand = "SELECT * FROM [suggestions] WHERE [suggno] = " + asd.ToString().Trim();
                    
                }
                else
                {
                    Response.Redirect("/index.aspx");
                }
            }
        }
        else
        {
            MsgBox("This Srujani does not exist", false, "");
            SelectCommand = "";
        }
        con.Close();
        Autofill.SelectCommand = SelectCommand;
        AsyncForm.Update();
    }
    protected void Updater(object sender, EventArgs e)

    {
        string a = "" ;
        if (((DropDownList)FormView1.FindControl("suggaward")).SelectedValue.ToString().Trim() == "TC" || ((DropDownList)FormView1.FindControl("suggaward")).SelectedValue.ToString().Trim() == "TN")
        {
            if(((DropDownList)FormView1.FindControl("level")).SelectedValue.ToString().Trim() == "1" && Convert.ToInt32(((TextBox)FormView1.FindControl("award")).Text) <= 300)
            {
                string sgno = Session["user"].ToString();
                string query = "UPDATE [suggestions] SET  [sugg_award_amt] = @a,[sugg_type] = @b, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
                Decimal sno = 0;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
                    if (chk != null & chk.Checked)
                    {
                        sno = Convert.ToDecimal(row.Cells[4].Text);
                    }
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                SqlCommand cmd1 = new SqlCommand(query, con);
                cmd1.Parameters.AddWithValue("@f", DateTime.Now);
                cmd1.Parameters.AddWithValue("@a", ((TextBox)FormView1.FindControl("Award")).Text);
                cmd1.Parameters.AddWithValue("@b", ((DropDownList)FormView1.FindControl("Status")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@c", ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@d", ((DropDownList)FormView1.FindControl("Level")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@e", sno.ToString().Trim());
                cmd1.ExecuteNonQuery();
                con.Close();
                OnUpdated();
            }
            else if(((DropDownList)FormView1.FindControl("level")).SelectedValue.ToString().Trim() == "2" && Convert.ToInt32(((TextBox)FormView1.FindControl("award")).Text) <= 2000)
            {
                string sgno = Session["user"].ToString();
                string query = "UPDATE [suggestions] SET  [sugg_award_amt] = @a,[sugg_type] = @b, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
                Decimal sno = 0;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
                    if (chk != null & chk.Checked)
                    {
                        sno = Convert.ToDecimal(row.Cells[4].Text);
                    }
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                SqlCommand cmd1 = new SqlCommand(query, con);
                cmd1.Parameters.AddWithValue("@f", DateTime.Now);
                cmd1.Parameters.AddWithValue("@a", ((TextBox)FormView1.FindControl("Award")).Text);
                cmd1.Parameters.AddWithValue("@b", ((DropDownList)FormView1.FindControl("Status")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@c", ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@d", ((DropDownList)FormView1.FindControl("Level")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@e", sno.ToString().Trim());
                cmd1.ExecuteNonQuery();
                con.Close();
                OnUpdated();
            }
            else if(((DropDownList)FormView1.FindControl("level")).SelectedValue.ToString().Trim() == "3" && Convert.ToInt32(((TextBox)FormView1.FindControl("award")).Text) <= 10000)
            {

                string sgno = Session["user"].ToString();
                string query = "UPDATE [suggestions] SET  [sugg_award_amt] = @a,[sugg_type] = @b, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
                Decimal sno = 0;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
                    if (chk != null & chk.Checked)
                    {
                        sno = Convert.ToDecimal(row.Cells[4].Text);
                    }
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                SqlCommand cmd1 = new SqlCommand(query, con);
                cmd1.Parameters.AddWithValue("@f", DateTime.Now);
                cmd1.Parameters.AddWithValue("@a", ((TextBox)FormView1.FindControl("Award")).Text);
                cmd1.Parameters.AddWithValue("@b", ((DropDownList)FormView1.FindControl("Status")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@c", ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@d", ((DropDownList)FormView1.FindControl("Level")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@e", sno.ToString().Trim());
                cmd1.ExecuteNonQuery();
                con.Close();
                OnUpdated();
            }
            else if(((DropDownList)FormView1.FindControl("level")).SelectedValue.ToString().Trim() == "4" && Convert.ToInt32(((TextBox)FormView1.FindControl("award")).Text) <= 9900000)
            {

                string sgno = Session["user"].ToString();
                string query = "UPDATE [suggestions] SET  [sugg_award_amt] = @a,[sugg_type] = @b, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
                Decimal sno = 0;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
                    if (chk != null & chk.Checked)
                    {
                        sno = Convert.ToDecimal(row.Cells[4].Text);
                    }
                }

                if (((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value != "TC" && ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value != "TN")
                {
                    query = "UPDATE [suggestions] SET  [sugg_type] = @b,[sugg_last_updated_date] = @f, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
                    MsgBox(((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value, true, "");
                }
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                con.Open();
                SqlCommand cmd1 = new SqlCommand(query, con);
                cmd1.Parameters.AddWithValue("@f", DateTime.Now);
                cmd1.Parameters.AddWithValue("@a", ((TextBox)FormView1.FindControl("Award")).Text);
                cmd1.Parameters.AddWithValue("@b", ((DropDownList)FormView1.FindControl("Status")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@c", ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@d", ((DropDownList)FormView1.FindControl("Level")).SelectedItem.Value);
                cmd1.Parameters.AddWithValue("@e", sno.ToString().Trim());
                cmd1.ExecuteNonQuery();
                con.Close();
                OnUpdated();
            }
            else
            {
                MsgBox("Please Enter Correct Award Value According to the Selected Award Level",true,"");
            }
        }
        else
        {
            string sgno = Session["user"].ToString();
            string query = "UPDATE [suggestions] SET  [sugg_type] = @b,[sugg_last_updated_date] = @f, [sugg_level] = @d,[sugg_award] = @c  ,[sugg_last_updated] = " + sgno + " WHERE [suggno]= @e";
            Decimal sno = 0;
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
                if (chk != null & chk.Checked)
                {
                    sno = Convert.ToDecimal(row.Cells[4].Text);
                }
            }

            
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
            con.Open();
            SqlCommand cmd1 = new SqlCommand(query, con);
            cmd1.Parameters.AddWithValue("@f", DateTime.Now);
            cmd1.Parameters.AddWithValue("@a", ((TextBox)FormView1.FindControl("Award")).Text);
            cmd1.Parameters.AddWithValue("@b", ((DropDownList)FormView1.FindControl("Status")).SelectedItem.Value);
            cmd1.Parameters.AddWithValue("@c", ((DropDownList)FormView1.FindControl("suggaward")).SelectedItem.Value);
            cmd1.Parameters.AddWithValue("@d", ((DropDownList)FormView1.FindControl("Level")).SelectedItem.Value);
            cmd1.Parameters.AddWithValue("@e", sno.ToString().Trim());
            cmd1.ExecuteNonQuery();
            con.Close();
            MsgBoxUpdated("Updated Succesfully!",true,"");
        }
        
        //Response.Redirect("/ied_dash.aspx");
    }
}