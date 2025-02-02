﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;

namespace TestWebApplication1
{
    public partial class ViewOfferLetter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
            string email = "rajeshnarkar05@gmail.com";

        }
        private void BindGridView()
        {
            // Retrieve offer letter metadata from the database
            DataTable dt = GetOfferLetterMetadata();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        private DataTable GetOfferLetterMetadata()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("SrNo");
            dt.Columns.Add("Month");
            dt.Columns.Add("FilePath");

            string email = "rajeshnarkar05@gmail.com";

            if (string.IsNullOrEmpty(email))
            {
                // Handle the case where the email is not available
                // You can log an error or show a message to the user
                // For now, just return an empty DataTable
                return dt;
            }

            using (var connection = new SqlConnection("Data Source=DESKTOP-KCUJHHV;Initial Catalog=MayBatch1;Integrated Security=True"))
            {
                connection.Open();
                var command = new SqlCommand("SELECT srno,generateddate , filepath FROM offerletters WHERE email = @Email", connection);
                command.Parameters.AddWithValue("@Email", email);

                var reader = command.ExecuteReader();
                int srNo = 1;

                while (reader.Read())
                {
                    var row = dt.NewRow();
                    row["SrNo"] = srNo++;
                    row["Month"] = reader.GetDateTime(1).ToString("MMMMyyyy");
                    row["FilePath"] = reader.GetString(2);
                    dt.Rows.Add(row);
                }
            }

            return dt;
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Download" || e.CommandName == "View")
            {
                string filePath = e.CommandArgument.ToString();

                if (e.CommandName == "Download")
                {
                    DownloadFile(filePath);
                }
                else if (e.CommandName == "View")
                {
                    ViewFile(filePath);
                }
            }
        }

        //private void DownloadFile(string filePath)
        //{
        //    FileInfo fileInfo = new FileInfo(Server.MapPath("~/" + filePath));

        //    if (fileInfo.Exists)
        //    {
        //        Response.Clear();
        //        Response.ContentType = "application/pdf";
        //        Response.AddHeader("Content-Disposition", $"attachment; filename={fileInfo.Name}");
        //        Response.WriteFile(fileInfo.FullName);
        //        Response.End();
        //    }
        //}

        private void DownloadFile(string filePath)
        {
            string fullPath = filePath;

            if (File.Exists(fullPath))
            {
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", $"attachment; filename={Path.GetFileName(fullPath)}");
                Response.WriteFile(fullPath);
                Response.End();
            }
        }




        private void ViewFile(string filePath)
        {
            if (File.Exists(filePath))
            {
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", $"inline; filename={Path.GetFileName(filePath)}");
                Response.TransmitFile(filePath);
                Response.End();
            }
            else
            {
                // Handle the case where the file does not exist
                Response.Write("File not found.");
                Response.End();
            }
        }
    }
}