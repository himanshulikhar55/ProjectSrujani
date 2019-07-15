using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Master_layout : System.Web.UI.MasterPage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        UserName.Text = GlobalFunctions.RenderEmpName(Session["user"]);
        string designation = "";
        switch((String)Session["session_access_level"])
        {
            case "1":
                designation = "Employee";
                break;
            case "2":
                designation = "Coordinator";
                break;
            case "3":
                designation = "Evaluator";
                break;
            case "4":
                designation = "IED";
                break;
        }
        UserDesignation.Text = designation;
    }
    protected void DestroySession(object sender, EventArgs e)
    {
        Session.RemoveAll();
        Response.Redirect("/index.aspx");
    }
    public void Dialog(string message, bool isSuccessful, string title)
    {
        DialogMessage.Text = message;
        DialogTitle.Text = title;
        DialogBox.Visible = true;
        DialogBox.Focus();
        if (isSuccessful) { 
            DialogBox.CssClass = "success";
        }
        else
        {
            DialogBox.CssClass = "";
        }
        if (title == "")
        {
            if (isSuccessful)
                DialogTitle.Text = "Successful";
            else DialogTitle.Text = "Error";
        }
        DialogBoxPanel.Update();
    }
    protected void CloseDialogBox(object sender, EventArgs e)
    {
        DialogBox.Visible = false;
    }
}