using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace CTS
{
    public partial class Login : Page
    {
        #region Fields

        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        #endregion

        #region Page Load

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection();
            }
        }

        #endregion

        #region Database Connection

        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    // Connection successful, but not displaying a message directly here
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    // Consider logging the error instead of displaying it directly to the user
                    ShowAlert("Connection error: " + ex.Message);
                }
            }
        }

        #endregion

        #region Event Handlers

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            string username = txtName.Text.Trim();
            string password = txtPassword.Text.Trim();

            string hashedPassword = Convert.ToBase64String(HashPassword(password));

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT Password, Role FROM [User] WHERE Name=@Name";
                    SqlCommand comm = new SqlCommand(query, conn);
                    comm.Parameters.AddWithValue("@Name", username);

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedPassword = reader["Password"].ToString();
                            bool isAdmin = Convert.ToBoolean(reader["Role"]);

                            if (storedPassword == hashedPassword)
                            {
                                Session["Username"] = username;

                                if (isAdmin)
                                {
                                    Response.Redirect("Main.aspx");
                                }
                                else
                                {
                                   Response.Write("<script>alert('User not Admin. Redirecting to maintenance page');</script>");// if not admin then redirects to maintence
                                    Response.Redirect("Maintenance.aspx");
                                }
                            }
                            else
                            {
                                ShowAlert("Invalid username or password");
                            }
                        }
                        else
                        {
                            ShowAlert("Invalid username or password");
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowAlert("Login Unsuccessful: " + ex.Message);
                }
            }
        }

        #endregion

        #region Helper Methods

        private byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                return sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            }
        }

        private void ShowAlert(string message)
        {
            // This method uses client-side script to show an alert box
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{message}');", true);
        }

        #endregion
    }
}
