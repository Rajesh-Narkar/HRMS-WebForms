using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace TestWebApplication1
{
    public partial class RaiseTicket : System.Web.UI.Page
    {
        SqlConnection conn;
        string raiseTo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
            
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRole = DropDownList1.SelectedValue;
            PopulateRaiseToDropdown(selectedRole);
        }

        private void PopulateRaiseToDropdown(string role)
        {
            
            string query = "SELECT empname FROM empdetails WHERE urole = @role";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@role", role);
            SqlDataReader reader = cmd.ExecuteReader();
            DropDownList2.Items.Clear();
            DropDownList2.Items.Add(new ListItem("Select Person", ""));
            while (reader.Read())
            {
                DropDownList2.Items.Add(new ListItem(reader["empname"].ToString()));
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string role, ticket, attachment;
            role=DropDownList1.SelectedValue.ToString();    
            //raiseTo = DropDownList2.SelectedValue.ToString();
            ticket = TextBox1.Text;
            raiseTo=DropDownList2.SelectedValue.ToString();
            FileUpload1.SaveAs(Server.MapPath("~/TicketAttachments/") + Path.GetFileName(FileUpload1.FileName));
            //attachment = "TicketAttachments/" + Path.GetFileName(FileUpload1.FileName);
            attachment = Path.GetFileName(FileUpload1.FileName);
            string raisedate = DateTime.Now.ToString();
            string email =Session["MyUser"].ToString();
            int empid = int.Parse(Session["EmpId"].ToString());
            int raiseToEmpId = getEmpID(email);
            //string raiseTo = getEmpName(raiseToEmpId);
            role = getRole(email);
            string q = "insert into raiseTicket (empid,empname,urole,ticket,attachment,raisedate,tktstatus,raiseTo,raiseToEmpId) values ('" + empid + "','" + email + "','" + role + "','" + ticket + "','" + attachment + "','"+raisedate+ "','Pending','"+raiseTo+"','"+raiseToEmpId+"')";
            SqlCommand cmd=new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Ticket raised Successfully')</script>");

        }
        public string getRole(string email)
        {
            string q = "select urole from empdetails where email='" + email + "'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader r = cmd.ExecuteReader();
            r.Read();
            string role = r["urole"].ToString();
            return role;
        }
        public int getEmpID(string email)
        {
            string q = "select empid from empdetails where empname='" + raiseTo + "'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader r = cmd.ExecuteReader();
            r.Read();
            int empid = int.Parse(r["empid"].ToString());
            return empid;
        }
        //public string getEmpName(int empid)
        //{
        //    string q = "select empname from empdetails where empid='" + empid + "'";
        //    SqlCommand cmd = new SqlCommand(q, conn);
        //    SqlDataReader r = cmd.ExecuteReader();
        //    r.Read();
        //    string empname = r["empname"].ToString();
        //    return empname;
        //}
    }
}