using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class update : Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("/dashboard/elevated.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if ((String)Session["session_access_level"] == "1")
        {
            Response.Redirect("dashboard.aspx");
        }

        if (Session["user"] == null)
        {
            Response.Redirect("index.aspx");
        }
    }
    public void MsgBox(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "');", true);
    }
    protected void OnUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        MsgBox("Updated Successfully", true,"");
        ((UpdatePanel)Master.FindControl("DialogBoxPanel")).Update();
        Autofill.SelectCommand = "";
        AsyncForm.Update();
    }
    protected void SrujaniLoader(object sender, EventArgs e)
    {
        string SelectCommand = "";
        string query = "select emp_dept, sugg_level, finyr from suggestions where suggno=" + SrujaniID.Text;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
                {
                    if (Session["depcode"] != null)
                    {
                        if ((Decimal)reader["depcode"] == (Decimal)Session["depcode"])
                        {

                            if ((Int32)reader["level"] == 0)
                            {
                                SelectCommand = "SELECT * FROM [suggestions] WHERE (([finyr] = @finyr) AND ([suggno] = @SrujaniID) AND ([emp_dept]=" + (Decimal)Session["dept_dept_cd"] + "))";
                            }
                            else
                            {
                                MsgBox("You are not authorised to update this Srujani (Achieved Zonal Status)", false, "");
                                SelectCommand = "";
                            }
                        }
                        else
                        {
                            MsgBox("This Srujani belongs to another department", false, "");
                            SelectCommand = "";
                        }
                    }
                    else
                    {
                        SelectCommand = "SELECT * FROM [suggestions] WHERE (([finyr] = @finyr) AND ([suggno] = @SrujaniID))";
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
    }

    protected void SetLevelAccess(object sender, EventArgs e)
    {
        if(FormView1.CurrentMode == FormViewMode.Edit)
        {
            if(Session["dept_dept_cd"] != null)
            {
                DropDownList level = (DropDownList)FormView1.FindControl("sugg_level");
                level.Items.FindByValue("2").Attributes["disabled"] = "true";
                level.Items.FindByValue("3").Attributes["disabled"] = "true";
            }
        }
    }

    
}