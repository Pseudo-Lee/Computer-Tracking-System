using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\tshir\source\repos\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";

       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }


        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = TextBoxName.Text.Trim();
                string surname = TextBoxSurname.Text.Trim();
                string idNumber = TextBoxID.Text.Trim();
                string cellphone = TextBoxCellphone.Text.Trim();
                string email = TextBoxEmail.Text.Trim();
                string password = TextBoxPassword.Text.Trim();
                string confirmPassword = TextBoxConfirmPassword.Text.Trim();

                if (password != confirmPassword)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passwords do not match.');", true);
                    return;
                }

                string hashedPassword = HashPassword(password);

                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        string query = "INSERT INTO [dbo].[User] (Name, Surname, IdNumber, Cellphone, Email, Password) VALUES (@Name, @Surname, @IdNumber, @Cellphone, @Email, @Password)";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Surname", surname);
                            cmd.Parameters.AddWithValue("@IdNumber", idNumber);
                            cmd.Parameters.AddWithValue("@Cellphone", cellphone);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@Password", hashedPassword);

                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                string script = "alert('Submitted successfully. Redirecting to login page...'); window.location='Login.aspx';";
                                ClientScript.RegisterStartupScript(this.GetType(), "redirect", script, true);
                                
                            }
        
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sign Up failed. Please try again.');", true);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "');", true);
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
