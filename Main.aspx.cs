using System;
using System.Web.UI;
//using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Main: Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

       

        protected void StudentsBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Learners.aspx");
        }

        protected void ComputersBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Computers.aspx");
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
