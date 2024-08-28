using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Net.Mail;
using System.Net;
using System.Web.UI;

namespace TestWebApplication1
{
    public partial class GeneratePaySlip : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {

            string conf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(conf);
            conn.Open();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int eid = int.Parse(TextBox1.Text);

            //string selectedMonth = DropDownList2.SelectedValue; // Get the selected month value
            string selectedMonth = DropDownList2.SelectedValue; // Get the selected month value
            Console.WriteLine("Selected Month: " + selectedMonth); // Check the value in the console
            Response.Write("<script>alert(selectedMonth)</script>");

            //int year = DateTime.Now.Year;
            int year = 2024;// Assuming current year, modify if needed
            string Month = selectedMonth;
            //int month = int.Parse(Month);
            int month = 6;
            int totalDays = GetDaysInMonth(year, month);

            string query = "SELECT * FROM empdetails WHERE empid=@eid";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@eid", eid);
            SqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                Label1.Text = r["empname"].ToString();
                Label2.Text = "Bank Of India";
                Label3.Text = r["contact"].ToString();
                Label4.Text = "141911610000509";
                Label5.Text = r["email"].ToString();
                Label6.Text = getPosition(eid);
                Label7.Text = r["doj"].ToString();
                Label8.Text = "2"; // Assuming this is a static value or should be retrieved similarly to other details
                Label9.Text = "30000"; // Assuming this is a static value or should be retrieved similarly to other details

                Label11.Text = getAddLeaveDays(eid);
                int addLeaveDays = Convert.ToInt32(Label11.Text);

                Label10.Text = totalDays.ToString();

