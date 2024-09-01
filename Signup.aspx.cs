using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace CTS
{
    public partial class SignUp : Page
    {
        #region Connection String
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";
        #endregion

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set the date textbox to the current date
                TxtbDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                // Test the database connection when the page loads
                TestDatabaseConnection();
            }
        }
        #endregion

        #region Database Connection Test
        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Notify successful connection
                        Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Notify connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }
        #endregion

        #region Sign-Up Button Click Event
        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            // Retrieve user input from form fields
            string Name = TxtbName.Text.Trim();
            string Surname = TxtbSurname.Text.Trim();
            string IdNumber = TxtbID.Text.Trim();
            string Cellphone = TxtbCellphone.Text.Trim();
            string Email = TxtbEmail.Text.Trim();
            string Password = TxtbPassword.Text.Trim();
            string NewPassword = TxtbConfirmPassword.Text.Trim();

            // Check if passwords match
            if (Password != NewPassword)
            {
                LblComment.Text = "Passwords do not match!";
                return;
            }

            // Check for duplication in Email, IdNumber, and Cellphone
            if (IsDuplicateUser(Email, IdNumber, Cellphone))
            {
                return; // Stop further execution if duplicates are found
            }

            // Hash the password for secure storage
            string hashedPassword = Convert.ToBase64String(HashPassword(Password));

            // Insert the new user into the database
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                try
                {
                    string query = "INSERT INTO [User] (Name, Surname, IdNumber, Cellphone, Email, Password,Role) " +
                                   "VALUES (@Name, @Surname, @IdNumber, @Cellphone, @Email, @Password,@Role)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the SQL command
                        command.Parameters.AddWithValue("@Name", Name);
                        command.Parameters.AddWithValue("@Surname", Surname);
                        command.Parameters.AddWithValue("@IdNumber", IdNumber);
                        command.Parameters.AddWithValue("@Cellphone", Cellphone);
                        command.Parameters.AddWithValue("@Email", Email);
                        command.Parameters.AddWithValue("@Password", hashedPassword);
                        command.Parameters.AddWithValue("@Role", 0);// Role is False by default

                        // Open the connection and execute the command
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Notify success and redirect to the login page
                            Response.Write("<script>alert('Registration successful! Redirecting to login...');</script>");
                            Response.Redirect("Login.aspx");
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
                    Response.Write("<script>alert('An error occurred while inserting data.');</script>");
                }
            }
        }
        #endregion

        #region Duplicate User Check
        private bool IsDuplicateUser(string email, string idNumber, string cellphone)
        {
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                try
                {
                    // Query to check for duplicate Email, IdNumber, or Cellphone
                    string query = "SELECT COUNT(*) FROM [User] WHERE Email = @Email OR IdNumber = @IdNumber OR Cellphone = @Cellphone";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@IdNumber", idNumber);
                        command.Parameters.AddWithValue("@Cellphone", cellphone);

                        // Open connection and execute the query
                        connection.Open();
                        int count = (int)command.ExecuteScalar();

                        // Check which field is duplicated and set the appropriate message
                        if (count > 0)
                        {
                            if (IsEmailDuplicate(email))
                            {
                                LblComment.Text = "Email already exists!";
                            }
                            else if (IsIdNumberDuplicate(idNumber))
                            {
                                LblComment.Text = "ID Number already exists!";
                            }
                            else if (IsCellphoneDuplicate(cellphone))
                            {
                                LblComment.Text = "Cellphone number already exists!";
                            }
                            return true;
                        }
                    }
                }
                catch (SqlException)
                {
                    // Display SQL exception message
                    Response.Write("<script>alert('An error occurred while checking for duplicates.');</script>");
                }
            }
            return false;
        }
        #endregion

        #region Individual Field Duplication Checks
        private bool IsEmailDuplicate(string email)
        {
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM [User] WHERE Email = @Email";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool IsIdNumberDuplicate(string idNumber)
        {
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM [User] WHERE IdNumber = @IdNumber";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@IdNumber", idNumber);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool IsCellphoneDuplicate(string cellphone)
        {
            using (SqlConnection connection = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM [User] WHERE Cellphone = @Cellphone";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Cellphone", cellphone);
                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }
        #endregion

        #region Password Hashing
        private byte[] HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                return sha256.ComputeHash(passwordBytes);
            }
        }
        #endregion
    }
}
