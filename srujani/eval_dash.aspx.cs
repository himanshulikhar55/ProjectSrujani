using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class eval_dash : System.Web.UI.Page
{

    public void MsgBox(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "'); location.href = 'eval_dash.aspx'", true);
        //Response.Redirect("create.aspx");
    }
    public void MsgBoxWrong(string sMessage, bool isSuccessful, string title)
    {
        string msg = "<script type='text/javascript'>";
        msg += "alert('" + sMessage + "');";
        msg += "</script>";
        System.Web.UI.ScriptManager.RegisterStartupScript(this, typeof(string), "Alert", "alert('" + sMessage + "');", true);
        //Response.Redirect("create.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Visible = false;
        if (Session["user"] == null || Session["session_access_level"] == null)
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("index.aspx");
        }
    }
    protected void finyr_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectcommand = "";
        selectcommand = "select distinct suggno from suggestions where eval_plno = @eval_plno AND finyr = @finyr AND eval_status = 'P'";
        SqlDataSource2.SelectCommand = selectcommand;

    }
    protected void InsertIntoDatabase(object sender, EventArgs e)
    {
        DateTime d = DateTime.Now;
        DateTime date = d.Date;
        DateTime d1;
        DateTime.TryParse(doi_iai_value.Text.ToString().Trim(), out d1);
        DateTime d3 = (Convert.ToDateTime(doi_iai_value.Text));
        if (DateTime.Compare(DateTime.Now, d3) < 0)
        {
            MsgBoxWrong("Please Enter Appropriate Date", true, "");
        }
        else
        {
            string query1 = "Update Suggestions SET eval_status = 'E',[sugg_eval_date] = @k, eval_decision = @eval_decision";
            decimal eval_cost = 0;
            decimal imp_dur = 0;
            decimal sav_rec = 0;
            decimal sav_one = 0;
            decimal sav_int = 0;
            decimal imp_dur_day = 0;
            char sugg_imp_tpe;

            Char.TryParse(sugg_imp_type.SelectedValue.ToString().Trim(), out sugg_imp_tpe);
            Decimal.TryParse(imp_dur_mon_value.Text, out imp_dur_day);
            Decimal.TryParse(sav_ot_val.Text, out sav_one);
            Decimal.TryParse(sav_intang_val.Text, out sav_int);
            Decimal.TryParse(sav_recurr_val.Text, out sav_rec);
            Decimal.TryParse(imp_dur_value.Text, out imp_dur);
            Decimal.TryParse(imp_cost_value.Text.ToString(), out eval_cost);
            if (eval_cost > 0)
                query1 += ",eval_imp_cost = @b";

            if (doi_iai_value.Text != "dd-mm-yyyy" && doi_iai_value.Text != "01-01-1900")
            {
                if (DateTime.Compare(DateTime.Now, d3) >= 0)
                    query1 += ",sugg_imp_date = @c";
            }
            if (imp_dur > 0)
                query1 += ", sugg_imp_mth = @d";

            if (imp_dur_day > 0)
                query1 += ", sugg_imp_days = @e";

            if (sav_rec > 0)
                query1 += ", savings_recurring = @f";

            if (sav_one > 0)
                query1 += ", savings_onetime = @g";

            if (sav_int > 0)
                query1 += ", savings_intangible = @h";

            if (sugg_imp_tpe.ToString().Trim() == "I" || sugg_imp_tpe.ToString().Trim() == "O")
                query1 += ", sugg_imp_type = @i";

            if (Eval_Comments.Text != "")
                query1 += ", eval_comments = @j";

            query1 += " Where SuggNo = @z";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
            con.Open();
            SqlCommand cmd1 = new SqlCommand(query1, con);
            cmd1.Parameters.AddWithValue("@eval_decision", DropDownList1.SelectedValue);
            if (eval_cost > 0)
                cmd1.Parameters.AddWithValue("@b", imp_cost_value.Text);

            if (doi_iai_value.Text != "dd-mm-yyyy" && doi_iai_value.Text != "01-01-1900")
                cmd1.Parameters.AddWithValue("@c", doi_iai_value.Text);

            if (imp_dur > 0)
                cmd1.Parameters.AddWithValue("@d", imp_dur);

            if (imp_dur_day > 0)
                cmd1.Parameters.AddWithValue("@e", imp_dur_day);

            if (sav_rec > 0)
                cmd1.Parameters.AddWithValue("@f", sav_rec);

            if (sav_one > 0)
                cmd1.Parameters.AddWithValue("@g", sav_one);

            if (sav_int > 0)
                cmd1.Parameters.AddWithValue("@h", sav_int);

            if (sugg_imp_tpe.ToString().Trim() == "I" || sugg_imp_tpe.ToString().Trim() == "O")
                cmd1.Parameters.AddWithValue("@i", sugg_imp_tpe);

            if (Eval_Comments.Text != "")
                cmd1.Parameters.AddWithValue("@j", Eval_Comments.Text.ToString().Trim());

            cmd1.Parameters.AddWithValue("@z", SuggNo.SelectedValue);
            cmd1.Parameters.AddWithValue("@k", DateTime.Now);

            cmd1.ExecuteNonQuery();
            con.Close();
            Response.Redirect("eval_dash.aspx");
        }
            
    }
}