using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Visible = false;
        if (Session["user"] == null || Session["session_access_level"] == null)
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("index.aspx");
        }
        else
        {
            View.NavigateUrl = "/view.aspx?emp=" + (String)Session["user"];
            if ((string)Session["session_access_level"] == "1")
            {
                HyperLink1.Visible = false;
                Elevator.Visible = false;
                AssignEval.Visible = false;
                Process.Visible = false;
                EvalRoleAssignment.Visible = false;
                HyperLink2.Visible = false;
                HyperLink3.Visible = false;
            }
            else if ((String)Session["session_access_level"] == "3")
            {
                HyperLink1.Visible = false;
                View.Visible = false;
                newsur.Visible = false;
                EvalRoleAssignment.Visible = false;
                AssignEval.Visible = false;
                Process.Visible = false;
                HyperLink2.Visible = false;
                HyperLink3.Visible = false;

            }
            else if ((string)Session["session_access_level"] == "2")
            {
                View.Visible = false;
                Elevator.Visible = false;
                HyperLink2.Visible = false;
                HyperLink3.Visible = false;
            }
            else if ((string)Session["session_access_level"] == "4")
            {
                HyperLink1.Visible = false;
                View.Visible = false;
                newsur.Visible = false;
                EvalRoleAssignment.Visible = false;
                AssignEval.Visible = false;
                Process.Visible = false;
                Elevator.Visible = false;
            }
        }
    }
}