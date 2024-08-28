using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestWebApplication1
{
    public partial class EmpOfferLetter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View" || e.CommandName == "Download")
            {
                string offerLetterFilename = e.CommandArgument.ToString();

                if (e.CommandName == "View")
                {
                    ViewOfferLetter(offerLetterFilename);
                }
                else if (e.CommandName == "Download")
                {
                    DownloadOfferLetter(offerLetterFilename);
                }
            }
        }

        private void ViewOfferLetter(string offerLetterFilename)
        {
            if (!string.IsNullOrEmpty(offerLetterFilename))
            {
                string url = $"ViewPdf.aspx?filename={HttpUtility.UrlEncode(offerLetterFilename)}";
                Response.Redirect(url);
            }
            else
            {
                Response.Write("Offer Letter not found in database.");
            }
        }

        private void DownloadOfferLetter(string offerLetterFilename)
        {
            if (!string.IsNullOrEmpty(offerLetterFilename))
            {
                string filePath = Server.MapPath("~/OfferLetters/") + offerLetterFilename;

                if (File.Exists(filePath))
                {
                    try
                    {
                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", $"attachment;filename={offerLetterFilename}");
                        Response.WriteFile(filePath);
                        Response.Flush();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }
                    finally
                    {
                        Response.End();
                    }
                }
                else
                {
                    Response.Write("Offer Letter file not found.");
                }
            }
            else
            {
                Response.Write("Offer Letter not found in database.");
            }
        }
    }
}
