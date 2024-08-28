using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace TestWebApplication1
{
    public partial class ViewTicketAttachment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string filename = Request.QueryString["filename"];
            if (!string.IsNullOrEmpty(filename))
            {
                string filePath = Server.MapPath("TicketAttachments/") + filename;
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
                    Response.Write("Attachment file not found.");
                }
            }
            else
            {
                Response.Write("Invalid request.");
            }

        }
    }
}