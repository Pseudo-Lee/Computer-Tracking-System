using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace CTS
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        
        protected void StudentsBtn_Click(object sender, EventArgs e)
        {
            //redirects to student page
            Response.Redirect("Learners.aspx");
        }

        protected void ComputersBtn_Click(object sender, EventArgs e)
        {
          //redirects to computers page
         Response.Redirect("Computers.aspx");
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}