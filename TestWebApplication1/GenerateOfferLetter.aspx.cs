using iTextSharp.text.pdf;
using iTextSharp.text;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;
using System.Data.SqlClient;
using System.Configuration;

namespace TestWebApplication1
{
    public partial class GenerateOfferLetter : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            // Database connection is opened when needed
            string conf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(conf);
            conn.Open();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

                int empid = int.Parse(TextBox4.Text);
                string q = "select * from empdetails where empid=@empid";
                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.Parameters.AddWithValue("@empid", empid);
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                
                    Label1.Text = reader["empname"].ToString();
                    Label3.Text = reader["email"].ToString();
                    Label5.Text = reader["doj"].ToString();
                    //TextBox5.Text = reader["designation"].ToString(); // Populate designation textbox
                    Label4.Text = reader["contact"].ToString();
        
        }
        protected void GenerateButton_Click(object sender, EventArgs e)
        {

                // Retrieve input data
                string empFullName = Label1.Text;
                string email = Label3.Text;
                string dateOfJoining = Label5.Text;
                string empid = TextBox4.Text;
                string designation = TextBox5.Text;
                string contact = Label4.Text;

                string q = "update empdetails set designation='" + designation + "' where email='" + email + "'";
                SqlCommand c = new SqlCommand(q, conn);
                c.ExecuteNonQuery();

                // Generate offer letter content
                string offerLetterContent = $"Dear {empFullName},\n\nCongratulations! We are pleased to offer you the position {designation} with our company. Your date of joining is {dateOfJoining}.\n\nSincerely,\nThe HR Team";

                // Generate PDF
                using (MemoryStream ms = new MemoryStream())
                {
                    Document document = new Document();
                    PdfWriter.GetInstance(document, ms);
                    document.Open();
                    document.Add(new Paragraph(offerLetterContent));
                    document.Close();

                    // Save PDF to server
                    string fileName = $"OfferLetter_{empFullName}_.pdf";
                    string filePath = Server.MapPath("~/OfferLetters/") + fileName;
                    File.WriteAllBytes(filePath, ms.ToArray());

                    // Send email with the offer letter as attachment
                    SendEmail(email, filePath, fileName);
                    try
                    {
                        // Insert PDF file name into the database
                        string query = "INSERT INTO empofferletters (empid, empname, designation, doj, email, contact, offerfname) VALUES (@empid, @empname, @designation, @doj, @email, @contact, @offerfname)";
                        SqlCommand cmd = new SqlCommand(query, conn);

                        cmd.Parameters.AddWithValue("@empname", empFullName);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@empid", empid);
                        cmd.Parameters.AddWithValue("@designation", designation);
                        cmd.Parameters.AddWithValue("@doj", dateOfJoining);
                        cmd.Parameters.AddWithValue("@contact", contact);
                        cmd.Parameters.AddWithValue("@offerfname", fileName);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Offer Letter generated and emailed successfully.')</script>");
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        Response.Write("<script>alert('Offer Letter has already generated.')</script>");
                    }
                }
            
        }

        private void SendEmail(string recipientEmail, string attachmentPath, string attachmentFileName)
        {
            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress("rajeshnarkar05@gmail.com"); // Update with your email address
                mail.To.Add(recipientEmail);
                mail.Subject = "Offer Letter";
                mail.Body = "Please find the attached offer letter.";

                // Attach PDF to email
                Attachment attachment = new Attachment(attachmentPath);
                attachment.Name = attachmentFileName;
                mail.Attachments.Add(attachment);

                using (SmtpClient smtp = new SmtpClient("smtp.gmail.com")) // Update with your SMTP server address
                {
                    smtp.Credentials = new NetworkCredential("rajeshnarkar05@gmail.com", "xcbxsohmepzvwhyd"); // Update with your email credentials
                    smtp.EnableSsl = true;
                    smtp.Port = 587;
                    smtp.Send(mail);
                }
            }
        }

        
    }
}
