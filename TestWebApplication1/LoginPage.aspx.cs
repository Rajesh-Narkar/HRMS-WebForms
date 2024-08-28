using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

namespace TestWebApplication1
{
    public partial class LoginPage : System.Web.UI.Page
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
            string em = TextBox1.Text;
            string pass = TextBox2.Text;

            string q = "exec EmpLoginProc '" + em + "', '" + pass + "' ";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    if (rdr["email"].Equals(em) && rdr["pass"].Equals(pass) && rdr["urole"].Equals("HR"))
                    {
                        Session["MyUser"] = em;
                        Response.Redirect("HrHome.aspx");

                    }
                    if (rdr["email"].Equals(em) && rdr["pass"].Equals(pass) && rdr["urole"].Equals("Emp"))
                    {
                        Session["MyUser"] = em;
                        Response.Redirect("EmpHome.aspx");
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('Invalid email or password. Please try again.')</script>");

            }
        }

        protected void SendOtpButton_Click(object sender, EventArgs e)
        {
            string email = otpEmailTextBox.Text;
            string generatedOtp = GenerateOtp();
            Session["GeneratedOtp"] = generatedOtp;
            SendOtpEmail(email, generatedOtp);

            // Show a message to the user that OTP has been sent
            otpLabel.Text = "OTP has been sent to your email.";
        }

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
                otpLabel.Text = "Failed to send OTP. Please try again.";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string ename = TextBox3.Text;
            string pass = TextBox5.Text;
            string em = TextBox4.Text;
            string contact = TextBox6.Text;
            string doj = TextBox7.Text;
            int empid = int.Parse(TextBox8.Text);
            string role = "Emp";

            try
            {
                conn.Open();
                string q = "insert into empdetails (empid, empname, email, contact, doj, pass, urole) values (@empid, @ename, @em, @contact, @doj, @pass, @role)";
                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.Parameters.AddWithValue("@empid", empid);
                cmd.Parameters.AddWithValue("@ename", ename);
                cmd.Parameters.AddWithValue("@em", em);
                cmd.Parameters.AddWithValue("@contact", contact);
                cmd.Parameters.AddWithValue("@doj", doj);
                cmd.Parameters.AddWithValue("@pass", pass);
                cmd.Parameters.AddWithValue("@role", role);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Registration Successful!')</script>");
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
