using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Maintenance : Page
    {
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Any initialization code goes here
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string requestDetails = txtRequest.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(requestDetails))
            {
                ShowMessage("All fields are required.", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = "INSERT INTO MaintenanceRequests (Name, Email, RequestDetails, DateSubmitted) VALUES (@Name, @Email, @RequestDetails, @DateSubmitted)";
                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@RequestDetails", requestDetails);
                    cmd.Parameters.AddWithValue("@DateSubmitted", DateTime.Now);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Your request has been submitted successfully.", true);
                    }
                    else
                    {
                        ShowMessage("There was an issue submitting your request. Please try again.", false);
                    }
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that might occur
                    ShowMessage("An error occurred: " + ex.Message, false);
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to another page or clear the form
            Response.Redirect("Default.aspx"); // Example redirect
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "message-panel success" : "message-panel error";
            messagePanel.Visible = true;
        }
    }
}
