using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace TestWebApplication1
{
    public partial class AdminViewTickets : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            conn = new SqlConnection(cnf);
            conn.Open();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
           
            // SQL query to select all tickets
            string query = "SELECT [ticketid], [empid], [empname], [urole], [ticket], [raisedate], [solution], [tktstatus], [raiseTo], [raiseToEmpId] FROM [raiseTicket]";

           
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        // Create the CSV file content
                        StringBuilder csvContent = new StringBuilder();

                        // Add the header row
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            csvContent.Append(dt.Columns[i]);
                            if (i < dt.Columns.Count - 1)
                                csvContent.Append(",");
                        }
                        csvContent.AppendLine();

                        // Add the data rows
                        foreach (DataRow row in dt.Rows)
                        {
                            for (int i = 0; i < dt.Columns.Count; i++)
                            {
                                csvContent.Append(row[i].ToString().Replace(",", ";")); // Replace commas to prevent CSV issues
                                if (i < dt.Columns.Count - 1)
                                    csvContent.Append(",");
                            }
                            csvContent.AppendLine();
                        }

                        // Write the CSV content to the response
                        Response.Clear();
                        Response.Buffer = true;
                        Response.AddHeader("content-disposition", "attachment;filename=Tickets.csv");
                        Response.Charset = "";
                        Response.ContentType = "application/text";
                        Response.Output.Write(csvContent.ToString());
                        Response.Flush();
                        Response.End();
                    }
                }
            
        }
    }
}
