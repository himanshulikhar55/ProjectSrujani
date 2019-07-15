using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;

public partial class view : System.Web.UI.Page
{
    protected string PreviousRoute = "";
    protected string SelectCommand = "";
    public void PrintDataInView(object sender, EventArgs e)
    {
        GridView1.AllowPaging = false;
        GridView1.DataBind();
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GridView1.RenderControl(hw);
        string gridHTML = sw.ToString().Replace("\"", "'")
            .Replace(System.Environment.NewLine, "");
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload = new function(){");
        sb.Append("var printWin = window.open('', '', 'left=0");
        sb.Append(",top=0,width=1000,height=600,status=0');");
        sb.Append("printWin.document.write(\"");
        sb.Append(gridHTML);
        sb.Append("\");");
        sb.Append("printWin.document.close();");
        sb.Append("printWin.focus();");
        sb.Append("printWin.print();");
        sb.Append("printWin.close();};");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());
        GridView1.AllowPaging = true;
        GridView1.DataBind();
    }
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect(PreviousRoute);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if((String)Session["session_access_level"] != "1")
        {
            finyrdrop.Visible = false;
        }
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
        if (Request["emp"] != null)
        {
            Panel.Visible = false;
            if (Request["id"] != null)
            {
                SelectCommand = "select * from [suggestions] where [suggno]=" + (String)Request["id"];
                PreviousRoute = "/index.aspx";
                if (Session["user"] == null)
                    ((Panel)Master.FindControl("UserDetails")).Visible = false;
            }
            else 
            {
                if (Session["user"] != null)
                {
                    if((String)Session["user"] == Request["emp"])
                    {
                        SelectCommand = "select * from [suggestions] where [emp_plno]=" + (String)Session["user"];
                        PreviousRoute = "/dashboard.aspx";
                    }
                    else
                    {
                        Response.Redirect("dashboard.aspx");
                    }
                }
                else
                {
                    Response.Redirect("index.aspx");
                }
            }
        }
        else
        {
            if((String)Session["session_access_level"] == "1" || Session["user"] == null)
            {
                Response.Redirect("dashboard.aspx");
            }
            if ((String)Session["session_access_level"] == "2")
            {
                emp_dept.ClearSelection();
                emp_dept.SelectedValue = Session["dept_dept_cd"].ToString();
                emp_dept.Enabled = false;
            }
            PreviousRoute = "/dashboard.aspx";
            SelectCommand = "SELECT * FROM [suggestions] WHERE ((([finyr]=@finyr) OR (@finyr IS NULL)) AND (([emp_dept]=@emp_dept) OR (@emp_dept IS NULL)) AND (([sugg_level]=@sugg_level) OR (@sugg_level IS NULL)))";
        }
        SqlDataSource1.SelectCommand = SelectCommand;
    }

    protected void PrintThisPage(object sender, EventArgs e)
    {
        Decimal sno = 0;
        foreach (GridViewRow row in GridView1.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("ChkSelect");
            if (chk != null & chk.Checked)
            {
                sno = Convert.ToDecimal(row.Cells[1].Text);
            }
        }
        Response.Redirect("/Default2.aspx?suggno=" + sno.ToString().Trim());

    }

    protected void Fin(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT * FROM [suggestions] WHERE ((([finyr]=@finyrdrop) OR (@finyrdrop IS NULL)) AND (([emp_dept]=@emp_dept) OR (@emp_dept IS NULL)) AND (([sugg_level]=@sugg_level) OR (@sugg_level IS NULL)) AND emp_plno ="+ (String)Session["user"] +") ORDER BY suggno desc;";
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
}