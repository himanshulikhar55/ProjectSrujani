using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


public partial class index : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Visible = false;
        if (Session["user"] != null)
        {
            //Redirect to Dashboard if a session is already active
            Response.Redirect("dashboard.aspx");
        }

        //Toggle Visibility of User Actions included in Master Page
        ((Panel)Master.FindControl("UserDetails")).Visible = false;
        ((Panel)Master.FindControl("Designation")).Visible = false;

        //Stop Caching of Login to fire page_load event on navigating backwards
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }

    protected void login_action_handler (object sender, EventArgs e)
    {
        //Confirm that the details filled in correspond to a registered user
        string query = "select A.password, E.emp_dept from portal_user A JOIN Employee_Master E ON (E.emp_plno = A.plno) WHERE A.plno=" + EmpNoToLogin.Text;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();

        if (reader.HasRows)
        {

            while (reader.Read())
               
                    if (reader["password"].ToString().Trim() == PasswordToLogin.Text)
                    {
                                                        
                            if (EmpType.Text == "2")
                            {
                                string coorquery = "select dept_dept_cd from coordinator where CoorPlno =" + EmpNoToLogin.Text;
                                SqlConnection coorcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                                coorcon.Open();
                                SqlCommand coorcommand = new SqlCommand(coorquery, coorcon);
                                SqlDataReader coorreader = coorcommand.ExecuteReader();
                                if (coorreader.HasRows)
                                    while (coorreader.Read()) { 
                                        Session["dept_dept_cd"] = coorreader["dept_dept_cd"];
                                        Session["session_access_level"] = "2";
                                        Session["user"] = EmpNoToLogin.Text;
                                        Response.Redirect("dashboard.aspx");
                                    }
                                else
                                MsgBox("Username not a Coordinator", false, "");

                                coorcon.Close();
                            }
                            else if (EmpType.Text == "3")
                            {
                                string evalquery = "select dept_dept_cd from Evaluator where EvalPlno =" + EmpNoToLogin.Text;
                                SqlConnection evalcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                                evalcon.Open();
                                SqlCommand evalcommand = new SqlCommand(evalquery, evalcon);
                                SqlDataReader evalreader = evalcommand.ExecuteReader();
                                if (evalreader.HasRows)
                                    while (evalreader.Read()) { 
                                        Session["dept_dept_cd"] = evalreader["dept_dept_cd"];
                                        Session["session_access_level"] = "3";
                                        Session["user"] = EmpNoToLogin.Text;
                                        Response.Redirect("eval_dash.aspx");
                                    }
                                else
                                    MsgBox("Username not a Evaluator", false, "");

                                evalcon.Close();
                            }
                            else if (EmpType.Text == "4")
                            {
                                string iedquery = "select dept_dept_cd from IED where IEDPlno =" + EmpNoToLogin.Text;
                                SqlConnection iedcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
                                iedcon.Open();
                                SqlCommand iedcommand = new SqlCommand(iedquery, iedcon);
                                SqlDataReader iedreader = iedcommand.ExecuteReader();
                                if (iedreader.HasRows)
                                    while (iedreader.Read()) { 
                                        Session["dept_dept_cd"] = iedreader["dept_dept_cd"];
                                        Session["session_access_level"] = "4";
                                        Session["user"] = EmpNoToLogin.Text;
                                        Response.Redirect("dashboard.aspx");
                                    }
                                else
                                    MsgBox("Username not a IED Coordinator", false, "");

                                iedcon.Close();
                            }
                            else if (EmpType.Text == "1")
                            {
                                Session["dept_dept_cd"] = reader["emp_dept"];
                                Session["session_access_level"] = "1";
                                Session["user"] = EmpNoToLogin.Text;
                                Session["asemployee"] = "1";
                                Response.Redirect("dashboard.aspx");
                            }
                            else if (EmpType.Text == "0")
                            {
                               MsgBox("Choose a type of login", false, "");
                            }
                    }
                    else
                    {
                    MsgBox("Wrong Username or Password", false, "");
                }
        }
        else
        {
            MsgBox("This username does not exist", false, "");
        }
        
        con.Close();
    }
    public  void MsgBox(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "');", true);
    }
}