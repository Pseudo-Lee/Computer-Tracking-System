using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TxtbDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                TestDatabaseConnection();
            }
        }
        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Log message for successful connection
                        // Consider using a logging framework instead of alert for production
                        Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Log message for connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }
        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            // Retrieve user input
            string Name = TxtbName.Text.Trim();
            string Surname = TxtbSurname.Text.Trim();
            string IdNumber = TxtbID.Text.Trim();
            string Cellphone = TxtbCellphone.Text.Trim();
            string Email = TxtbEmail.Text.Trim();
            string Password = TxtbPassword.Text.Trim();
            string NewPassword = TxtbConfirmPassword.Text.Trim();// Make sure this is the correct field for password

            // Hash the password
            if (Password ==  NewPassword)// Make sure this is the correct field for password
            {
                string hashedPassword = Convert.ToBase64String(HashPassword(Password)); // Convert to Base64 string



                using (SqlConnection connection = new SqlConnection(connStr))
                {

                    try
                    {
                        

                        string query = "INSERT INTO [User] (Name, Surname, IdNumber, Cellphone, Email, Password) " +
                                       "VALUES (@Name, @Surname, @IdNumber, @Cellphone, @Email, @Password)";


                        using (SqlCommand command = new SqlCommand(query, connection))
                        {

                            // Add parameters to the SQL command
                            command.Parameters.AddWithValue("@Name", Name);
                            command.Parameters.AddWithValue("@Surname", Surname);
                            command.Parameters.AddWithValue("@IdNumber", IdNumber);
                            command.Parameters.AddWithValue("@Cellphone", Cellphone);
                            command.Parameters.AddWithValue("@Email", Email);
                            command.Parameters.AddWithValue("@Password", hashedPassword);

                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Notify success and redirect
                                Response.Write("<script>alert('Registration successful! Redirecting to login...');</script>");
                                Response.Redirect("Login.aspx");
                                connection.Close();
                            }
                            else
                            {
                                // Notify failure
                                Response.Write("<script>alert('Registration failed. Please try again.');</script>");
                            }
                        }
                    }
                    catch (SqlException)
                    {
                        // Display SQL exception message
                        Response.Write($"<script>alert('An error occurred while inserting data);</script>");
                    }

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
