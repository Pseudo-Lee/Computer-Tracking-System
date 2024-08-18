using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class Login : Page
    {
        // Connection string to the database
        private readonly string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\User\OneDrive - North-West University\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf"";Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection();
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
                        Response.Write("<script>alert('Connected');</script>");
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
            string username = txtName.Text;
            string password = txtPassword.Text;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // SQL Command
                    string query = "SELECT COUNT(*) FROM [User] WHERE Name=@Name AND Password=@Password";
                    SqlCommand comm = new SqlCommand(query, conn);

                    // Adding Parameters to prevent SQL Injection
                    comm.Parameters.AddWithValue("@Name", username);
                    comm.Parameters.AddWithValue("@Password", password);

                    int count = Convert.ToInt32(comm.ExecuteScalar());

                    if (count > 0)
                    {
                        // User found, proceed to next step
                        Response.Redirect("MainPage.aspx"); // Redirect to the main page
                    }
                    else
                    {
                        // User not found
                        Response.Write("<script>alert('Login Unsuccessful');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception
                    Response.Write("<script>alert('Error searching for user: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }
    }
}
