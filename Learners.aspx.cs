using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class Learners : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optionally, handle page load events here
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\User\\OneDrive - North-West University\\Documents\\COMPUTER TRACKING SYSTEM\\Group13Projects\\Computer-Tracking-System\\App_Data\\CTS.mdf\";Integrated Security=True";
            string query = "INSERT INTO [Student] (FirstName, LastName, EmailAddress, TelephoneNo, DateOfBirth, IdNumber) VALUES (@Name, @Surname, @Email, @Telephone, @DateOfBirth, @IDNumber)";

            DateTime dateOfBirth;
            // Simplified date parsing
            bool isDateValid = DateTime.TryParse(txtDOB.Text, out dateOfBirth);

            if (!isDateValid)
            {
                // Display error message using Response.Write
                Response.Write("<script>alert('The date of birth is not in a valid format.');</script>");
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Name", txtName.Text);
                    command.Parameters.AddWithValue("@Surname", txtSurname.Text);
                    command.Parameters.AddWithValue("@Email", txtEmail.Text);
                    command.Parameters.AddWithValue("@Telephone", txtPhone.Text);
                    command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                    command.Parameters.AddWithValue("@IDNumber", txtID.Text);

                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        
                    }
                    catch (SqlException ex)
                    {
                        // Display SQL exception message using Response.Write
                        Response.Write($"<script>alert('An error occurred while inserting data: {ex.Message}');</script>");
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
            }
        }
    }
}
