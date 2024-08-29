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

            string FirstName = txtName.Text;
            string LastName = txtSurname.Text;
            string EmailAddress = txtEmail.Text;
            string TelephoneNo = txtPhone.Text;
            string IdNumber = txtID.Text;
            string DateOfBirth = txtDOB.Text;

            // Validate all input fields
            if (string.IsNullOrEmpty(FirstName) || string.IsNullOrEmpty(LastName) || string.IsNullOrEmpty(EmailAddress) ||
                string.IsNullOrEmpty(TelephoneNo) || string.IsNullOrEmpty(IdNumber) || string.IsNullOrEmpty(DateOfBirth))
            {
                Response.Write("<script>alert('All fields must be filled.');</script>");
                return;
            }

            DateTime dob;
            if (!DateTime.TryParse(DateOfBirth, out dob))
            {
                // Handle invalid date format
                Response.Write("<script>alert('Invalid date format. Please use a valid date.');</script>");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "INSERT INTO [Student] (FirstName, LastName, DateOfBirth, TelephoneNo, EmailAddress, IdNumber) " +
                                   "VALUES (@FirstName, @LastName, @DateOfBirth, @TelephoneNo, @EmailAddress, @IdNumber)";

                    using (SqlCommand comm = new SqlCommand(query, conn))
                    {
                        comm.Parameters.AddWithValue("@FirstName", FirstName);
                        comm.Parameters.AddWithValue("@LastName", LastName);
                        comm.Parameters.AddWithValue("@DateOfBirth", dob);
                        comm.Parameters.AddWithValue("@TelephoneNo", TelephoneNo);
                        comm.Parameters.AddWithValue("@EmailAddress", EmailAddress);
                        comm.Parameters.AddWithValue("@IdNumber", IdNumber);

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
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            // Redirect to the ViewLearners page
            Response.Redirect("ViewLearners.aspx");
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            // Redirect to the login page on logout
            Response.Redirect("Login.aspx");
        }
    }
}
