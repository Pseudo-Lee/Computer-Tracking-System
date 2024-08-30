using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TxtbDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            // Retrieve user input
            string name = TxtbName.Text.Trim();
            string surname = TxtbSurname.Text.Trim();
            string idNumber = TxtbID.Text.Trim();
            string cellphone = TxtbCellphone.Text.Trim();
            string email = TxtbEmail.Text.Trim();
            string password = TxtbPassword.Text.Trim();

            // Hash the password
            string hashedPassword = Convert.ToBase64String(HashPassword(password)); // Convert to Base64 string

            string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";
            string query = "INSERT INTO [User] (Name, Surname, IdNumber, Cellphone, Email, Password) " +
                           "VALUES (@name, @surname ,@idNumber, @cellphone,@email, @password)";

            using (SqlConnection connection = new SqlConnection(connStr))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL command
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@surname", surname);
                    command.Parameters.AddWithValue("@idNumber", idNumber);
                    command.Parameters.AddWithValue("@cellphone", cellphone);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@password", hashedPassword);
                   

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            // Notify success and redirect
                            Response.Write("<script>alert('Registration successful! Redirecting to login...');</script>");
                            Response.Redirect("Login.aspx");
                        }
                        else
                        {
                            // Notify failure
                            Response.Write("<script>alert('Registration failed. Please try again.');</script>");
                        }
                    }
                    catch (SqlException ex)
                    {
                        // Display SQL exception message
                        Response.Write($"<script>alert('An error occurred while inserting data: {ex.Message}');</script>");
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
            }
        }

        private byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                return sha256.ComputeHash(passwordBytes); // Return byte[] for VARBINARY storage
            }
        }
    }
}