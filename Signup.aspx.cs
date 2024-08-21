using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any necessary logic for initial page load can be placed here
        }

        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            // Check if the page is valid (i.e., all validators are passed)
            if (Page.IsValid)
            {
                // Retrieve user input
                string name = TextBoxName.Text.Trim();
                string surname = TextBoxSurname.Text.Trim();
                string idNumber = TextBoxID.Text.Trim();
                string email = TextBoxEmail.Text.Trim();
                string password = TextBoxPassword.Text.Trim();
                string confirmPassword = TextBoxConfirmPassword.Text.Trim();

                // Compare passwords
                if (password != confirmPassword)
                {
                    Response.Write("<script>alert('Passwords do not match.');</script>");
                    return;
                }

                //Hash the password using SHA-256
                string hashedPassword = HashPassword(password);

                // Define connection string
                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\tshir\\source\\repos\\Group13Projects\\Computer-Tracking-System\\App_Data\\CTS.mdf;Integrated Security=True";

                // Insert data into the database
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO [dbo].[User] (Name, Surname, IdNumber, Email, Password) VALUES (@Name, @Surname, @IdNumber, @Email, @Password)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Surname", surname);
                        cmd.Parameters.AddWithValue("@IdNumber", idNumber);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);

                        try
                        {
                            conn.Open();
                            cmd.ExecuteNonQuery();
                            Response.Write("<script>alert('Sign Up successful.');</script>");
                        }
                        catch (Exception ex)
                        {
                            // Log the error and display a friendly message
                            Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
                        }
                    }
                }
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                byte[] hashedBytes = sha256.ComputeHash(passwordBytes);
                return Convert.ToBase64String(hashedBytes);
            }
        }
    }
}
