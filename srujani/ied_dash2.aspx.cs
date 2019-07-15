using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class ieddash2 : System.Web.UI.Page
{

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
 }