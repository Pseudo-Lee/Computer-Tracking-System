using System;
using System.Web.UI;
//using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Main1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Learners.aspx");
        }

        protected void MtnCompBtn_Click(object sender, EventArgs e)
        {
            // Your code here
        }
    }
}
