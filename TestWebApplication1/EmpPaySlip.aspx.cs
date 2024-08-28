using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestWebApplication1
{
    public partial class EmpPaySlip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View" || e.CommandName == "Download")
            {
                string payslipFilename = e.CommandArgument.ToString();

                if (e.CommandName == "View")
                {
                    ViewPayslip(payslipFilename);
                }
                else if (e.CommandName == "Download")
                {
                    DownloadPayslip(payslipFilename);
                }
            }
        }

        private void ViewPayslip(string payslipFilename)
        {
            if (!string.IsNullOrEmpty(payslipFilename))
            {
                string filePath = Server.MapPath("~/Payslips/") + payslipFilename;

                if (File.Exists(filePath))
                {
                    string url = $"ViewPayslipPdf.aspx?filename={HttpUtility.UrlEncode(payslipFilename)}";
                    Response.Redirect(url);
                }
                else
                {
                    Response.Write("Payslip file not found.");
                }
            }
            else
            {
                Response.Write("Payslip not found in database.");
            }
        }

        private void DownloadPayslip(string payslipFilename)
        {
            if (!string.IsNullOrEmpty(payslipFilename))
            {
                string filePath = Server.MapPath("~/Payslips/") + payslipFilename;

                if (File.Exists(filePath))
                {
                    try
                    {
                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", $"attachment;filename={payslipFilename}");
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
                    Response.Write("Payslip file not found.");
                }
            }
            else
            {
                Response.Write("Payslip not found in database.");
            }
        }
    }
}
