using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dashboard_elevated : System.Web.UI.Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
        if (Session["user"] == null)
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("/index.aspx");
        }
        if ((String)Session["session_access_level"] == "1")
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("/dashboard.aspx");
        }
        if ((String)Session["session_access_level"] == "2")
        {
            View.Text = "VIEW ALL SRUJANIS";
        }
    }
}