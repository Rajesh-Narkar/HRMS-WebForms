using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestWebApplication1
{
    public partial class Emp : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = Session["MyUser"].ToString();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Session.Abandon(); //it will destroy all the session
            Response.Redirect("NewLoginPage.aspx");
        }
    }
}