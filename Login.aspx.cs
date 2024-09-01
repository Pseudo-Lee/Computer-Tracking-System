using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Login : Page
    {
        #region Fields

        // Connection string to the database
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        #endregion

        #region Page Load

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection(); // Test the database connection on the first load
            }
        }

        #endregion

        #region Database Connection

        // Method to test the database connection
        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Connection successful
                        // Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        #endregion

        #region Event Handlers

        // Event handler for the login button click
        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            // Retrieve user input from textboxes
            string username = txtName.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Hash the input password for secure comparison
            string hashedPassword = Convert.ToBase64String(HashPassword(password));

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // SQL Command to check if a user with the given username and hashed password exists
                    string query = "SELECT Password, Role FROM [User] WHERE Name=@Name";
                    SqlCommand comm = new SqlCommand(query, conn);

                    // Adding Parameters to prevent SQL Injection
                    comm.Parameters.AddWithValue("@Name", username);

                    // Execute the query and read the results
                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Retrieve stored password and role from the database
                            string storedPassword = reader["Password"].ToString();
                            bool isAdmin = Convert.ToBoolean(reader["Role"]);

                            // Check if the provided password matches the stored hashed password
                            if (storedPassword == hashedPassword)
                            {
                                // Store the username in the session
                                Session["Username"] = username;

                                // Redirect based on the user's role
                                if (isAdmin)
                                {
                                    Response.Redirect("Main.aspx"); // Admin user
                                }
                                else
                                {
                                    Response.Redirect("Maintenance.aspx"); // Non-admin user
                                }
                            }
                            else
                            {
                                // Password is incorrect
                                Response.Write("<script>alert('Invalid username or password');</script>");
                            }
                        }
                        else
                        {
                            // User not found
                            Response.Write("<script>alert('Invalid username or password');</script>");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that might occur during database operations
                    Response.Write("<script>alert('Login Unsuccessful: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        #endregion

        #region Helper Methods

        // Method to hash a password using SHA-256
        private byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                return sha256.ComputeHash(passwordBytes);
            }
        }

        #endregion
    }
}
