using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestWebApplication1
{
    public partial class ViewPayslipPdf : System.Web.UI.Page
    {
        protected string PdfUrl;

        protected void Page_Load(object sender, EventArgs e)
        {
            string filename = Request.QueryString["filename"];
            if (!string.IsNullOrEmpty(filename))
            {
                string filePath = Server.MapPath("~/Payslips/") + filename;
                PdfUrl = ResolveUrl("~/Payslips/" + filename);
            }
            else
            {
                Response.Write("Payslip file not specified.");
            }
        }
    }
}