                Session["AddLeaveDays"] = addLeaveDays;
                Session["TotalWorkingDays"] = Label10.Text;
            }
            else
            {
                Response.Write("<script>alert('Employee not found.')</script>");
            }
            r.Close();
            conn.Close();
        }

        protected int GetDaysInMonth(int year, int month)
        {
            // List of days in each month, considering February as 28 days for non-leap years
            int[] daysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

            // Adjust February's days for leap years
            if (DateTime.IsLeapYear(year) && month == 2)
            {
                return 29; // Leap year, February has 29 days
            }
            else
            {
                return daysInMonth[month - 1]; // Subtract 1 from month to access correct index in array
            }
        }


        public string getPosition(int empid)
        {
            string designation = string.Empty;
            string q = "SELECT designation FROM empofferletters WHERE empid = @empid";

            using (SqlCommand cmd = new SqlCommand(q, conn))
            {
                cmd.Parameters.AddWithValue("@empid", empid);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        designation = r["designation"].ToString();
                    }
                    else
                    {
                        designation = "Not found";
                    }
                }
            }

            return designation;
        }

        public string getAddLeaveDays(int empid)
        {
            string addleavedays = "0";
            string q = "SELECT addleavedays FROM empapplyleave WHERE empid = @empid";

            using (SqlCommand cmd = new SqlCommand(q, conn))
            {
                cmd.Parameters.AddWithValue("@empid", empid);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        addleavedays = r["addleavedays"].ToString();
                    }
                }
            }

            return addleavedays;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            int addLeaveDays = Convert.ToInt32(Session["AddLeaveDays"]);
            int totalWorkingDays = Convert.ToInt32(Session["TotalWorkingDays"]);

            decimal monthlySalary = 30000;
            decimal dailySalary = monthlySalary / totalWorkingDays;
            decimal totalDeduction = dailySalary * addLeaveDays;
            decimal finalSalary = monthlySalary - totalDeduction;

            Label12.Text = finalSalary.ToString("C2");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string employeeName = Label1.Text;
            string employeeId = TextBox1.Text;
            string designation = Label6.Text;
            string email = Label5.Text;

            string checkQuery = "SELECT COUNT(*) FROM emppayslip WHERE eid = @employeeId AND month = @month";
            using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
            {
                checkCmd.Parameters.AddWithValue("@employeeId", employeeId);
                checkCmd.Parameters.AddWithValue("@month", DateTime.Now.ToString("MMM"));

                int count = (int)checkCmd.ExecuteScalar();
                if (count > 0)
                {
                    Response.Write("<script>alert('Payslip for this month has already been generated.')</script>");
                    return;
                }
            }

            using (MemoryStream ms = new MemoryStream())
            {
                Document document = new Document(PageSize.A4);
                PdfWriter writer = PdfWriter.GetInstance(document, ms);

                document.Open();
                string logopath = Server.MapPath("Logo/samplelogo.png");
                Image logo = Image.GetInstance(logopath);
                logo.Alignment = Element.ALIGN_CENTER;
                logo.ScaleToFit(100f, 100f);
                document.Add(logo);

                Paragraph title = new Paragraph("Masstech Business Solutions")
                {
                    Alignment = Element.ALIGN_CENTER,
                    Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 36)
                };
                document.Add(title);

                document.Add(new Paragraph("\n"));

                Paragraph payslipTitle = new Paragraph("Payslip for the Month")
                {
                    Alignment = Element.ALIGN_CENTER,
                    Font = FontFactory.GetFont(FontFactory.HELVETICA, 14)
                };
                document.Add(payslipTitle);

                document.Add(new Paragraph("\n"));

                PdfPTable employeeTable = new PdfPTable(4);
                employeeTable.WidthPercentage = 100;
                employeeTable.AddCell("NAME OF EMPLOYEE:");
                employeeTable.AddCell(employeeName);
                employeeTable.AddCell("DESIGNATION:");
                employeeTable.AddCell(designation);
                employeeTable.AddCell("BANK NAME:");
                employeeTable.AddCell("Bank Of India");
                employeeTable.AddCell("EMPLOYEE NO.:");
                employeeTable.AddCell(employeeId);
                employeeTable.AddCell("IFSC CODE:");
                employeeTable.AddCell("BKID0000095");
                employeeTable.AddCell("DATE OF JOINING:");
                employeeTable.AddCell(Label7.Text);
                employeeTable.AddCell("BANK ACCOUNT NO.:");
                employeeTable.AddCell("141911610000509");
                employeeTable.AddCell("DAYS PAID:");
                employeeTable.AddCell(Label10.Text);
                employeeTable.AddCell("PAN:");
                employeeTable.AddCell("BXNPN4060J");
                employeeTable.AddCell("DAYS IN MONTH:");
                employeeTable.AddCell("30");
                employeeTable.AddCell("AADHAR:");
                employeeTable.AddCell("389765453647");
                employeeTable.AddCell("UAN:");
                employeeTable.AddCell("NA");
                document.Add(employeeTable);

                document.Add(new Paragraph("\n"));

                PdfPTable salaryTable = new PdfPTable(4);
                salaryTable.WidthPercentage = 100;
                salaryTable.AddCell("GROSS SALARY");
                salaryTable.AddCell("AMOUNT");
                salaryTable.AddCell("DEDUCTION");
                salaryTable.AddCell("AMOUNT");
                salaryTable.AddCell("Basic");
                salaryTable.AddCell("5000");
                salaryTable.AddCell("PF");
                salaryTable.AddCell("-");
                salaryTable.AddCell("HRA");
                salaryTable.AddCell("2000");
                salaryTable.AddCell("Professional Tax");
                salaryTable.AddCell("200");
                salaryTable.AddCell("Travel Allowance");
                salaryTable.AddCell("1000");
                salaryTable.AddCell("TDS");
                salaryTable.AddCell("-");
                salaryTable.AddCell("Bonus");
                salaryTable.AddCell("1000");
                salaryTable.AddCell("");
                salaryTable.AddCell("");
                salaryTable.AddCell("Special Allowance");
                salaryTable.AddCell("2000");
                salaryTable.AddCell("");
                salaryTable.AddCell("");
                salaryTable.AddCell("Medical Re-imbursement");
                salaryTable.AddCell("1000");
                salaryTable.AddCell("");
                salaryTable.AddCell("");
                salaryTable.AddCell("GROSS SALARY");
                salaryTable.AddCell("15000");
                salaryTable.AddCell("TOTAL DEDUCTION");
                salaryTable.AddCell("200");
                salaryTable.AddCell("NET SALARY PAID");
                salaryTable.AddCell(Label12.Text);
                document.Add(salaryTable);

                document.Add(new Paragraph("\n"));

                Paragraph footer = new Paragraph("This is computerised generated salary slip and does not require authentication")
                {
                    Alignment = Element.ALIGN_CENTER,
                    Font = FontFactory.GetFont(FontFactory.HELVETICA, 10)
                };
                document.Add(footer);

                document.Close();
                writer.Close();

                string monthName = DateTime.Now.ToString("MMMM");
                string fileName = $"Payslip_{employeeId}_{monthName}.pdf";
                string filePath = Server.MapPath("payslips/") + fileName;

                File.WriteAllBytes(filePath, ms.ToArray());

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress("rajeshnarkar05@gmail.com");
                    mail.To.Add(email);
                    mail.Subject = "Payslip";
                    mail.Body = "Please find the attached PDF with your payslip.";

                    Attachment attachment = new Attachment(new MemoryStream(ms.ToArray()), fileName);
                    mail.Attachments.Add(attachment);

                    using (SmtpClient smtp = new SmtpClient("smtp.gmail.com"))
                    {
                        smtp.Credentials = new NetworkCredential("rajeshnarkar05@gmail.com", "xcbxsohmepzvwhyd");
                        smtp.EnableSsl = true;
                        smtp.Port = 587;
                        smtp.Send(mail);
                    }
                }

                string query = "INSERT INTO emppayslip (month, ename, em, eid, fname) VALUES (@month, @employeeName, @employeeEmail, @employeeId, @fileName)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@month", DateTime.Now.ToString("MMM"));
                cmd.Parameters.AddWithValue("@employeeName", employeeName);
                cmd.Parameters.AddWithValue("@employeeEmail", email);
                cmd.Parameters.AddWithValue("@employeeId", employeeId);
                cmd.Parameters.AddWithValue("@fileName", fileName);
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Payslip generated and emailed successfully.')</script>");
            }
        }
    }
}
