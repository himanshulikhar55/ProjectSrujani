using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class coor_eval_data : System.Web.UI.Page
{
    protected void prevPage(object sender, EventArgs e)
    {
        Response.Redirect("/dashboard.aspx");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Button BackButton = this.Master.FindControl("BackButton") as Button;
        BackButton.Click += new EventHandler(prevPage);
        if (Session["user"] == null || Session["session_access_level"] == null)
        {
            //Redirect to Login if the session is not authenticated
            Response.Redirect("index.aspx");
        }
    }

    protected void InsertIntoDatabase(object sender, EventArgs e)
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
        string query1 = "Update Suggestions SET eval_status = 'E',[sugg_eval_date] = @today_date, eval_decision = @eval_option";
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
            query1 += ",eval_imp_cost = @imp_cost_value";

        if (doi_iai_value.Text != "dd-mm-yyyy" && doi_iai_value.Text != "01-01-1900")
            query1 += ",sugg_imp_date = @doi_aoi_val";

        if (imp_dur > 0)
            query1 += ", sugg_imp_mth = @imp_dur_months";

        if (imp_dur_day > 0)
            query1 += ", sugg_imp_days = @imp_dur_days";

        if (sav_rec > 0)
            query1 += ", savings_recurring = @sav_reccur";

        if (sav_one > 0)
            query1 += ", savings_onetime = @sav_one_time";

        if (sav_int > 0)
            query1 += ", savings_intangible = @sav_intan";

        if (sugg_imp_tpe.ToString().Trim() == "I" || sugg_imp_tpe.ToString().Trim() == "O")
            query1 += ", sugg_imp_type = @sugg_imp_type";

        if (Eval_Comments.Text != "")
            query1 += ", eval_comments = @eval_comments";

        query1 += " Where SuggNo = @sno";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand cmd1 = new SqlCommand(query1, con);
        cmd1.Parameters.AddWithValue("@eval_option", DropDownList1.SelectedValue);
        if (eval_cost > 0)
            cmd1.Parameters.AddWithValue("@imp_cost_value", imp_cost_value.Text);

        if (doi_iai_value.Text != "dd-mm-yyyy" && doi_iai_value.Text != "01-01-1900")
            cmd1.Parameters.AddWithValue("@doi_aoi_val", doi_iai_value.Text);

        if (imp_dur > 0)
            cmd1.Parameters.AddWithValue("@imp_dur_months", imp_dur);

        if (imp_dur_day > 0)
            cmd1.Parameters.AddWithValue("@imp_dur_days", imp_dur_day);

        if (sav_rec > 0)
            cmd1.Parameters.AddWithValue("@sav_reccur", sav_rec);

        if (sav_one > 0)
            cmd1.Parameters.AddWithValue("@sav_one_time", sav_one);

        if (sav_int > 0)
            cmd1.Parameters.AddWithValue("@sav_intang", sav_int);

        if (sugg_imp_tpe.ToString().Trim() == "I" || sugg_imp_tpe.ToString().Trim() == "O")
            cmd1.Parameters.AddWithValue("@sugg_imp_type", sugg_imp_tpe);

        if (Eval_Comments.Text != "")
            cmd1.Parameters.AddWithValue("@eval_comments", Eval_Comments.Text.ToString().Trim());

        cmd1.Parameters.AddWithValue("@sno", sno);
        cmd1.Parameters.AddWithValue("@today_date", DateTime.Now);

        cmd1.ExecuteNonQuery();
        con.Close();
        Response.Redirect("coord_eval_data.aspx");

    }
}