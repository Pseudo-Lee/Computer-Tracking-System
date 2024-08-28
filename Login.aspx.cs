using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


namespace CTS
{
    public partial class Login : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


            // Connection string to the database
            //private readonly string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\leseg\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security=True";

            //private  string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\GUSTAV\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf"";Integrated Security=True";
        }
       private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\User\OneDrive - North-West University\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf"";Integrated Security=True";
      

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

            // Always check if it's a postback outside of the main logic.
            if (!IsPostBack)
            {
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

<<<<<<< HEAD
                        // SQL Command
                        string query = "SELECT COUNT(1) FROM [dbo].[User] WHERE Name=@Name AND Password=@Password";
                        SqlCommand comm = new SqlCommand(query, conn);
=======
                    // SQL Command
                    string query = "SELECT COUNT(1) FROM [User] WHERE Name=@Name AND Password=@Password";
                    SqlCommand comm = new SqlCommand(query, conn);
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96

                    // Adding Parameters to prevent SQL Injection
                    comm.Parameters.AddWithValue("@Name", username);
                    comm.Parameters.AddWithValue("@Password", password);

                    int count = Convert.ToInt32(comm.ExecuteScalar());

                    if (count == 1)
                    {
                        // Handle case where user is found
                        Response.Write("<script>alert('Login Successful');</script>");
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

    }

}
