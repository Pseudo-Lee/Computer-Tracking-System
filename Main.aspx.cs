using System;
using System.Web.UI;

namespace CTS
{
    public partial class Main : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Assuming you have the admin's name stored in a session
                if (Session["Username"] != null)
                {
                    // Display a welcome message with the username
                    string username = Session["Username"].ToString();
                    ShowMessage("Welcome, " + username + "!. What would you like to do today?", true);
                }
                else
                {
                    // If no session exists, redirect to the login page
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            WelcomeLabel.Text = message;
            WelcomePanel.Visible = true;

            // Set inline styles directly for the welcome message panel
            WelcomePanel.Style.Add("background-color", isSuccess ? "#d4edda" : "#f8d7da");
            WelcomePanel.Style.Add("border", isSuccess ? "1px solid #28a745" : "1px solid #dc3545");
            WelcomePanel.Style.Add("color", isSuccess ? "#155724" : "#721c24");

            // Register script to hide the panel after 3 seconds
            ScriptManager.RegisterStartupScript(this, GetType(), "HidePanel", "setTimeout(function() { hidePanel(); }, 3000);", true);
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

        protected void MaintainUsers_Click(object sender, EventArgs e)
        {
            Response.Redirect("Users.aspx");
        }
    }
}
