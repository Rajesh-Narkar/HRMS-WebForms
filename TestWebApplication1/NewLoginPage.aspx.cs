using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

namespace TestWebApplication1
{
    public partial class NewLoginPage : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string em, pass;
            em = TextBox1.Text;
            pass = TextBox2.Text;

            string q = "exec EmpLoginProc '" + em + "', '" + pass + "' ";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    if (rdr["email"].Equals(em) && rdr["pass"].Equals(pass) && rdr["urole"].Equals("Admin"))
                    {
                        Session["MyUser"] = em;
                        
                        string q1 = "select empid from empdetails where email='" + em + "'";
                        SqlCommand c=new SqlCommand(q1, conn);
                        SqlDataReader dr = c.ExecuteReader();
                        dr.Read();
                        Session["EmpId"] = int.Parse(dr["empid"].ToString());
                        Response.Redirect("AdminViewTickets.aspx");
                    }
                    if (rdr["email"].Equals(em) && rdr["pass"].Equals(pass) && (rdr["urole"].Equals("HR")))
                    {
                        Session["MyUser"] = em;
                        string q1 = "select empid from empdetails where email='" + em + "'";
                        SqlCommand c = new SqlCommand(q1, conn);
                        SqlDataReader dr = c.ExecuteReader();
                        dr.Read();
                        Session["EmpId"] = int.Parse(dr["empid"].ToString());
                        Response.Redirect("HrHome.aspx");

                    }
                    if (rdr["email"].Equals(em) && rdr["pass"].Equals(pass) && (rdr["urole"].Equals("Trainer") || rdr["urole"].Equals("Trainee")))
                    {
                        Session["MyUser"] = em;
                        string q1 = "select empid from empdetails where email='" + em + "'";
                        SqlCommand c = new SqlCommand(q1, conn);
                        SqlDataReader dr = c.ExecuteReader();
                        dr.Read();
                        Session["EmpId"] = int.Parse(dr["empid"].ToString());
                        Response.Redirect("EmpHome.aspx");
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid email or password. Please try again.')</script>");

            }

        }


        protected void Button2_Click(object sender, EventArgs e)
        {
            string enteredOtp = TextBox9.Text;
            string generatedOtp = Session["GeneratedOtp"] as string;

            if (enteredOtp == generatedOtp)
            {
                Label3.Text = "Email verified successfully";
                //Response.Write("<script>alert('Email verified successfully')</script>");
                //ScriptManager.RegisterStartupScript(this, GetType(), "showJoiningForm", "$('#otpModal').modal('hide'); $('#joiningFormModal').modal('show');", true);
            }
            else
            {
                // Show an error message
                //Response.Write("<script>alert('Invalid OTP. Please try again.')</script>");
                Label3.Text = "Invalid OTP. Please try again.";
            }

            string ename, pass, em, role = "Emp", contact;
            string doj = TextBox7.Text;
            int empid = int.Parse(TextBox8.Text);
            ename = TextBox3.Text;
            pass = TextBox5.Text;
            em = TextBox4.Text;
            contact = TextBox6.Text;
            //string designation="";

            //string q = "exec NewEmpProc '" + eid + "','" + ename + "','"+em+"','"+contact+"','"+doj+"','" + pass + "','" + role + "'";
            string q = "insert into empdetails (empid,empname,email ,contact,doj,pass,urole) values ('" + empid + "','" + ename + "','" + em + "','" + contact + "','" + doj + "','" + pass + "','" + role + "')";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            //clear();

            Response.Write("<script>alert('Registration Successfull!')</script>");

        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            string email = TextBox4.Text;
            string generatedOtp = GenerateOtp();
            Session["GeneratedOtp"] = generatedOtp;
            SendOtpEmail(email, generatedOtp);

            // Show a message to the user that OTP has been sent
            Label3.Text = "OTP has been sent to your email.";
            //Response.Write("<script>alert('Registration Successfull!')</script>");
        }
        public string GenerateOtp()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }
        private void SendOtpEmail(string email, string otp)
        {
            MailMessage mail = new MailMessage("rajeshnarkar05@gmail.com", email);
            mail.Subject = "Your OTP Code";
            mail.Body = $"Your OTP code is {otp}";

            SmtpClient client = new SmtpClient("smtp.gmail.com");
            client.Port = 587;
            client.Credentials = new NetworkCredential("rajeshnarkar05@gmail.com", "xcbxsohmepzvwhyd");
            client.EnableSsl = true;

            try
            {
                client.Send(mail);
            }
            catch (Exception ex)
            {
                // Handle exception
                Label3.Text = "Failed to send OTP. Please try again.";
                //Response.Write("<script>alert('Registration Successfull!')</script>");
            }
        }
        /*
        protected void VerifyOtpButton_Click(object sender, EventArgs e)
        {
            string enteredOtp = otpTextBox.Text;
            string generatedOtp = Session["GeneratedOtp"] as string;

            if (enteredOtp == generatedOtp)
            {
                Response.Write("<script>alert('Email verified successfully')</script>");
                ScriptManager.RegisterStartupScript(this, GetType(), "showJoiningForm", "$('#otpModal').modal('hide'); $('#joiningFormModal').modal('show');", true);
            }
            else
            {
                // Show an error message
                otpLabel.Text = "Invalid OTP. Please try again.";
            }
        }*/
        public static void Main(string[] args)
        {

        }

    }
}