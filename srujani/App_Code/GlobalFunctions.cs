using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Class1
/// </summary>
public class GlobalFunctions
{
    public static string RenderStatus(object value)
    {
        switch (value.ToString())
        {
            case "1": return "Fresh";
            case "2": return "Alive";
            case "3": return "Dormant";
            case "4": return "Closed";
        }
        return value.ToString();
    }
    public static string EvalStatus(object value)
    {
        switch (value.ToString())
        {
            case "P": return "Pending";
            case "E": return "Evaluated";
        }
        return value.ToString();
    }
    public static string RenderEval(object value)
    {
        switch (value.ToString())
        {
            case "E1": return "New Idea";
            case "E2": return "Not New Idea/ Not Accepted";
            case "I6": return "Implementation in Progress";
            case "I7": return "Implemented and found Effective";
            case "I8": return "No Desired Benefit";
            case "I9": return "Can't be Implemented";
        }
        return value.ToString();
    }
    public static string RenderCommittee(object value)
    {
        switch (value.ToString())
        {
            case "0": return "Not evaluated";
            case "41": return "C - Cash";
            case "42": return "CCN - Cash + Cash Now";
            case "43": return "TCL - Gift + Closed";
            case "44": return "RE - Ref to Eval";
            case "45": return "NA - Not Accepted";
            case "46": return "T - Gift";
            case "47": return "TC - Gift + Cash";
            case "48": return "TCN - Gift + Cash Now";
            case "49": return "TSC - Gift + Shirt + Cash";
            case "50": return "O - Others";
        }
        return value.ToString();
    }
    public static string RenderEvalName(object value)
    {
        //MsgBox("This username does not exist", false, "");

        string result = "";
        if (value.ToString() == "")
        {
            result = "Evaluator does not exist";
        }
        else
        {
            string query = "select emp_name from employee_master where emp_plno=" + value.ToString().Trim();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
            con.Open();
            SqlCommand command = new SqlCommand(query, con);
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
                while (reader.Read())
                    result = reader["emp_name"].ToString();
            else result = "Evaluator does not exist";
            con.Close();
        }
        return result;
    }
    public static string RenderEmpName(object value)
    {
        string result = "";
        if (value != null)
        {
            string query = "select emp_name from employee_master where emp_plno = " + value.ToString().Trim();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
            con.Open();
            SqlCommand command = new SqlCommand(query, con);
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
                while (reader.Read())
                    result = reader["emp_name"].ToString();
            else result = "Employee does not exist";
            con.Close();
        }
        else result = "Employee does not exist";

        return result;
    }
    public static string RenderDepName1(object value)
    {
        string result = "";
        string query = "select emp_name from employee_master where emp_plno = "+ value.ToString();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
            while (reader.Read())
                result = reader["emp_name"].ToString();
        else result = "sdgsdgasdfgsdfg";
        con.Close();
        return result;
    }
    public static string RenderDepName(object value)
    {
        string result = "";
        string query = "select dept_name from Dept where dept_dept_cd=" + value.ToString().Trim();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
       con.Open();
        SqlCommand command = new SqlCommand(query, con);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
            while (reader.Read())
                result = reader["dept_name"].ToString();
        else result = "Invalid Dep_Code";
        con.Close();
        return result;
    }
    public static string sha256(string tray)
    {
        System.Security.Cryptography.SHA256Managed crypt = new System.Security.Cryptography.SHA256Managed();
        System.Text.StringBuilder hash = new System.Text.StringBuilder();
        byte[] crypto = crypt.ComputeHash(Encoding.UTF8.GetBytes(tray), 0, Encoding.UTF8.GetByteCount(tray));
        foreach (byte theByte in crypto)
        {
            hash.Append(theByte.ToString("x2"));
        }
        return hash.ToString();
    }
    public static bool isuser(string id)
    {
        string query = "select count(*) from employee_master where emp_plno =" + id;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        int response = Convert.ToInt32(command.ExecuteScalar().ToString().Trim());
        if (response != 0)
            return true;
        else
            return false;
    }
    public static bool issrujani(string suggno)
    {
        string query = "select count(*) from suggestions where Suggno =" + suggno;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SrujaniDBConnectionString1"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand(query, con);
        int response = Convert.ToInt32(command.ExecuteScalar().ToString().Trim());
        if (response != 0)
            return true;
        else
            return false;
    }
    public static string RenderLevel(object value)
    {
        switch (value.ToString())
        {
            case "1": return "Departmental";
            case "2": return "Zonal";
            case "3": return "Apex";
            case "4": return "CEO";
        }
        return value.ToString();
    }

   
}