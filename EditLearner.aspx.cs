using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class EditLearner : System.Web.UI.Page
    {
        // Page Load Event Handler
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the page is being loaded for the first time
            if (!IsPostBack)
            {
                // Retrieve LearnerID from query string
                string learnerID = Request.QueryString["LearnerID"];
                if (!string.IsNullOrEmpty(learnerID))
                {
                    // Load learner data from the database and populate controls
                    LoadLearnerData(learnerID);
                }
                messagePanel.Visible = false;
            }
        }

        // Method to load learner data from the database
        private void LoadLearnerData(string learnerID)
        {
            // Define the connection string
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

            // Define the SQL query to fetch learner data
            string query = "SELECT * FROM Student WHERE LearnerID = @LearnerID";

            // Create a connection to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Open the connection
                    conn.Open();

                    // Create a SQL command with the query and connection
                    SqlCommand cmd = new SqlCommand(query, conn);

                    // Add parameter for LearnerID
                    cmd.Parameters.AddWithValue("@LearnerID", learnerID);

                    // Execute the query and retrieve the data
                    SqlDataReader reader = cmd.ExecuteReader();

                    // Check if data is returned
                    if (reader.Read())
                    {
                        // Populate the textboxes with the retrieved data
                        txtFirstName.Text = reader["FirstName"].ToString();
                        txtLastName.Text = reader["LastName"].ToString();
                        txtEmail.Text = reader["EmailAddress"].ToString();
                        txtIdNumber.Text = reader["IdNumber"].ToString();
                        // Uncomment and populate other fields as necessary
                        // txtTelephoneNo.Text = reader["TelephoneNo"].ToString();
                        // txtUniversity.Text = reader["University"].ToString();
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions by displaying an alert to the user
                   // Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                    lblMessage.Text = $"Error:{ex}";
                    
                    messagePanel.Visible = true;
                }
            }
        }

        // Event handler for the Update button click
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Retrieve LearnerID from query string
            string learnerID = Request.QueryString["LearnerID"];
            if (!string.IsNullOrEmpty(learnerID))
            {
                // Update learner data in the database
                UpdateLearnerData(learnerID);
                // Redirect to the ViewLearners page
                
                
             
            }
        }

        // Method to update learner data in the database
        private void UpdateLearnerData(string learnerID)
        {
            // Define the connection string
           
            // Define the SQL query to update learner data
            string query = "UPDATE Student SET FirstName = @FirstName, LastName = @LastName, EmailAddress = @EmailAddress, IdNumber = @IdNumber   WHERE LearnerID = @LearnerID";

            // Create a connection to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Open the connection
                    conn.Open();
                    
                    // Create a SQL command with the query and connection
                    SqlCommand cmd = new SqlCommand(query, conn);

                    // Add parameters for the update operation
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                    cmd.Parameters.AddWithValue("@EmailAddress", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@IdNumber", txtIdNumber.Text);
                    
                    // cmd.Parameters.AddWithValue("@TelephoneNo", txtTelephoneNo.Text);
                    // cmd.Parameters.AddWithValue("@University", txtUniversity.Text);
                    cmd.Parameters.AddWithValue("@LearnerID", learnerID);

                    // Execute the update query
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0) {
                        ShowMessage("Learner updated successfully!", true);
                        Response.Redirect("ViewLearners.aspx");
                        btnCancel.Text = "Return";
                    }
                    else
                    {
                        Response.Write("<script>alert('Error updating');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions by displaying an alert to the user
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        // Event handler for the Cancel button click
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to the ViewLearners page
            Response.Redirect("ViewLearners.aspx");
        }

        // Event handler for the Delete button click
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // Retrieve LearnerID from query string
            string learnerID = Request.QueryString["LearnerID"];
            if (!string.IsNullOrEmpty(learnerID))
            {
                // Define the connection string
                string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

                // Define the SQL query to delete the learner record
                string query = "DELETE FROM Student WHERE LearnerID = @LearnerID";

                // Create a connection to the database
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        // Open the connection
                        conn.Open();

                        // Create a SQL command with the query and connection
                        SqlCommand cmd = new SqlCommand(query, conn);

                        // Add parameter for LearnerID
                        cmd.Parameters.AddWithValue("@LearnerID", learnerID);

                        // Execute the delete query
                        cmd.ExecuteNonQuery();

                        // Redirect to the ViewLearners page
                        btnCancel.Text = "Return";
                        ShowMessage("Learner updated successfully!", true);
                       Response.Redirect("ViewLearners.aspx");
                       
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions by displaying an alert to the user
                        ShowMessage($"Error updating: {ex}", true);
                    }
                }
            }
        }
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            messagePanel.Visible = true; // Show the panel

            // Set the CSS class using Attributes collection
            messagePanel.Attributes["class"] = isSuccess ? "message-panel success" : "message-panel error";
        }

    }
}
