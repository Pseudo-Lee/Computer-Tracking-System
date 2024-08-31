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
        // Connection string to the database
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection(); // Test the database connection on first load
            }
        }

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
                        //Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            string username = txtName.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Hash the input password
            string hashedPassword = Convert.ToBase64String(HashPassword(password));

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // SQL Command to check if a user with the given username and hashed password exists
                    string query = "SELECT COUNT(1) FROM [User] WHERE Name=@Name AND Password=@Password";
                    SqlCommand comm = new SqlCommand(query, conn);

                    // Adding Parameters to prevent SQL Injection
                    comm.Parameters.AddWithValue("@Name", username);
                    comm.Parameters.AddWithValue("@Password", hashedPassword); // Use the hashed password

                    int count = Convert.ToInt32(comm.ExecuteScalar());

                    if (count == 1)
                    {
                        // Store username in session
                        Session["Username"] = username;

                        // Handle case where user is found
                        //Response.Write("<script>alert('Login Successful');</script>");
                        Response.Redirect("Main.aspx");
                    }
                    else
                    {
                        // User not found
                        Response.Write("<script>alert('Invalid username or password');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle any exceptions that might occur during database operations
                    Response.Write("<script>alert('Login Unsuccessful: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }


        private byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                return sha256.ComputeHash(passwordBytes);
            }
        }

    }
}
