using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class Login : Page
    {
        // Connection string to the database
<<<<<<< HEAD
        private readonly string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\leseg\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security=True";
=======
        private  string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\GUSTAV\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf"";Integrated Security=True";

>>>>>>> 32b8c2e223ec91a00937f643859d426086fa7afe
        protected void Page_Load(object sender, EventArgs e)
        {

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
            if (IsPostBack)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try {
                        conn.Open();

                        // SQL Command
                        string query = "SELECT COUNT(1) FROM [User] WHERE Name=@Name AND Password=@Password";
                        SqlCommand comm = new SqlCommand(query, conn);

                        // Adding Parameters to prevent SQL Injection
                        // Adding Parameters to prevent SQL Injection
                        comm.Parameters.AddWithValue("@Name", username);
                        comm.Parameters.AddWithValue("@Password", password);
                        SqlDataAdapter da = new SqlDataAdapter(comm);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        if (ds.Tables.Count == 0)
                        {
                            // Handle case where no table or no rows are found
                            Response.Write("<script>alert('Invalid user or password');</script>");
                        }
                        else if (ds.Tables.Count == 1)
                        {
                            // Handle case where user is found
                            Response.Write("<script>alert('Login Successful');</script>");

                            Response.Redirect("Main.aspx");
                        }
                        else
                        {
                        }
                        int count = Convert.ToInt32(comm.ExecuteScalar());

                        /* if (count >= 1)
                         {
                             Response.Write("Redirecting to Main.aspx");  // Temporary debugging line
                             Response.Redirect("Main.aspx");

                         }
                         else
                         {
                             // User not found
                             Response.Write("<script>alert('Login Unsuccessful');</script>");
                         }*/
                    }
                    catch
                    {
                        Response.Write("<script>alert('Login Unsuccessful');</script>");
                    }


                }
            }
        }

    }
}
