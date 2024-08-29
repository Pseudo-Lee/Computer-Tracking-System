using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        string str = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\leseg\source\repos\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader rdr;
        SqlDataAdapter adapter;
        DataSet ds;
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

            string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";

            string query = "INSERT INTO [User] (Name, Surname, IdNumber, Cellphone, Email, Password) " +
                           "VALUES (@Name, @Surname, @IdNumber, @Cellphone, @Email, @Password)";

            using (SqlConnection connection = new SqlConnection(connStr))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL command
                    command.Parameters.AddWithValue("@Name", name);
                    command.Parameters.AddWithValue("@Surname", surname);
                    command.Parameters.AddWithValue("@IdNumber", idNumber);
                    command.Parameters.AddWithValue("@Cellphone", cellphone);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@Password", hashedPassword);

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


        /*protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            
            string name = TextBoxName.Text;
            string surname = TextBoxSurname.Text;
            string email = TextBoxEmail.Text;
            string idnumber = TextBoxID.Text;
            string cellphone = TextBoxCellphone.Text;
            string password = TextBoxPassword.Text;
            string confirmPassword = TextBoxConfirmPassword.Text;

            SqlConnection con = new SqlConnection(str);
            
            String query = "INSERT INTO [User] (name,password) VALUES (@name ,@password )";

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name",name);
                //cmd.Parameters.AddWithValue("@surname", surname);
                //cmd.Parameters.AddWithValue("@email", email);
                //cmd.Parameters.AddWithValue("@idnumber", idnumber);
                //cmd.Parameters.AddWithValue("@cellphone", cellphone);
                cmd.Parameters.AddWithValue("@password", password);
                //cmd.Parameters.AddWithValue("@confirmPassword", confirmPassword);
                cmd.ExecuteNonQuery();
                Response.Redirect("Login.aspx", false);

                if (string.IsNullOrEmpty(TextBoxName.Text))
                {
                    MessageBox.Show("Enter a name");
                    TextBoxName.Focus();
                    return;
                    
                      

                }



                //if (password == confirmPassword)
                {

                }
                //else
                {
                    //TextBoxConfirmPassword.Text = string.Empty;
                    //TextBoxConfirmPassword.Focus();
                }
            }
            catch(Exception ex) 
            {
                MessageBox.Show("Error" + ex.Message);

            }
        }

       

        

       
    }
}
