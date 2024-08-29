using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace CTS
{
    public partial class ForgotPassword : Page
    {
        private readonly string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\leseg\source\repos\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void UpdatePasswordBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string userName = txtUserName.Text.Trim();
                string idNumber = txtIdNum.Text.Trim();
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();
                string confirmPassword = txtConfirmPassword.Text.Trim();

                // Validate that passwords match
                if (password != confirmPassword)
                {
                    LblUpdatedPS.Text = "Passwords do not match.";
                    return;
                }
                else if(password == confirmPassword)
                {
                    LblUpdatedPS.Text = "password reset sucessfull!!";
                }

                // Hash the password
                string hashedPassword = Convert.ToBase64String(HashPassword(password));

                // SQL Query to update the password
                string query = "UPDATE [User] SET Password = @Password WHERE UserName = @UserName AND IdNumber = @IdNumber AND Email = @Email";

                using (SqlConnection connection = new SqlConnection(connStr))
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL command
                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@IdNumber", idNumber);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", hashedPassword);

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            LblUpdatedPS.Text = "Password reset successful!";
                        }
                        else
                        {
                            LblUpdatedPS.Text = "Password reset failed. Please check your details and try again.";
                        }
                    }
                    catch (SqlException ex)
                    {
                        LblUpdatedPS.Text = $"An error occurred: {ex.Message}";
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
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96
