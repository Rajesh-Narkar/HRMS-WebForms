using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web;

namespace TestWebApplication1
{
    public partial class ViewTicket : Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            
                string cnf = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
                conn = new SqlConnection(cnf);
                conn.Open();
            
        }

        protected void GridView1_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Attachment")
            {
                string attachmentUrl = e.CommandArgument.ToString();
                DownloadAttachment(attachmentUrl);
            }
            else if (e.CommandName == "Action")
            {
                string ticketId = e.CommandArgument.ToString();
                ticketIdValue.Text = ticketId;
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "$('#closeTicket').modal('show');", true);
            }
        }

        private void DownloadAttachment(string attachmentUrl)
        {

            if (!string.IsNullOrEmpty(attachmentUrl))
            {
                string url = $"ViewTicketAttachment.aspx?filename={HttpUtility.UrlEncode(attachmentUrl)}";
                Response.Redirect(url);
            }
            //if (!string.IsNullOrEmpty(attachmentUrl))
            //{
            //    string filePath = Server.MapPath("TicketAttachments/") + attachmentUrl;

            //    if (File.Exists(filePath))
            //    {
            //        try
            //        {
            //            Response.Clear();
            //            Response.ContentType = "application/octet-stream";
            //            Response.AddHeader("Content-Disposition", $"attachment; filename={Path.GetFileName(filePath)}");
            //            Response.TransmitFile(filePath);
            //            Response.Flush();
            //        }
            //        catch (Exception ex)
            //        {
            //            Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            //        }
            //        finally
            //        {
            //            Response.End();
            //        }
            //    }
            else
            {
                Response.Write("<script>alert('File not found.');</script>");
            }
            //else
            //{
            //    Response.Write("<script>alert('Attachment URL is missing.');</script>");
            //}
        }
           
        protected void Button3_Click(object sender, EventArgs e)
        {
            string solution = TextBox1.Text;
            string ticketId = ticketIdValue.Text;

            string updateQuery = "UPDATE raiseTicket SET solution = @solution,tktstatus='Closed' WHERE ticketid = @ticketid";
            SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
            updateCmd.Parameters.AddWithValue("@solution", solution);
            updateCmd.Parameters.AddWithValue("@ticketid", ticketId);
            updateCmd.ExecuteNonQuery();

            string query = "DELETE FROM raiseTicket WHERE ticketid = @ticketid";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@ticketid", ticketId);

            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Ticket closed and removed successfully!');</script>");

            ScriptManager.RegisterStartupScript(this, GetType(), "HideModal", "$('#closeTicket').modal('hide');", true);
            GridView1.DataBind(); // Refresh the GridView to reflect the changes
        }
    }
}
