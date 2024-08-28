using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class Learners : Page
    {
        // Connection string for database connection
        public string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\User\OneDrive - North-West University\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf"";Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection(); // Only test connection on first load
                Response.Write("<script>alert('Page Loaded');</script>"); // Debugging line
            }
        }

        private void TestDatabaseConnection()
        {
            // Attempt to open a connection to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    if (conn.State == System.Data.ConnectionState.Open)
                    {
                        // Connection successful
                        Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        protected void AddLearnerBtn_Click(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Add Learner Clicked');</script>");

            string learnerName = txtName.Text;
            string surname = txtSurname.Text;
            string email = txtEmail.Text;
            string telephone = txtPhone.Text;
            string IDnumber = txtID.Text;
            string dateofbirth = txtDOB.Text;

            DateTime dob;

            // Attempt to convert the string to DateTime
            if (DateTime.TryParse(dateofbirth, out dob))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();
                        string query = "INSERT INTO [Student] (FirstName, LastName, DateOfBirth, TelephoneNo, EmailAddress, IdNumber) " +
                                       "VALUES (@FirstName, @LastName, @DateOfBirth, @TelephoneNo, @EmailAddress, @IdNumber)";

                        using (SqlCommand comm = new SqlCommand(query, conn))
                        {
                            comm.Parameters.AddWithValue("@FirstName", learnerName);
                            comm.Parameters.AddWithValue("@LastName", surname);
                            comm.Parameters.AddWithValue("@DateOfBirth", dob); // Pass the DateTime object here
                            comm.Parameters.AddWithValue("@TelephoneNo", telephone);
                            comm.Parameters.AddWithValue("@EmailAddress", email);
                            comm.Parameters.AddWithValue("@IdNumber", IDnumber);

                            int rowsAffected = comm.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                Response.Write("<script>alert('Learner added successfully!');</script>");
                            }
                            else
                            {
                                Response.Write("<script>alert('Failed to add learner.');</script>");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                    }
                    if (string.IsNullOrEmpty(dateofbirth))
                    {
                        Response.Write("<script>alert('Please enter date of birth');</script>");
                       
                    }
                }
            }
            else
            {
                // Handle invalid date format
                Response.Write("<script>alert('Invalid date format. Please use a valid date.');</script>");
            }
        }


        protected void btnView_Click(object sender, EventArgs e)
        {
            // Debugging to see if event is triggered
            Response.Write("<script>alert('View Button Clicked');</script>");

            Response.Redirect("ViewLearners.aspx");
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            // Redirect to login page on logout
            Response.Redirect("Login.aspx");
        }
    }
}
