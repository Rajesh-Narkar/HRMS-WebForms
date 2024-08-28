using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace TestWebApplication1
{
    public partial class ApplyLeave : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MyUser"] == null)
            {
                // Handle the case where the session is null (user is not logged in)
                Response.Redirect("Login.aspx"); // Redirect to login page or show an error message
                return;
            }

            string email = Session["MyUser"].ToString();
            string conf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(conf);
            conn.Open();

            int empid = getEmployeeId(email);
            Session["EmpID"] = empid; // Store empid in session for later use
        }

        public int getEmployeeId(string email)
        {
            string q = "select empid from empdetails where email=@Email";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                int empid = int.Parse(r["empid"].ToString());
                r.Close(); // Close the reader before returning
                return empid;
            }
            r.Close();
            return 0; // Return 0 or handle the case where the email is not found
        }

        public void insertIntoTable(int empid, string email, DateTime leaveFromDate, DateTime leaveToDate, string reason, int addLeaveDays, int balanceLeaveDays)
        {
            string lstatus = "Pending";
            string q = "INSERT INTO empapplyleave (empid, email, leavefromdate, leavetodate, reason, addleavedays, balleavedays,lstatus) " +
                       "VALUES (@EmpID, @Email, @LeaveFromDate, @LeaveToDate, @Reason, @AddLeaveDays, @BalanceLeaveDays,'"+lstatus+"')";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@EmpID", empid);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@LeaveFromDate", leaveFromDate);
            cmd.Parameters.AddWithValue("@LeaveToDate", leaveToDate);
            cmd.Parameters.AddWithValue("@Reason", reason);
            cmd.Parameters.AddWithValue("@AddLeaveDays", addLeaveDays);
            cmd.Parameters.AddWithValue("@BalanceLeaveDays", balanceLeaveDays);

            cmd.ExecuteNonQuery();
        }

        protected void CalculateButton_Click(object sender, EventArgs e)
        {
            // Parse selected leave period
            DateTime leaveFromDate;
            DateTime leaveToDate;
            Label1.Text = "Balance Leave: 2";

            if (!DateTime.TryParse(TextBoxFrom.Text, out leaveFromDate) || !DateTime.TryParse(TextBoxTo.Text, out leaveToDate))
            {
                resultLabel.Text = "Please select valid dates for 'From Date' and 'To Date'.";
                return;
            }

            if (leaveFromDate > leaveToDate)
            {
                resultLabel.Text = "'From Date' cannot be later than 'To Date'.";
                return;
            }

            // Calculate additional leave days within the selected period
            int totalLeaveDays = CalculateTotalLeaveDays(leaveFromDate, leaveToDate);
            int additionalLeaveDays = CalculateAdditionalLeaveDays(leaveFromDate, leaveToDate);

            // Display result
            resultLabel.Text = "Additional Leave Days: " + additionalLeaveDays.ToString();

            // Check if total leaves exceed 2 and update balance leave
            int standardLeaveDays = 2;
            int balanceLeave = (totalLeaveDays > standardLeaveDays) ? 0 : standardLeaveDays - totalLeaveDays;

            Label1.Text = "Balance Leave: " + balanceLeave.ToString();

            // Store calculated values in session for later use
            Session["LeaveFromDate"] = leaveFromDate;
            Session["LeaveToDate"] = leaveToDate;
            Session["AdditionalLeaveDays"] = additionalLeaveDays;
            Session["BalanceLeave"] = balanceLeave;
            Session["Reason"] = TextBoxReason.Text;
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Retrieve calculated values from session
            DateTime leaveFromDate = (DateTime)Session["LeaveFromDate"];
            DateTime leaveToDate = (DateTime)Session["LeaveToDate"];
            int additionalLeaveDays = (int)Session["AdditionalLeaveDays"];
            int balanceLeave = (int)Session["BalanceLeave"];
            string reason = Session["Reason"].ToString();

            // Get empid and email from session
            int empid = (int)Session["EmpID"];
            string email = Session["MyUser"].ToString();

            // Insert details into the database
            insertIntoTable(empid, email, leaveFromDate, leaveToDate, reason, additionalLeaveDays, balanceLeave);

            // Clear session values to avoid reuse
            Session.Remove("LeaveFromDate");
            Session.Remove("LeaveToDate");
            Session.Remove("AdditionalLeaveDays");
            Session.Remove("BalanceLeave");
            Session.Remove("Reason");

            // Display a confirmation message
            //resultLabel.Text = "Leave details submitted successfully.";
            Response.Write("<script>alert('Leave details submitted successfully.')</script>");
           
        }

        private int CalculateTotalLeaveDays(DateTime leaveFromDate, DateTime leaveToDate)
        {
            int totalLeaveDays = 0;

            for (DateTime date = leaveFromDate; date <= leaveToDate; date = date.AddDays(1))
            {
                if (date.DayOfWeek != DayOfWeek.Saturday && date.DayOfWeek != DayOfWeek.Sunday)
                {
                    totalLeaveDays++;
                }
            }

            return totalLeaveDays;
        }

        private int CalculateAdditionalLeaveDays(DateTime leaveFromDate, DateTime leaveToDate)
        {
            int additionalLeaveDays = 0;
            int currentMonthLeaveDays = 0;
            const int standardLeaveDays = 2;
            DateTime currentMonth = new DateTime(leaveFromDate.Year, leaveFromDate.Month, 1);

            for (DateTime date = leaveFromDate; date <= leaveToDate; date = date.AddDays(1))
            {
                if (date.DayOfWeek != DayOfWeek.Saturday && date.DayOfWeek != DayOfWeek.Sunday)
                {
                    if (date.Month != currentMonth.Month)
                    {
                        // Check if leave days in the previous month exceed the standard leave days
                        if (currentMonthLeaveDays > standardLeaveDays)
                        {
                            additionalLeaveDays += (currentMonthLeaveDays - standardLeaveDays);
                        }
                        // Reset leave days for the new month
                        currentMonthLeaveDays = 0;
                        currentMonth = new DateTime(date.Year, date.Month, 1);
                    }
                    currentMonthLeaveDays++;
                }
            }

            // Check for the last month in the range
            if (currentMonthLeaveDays > standardLeaveDays)
            {
                additionalLeaveDays += (currentMonthLeaveDays - standardLeaveDays);
            }

            return additionalLeaveDays;
        }
    }
}
