using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace TestWebApplication1
{
    public partial class ApproveLeave : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["MayBatch1ConnectionString2"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
        }
        protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                string q1;
                string id = e.CommandArgument.ToString();
                string q = "select * from empapplyleave where empid='" + id + "'";

                SqlCommand c = new SqlCommand(q, conn);
                SqlDataReader r = c.ExecuteReader();
                r.Read();
                string leavestatus = r["lstatus"].ToString();
                r.Close();
                //conn.Open();
                if (leavestatus.Equals("Pending"))
                {
                    q1 = "update empapplyleave set lstatus='Approved' where empid='" + id + "'";                  
                    SqlCommand cmd = new SqlCommand(q1, conn);
                    cmd.ExecuteNonQuery();
                    string addl=getAddLeaveDays(id);
                    string q2 = "update empapplyleave set addleavedays='" + addl + "'";
                    SqlCommand c1 = new SqlCommand(q2, conn);
                    c1.ExecuteNonQuery();
                    Response.Redirect("ApproveLeave.aspx");
                }
            }
            if (e.CommandName == "Reject")
            {
                string q1;
                string id = e.CommandArgument.ToString();
                string q = "select * from empapplyleave where empid='" + id + "'";

                SqlCommand c = new SqlCommand(q, conn);
                SqlDataReader r = c.ExecuteReader();
                r.Read();
                string leavestatus = r["lstatus"].ToString();
                r.Close();
                //conn.Open();
                if (leavestatus.Equals("Not Approved"))
                {
                    q1 = "update empapplyleave set lstatus='Not Approved' where empid='" + id + "'";
                    SqlCommand cmd = new SqlCommand(q1, conn);
                    cmd.ExecuteNonQuery();
                    //conn.Close();
                    //conn.Open();
                    string empid=getAddLeaveDays(id);
                    string q2 = "update empapplyleave set addleavedays='0' where empid='" + empid +"'";
                    SqlCommand c1 = new SqlCommand(q2, conn);
                    c1.ExecuteNonQuery();
                    Response.Redirect("ApproveLeave.aspx");
                }
            }
            
        }
        public string getAddLeaveDays(string empid)
        {
            int eid = int.Parse(empid);
            string q = "select addleavedays from empapplyleave where empid='" + eid + "'";
            SqlCommand cmd=new SqlCommand(q, conn);
            SqlDataReader r=cmd.ExecuteReader();
            r.Read();
            string al = r["addleavedays"].ToString();
            return al;
        }
    }
}