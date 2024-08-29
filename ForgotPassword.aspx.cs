using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.Net.PeerToPeer;

namespace CTS
{
    public partial class ForgotPassword :Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       

        protected void BtnPasswordReset_Click(object sender, EventArgs e)
        {
            String connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\GUSTAV\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security = True";

            //declare my sql variables
            SqlConnection conn;
            SqlCommand comm;
            SqlDataAdapter adap;
            SqlDataReader read;
            DataSet ds;
            if (Page.IsValid)
            {
                String UserName = txtUserName.Text.Trim();
                String IdNum = txtIdNum.Text.Trim();    
                String Email = txtEmail.Text.Trim();
                String Password = txtPassword.Text.Trim();
                String NewPassword = txtConfirmPassword.Text.Trim();

                if (String.IsNullOrEmpty(txtUserName.Text))
                {
                    LblComment.Text = "UserName required!!";
                    return;
                }
                else if(Password != NewPassword)
                {
                    LblComment.Text = "password do not match !!";
                    return;
                }
                else if(Password == NewPassword)
                {
                    LblComment.Text = "Password reset successful !";
                    return;
                }
               
                string query = "UPDATE Users SET PasswordHash = @PasswordHash WHERE Name = @UserName AND IDNumber = @IDNumber";

                using ( conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Name", UserName);
                            cmd.Parameters.AddWithValue("@IdNumber", IdNum);
                            cmd.Parameters.AddWithValue("@Email",Email);
                            cmd.Parameters.AddWithValue("@PasswordHash", HashPassword(NewPassword));

                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                LblComment.ForeColor = System.Drawing.Color.Green;
                                LblComment.Text = "Password reset successfully.";
                            }
                            else
                            {
                                LblComment.Text = "Invalid username or ID number.";
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        LblComment.Text = "An error occurred: " + ex.Message;
                    }
                }

            }
           

        }
        private string HashPassword(string Password)
        {
            // Use a secure hashing algorithm like SHA256
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(Password));
                return Convert.ToBase64String(bytes);
            }
        }
    }
}