using System;
using System.IO;
using System.Web;

namespace TestWebApplication1
{
    public partial class ViewPdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string filename = Request.QueryString["filename"];
            if (!string.IsNullOrEmpty(filename))
            {
                string filePath = Server.MapPath("OfferLetters/") + filename;
                if (File.Exists(filePath))
                {
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "inline;filename=" + filename);
                    Response.WriteFile(filePath);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    Response.Write("Offer Letter file not found.");
                }
            }
            else
            {
                Response.Write("Invalid request.");
            }
        }
    }
}
