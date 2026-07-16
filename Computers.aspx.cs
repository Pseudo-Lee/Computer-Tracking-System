using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Computers : Page
    {
        // Connection string for the database
        private string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        #region Page Load
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Generate and set a new serial number for the computer registration
                txtSerialNumber.Text = GenerateSerialNumber();
                txtSerialNumber.ReadOnly = true;

                // Test database connection
                TestDatabaseConnection();
            }
        }
        #endregion

        #region Database Connection
        // Method to test the database connection
        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Connection successful; display notification
                        DisplayNotification("Online", true);
                    }
                    else
                    {
                        // Connection failed; display notification
                        DisplayNotification("Offline", false);
                    }
                }
                catch (Exception ex)
                {
                    // Exception occurred; display error message
                    DisplayNotification("Connection error: " + ex.Message, false);
                }
            }
        }
        #endregion

        #region Serial Number Generation
        // Method to generate a random serial number
        private string GenerateSerialNumber()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            StringBuilder serialNumber = new StringBuilder(7);
            Random random = new Random();

            for (int i = 0; i < 7; i++)
            {
                serialNumber.Append(chars[random.Next(chars.Length)]);
            }

            return serialNumber.ToString();
        }
        #endregion

        #region Computer Assignment
        // Event handler for assigning a computer to a learner
        protected void btnAssignComputer_Click(object sender, EventArgs e)
        {
            string firstName = FirstName.Text;
            string lastSurname = LastName.Text;
            string idNumber = IDTextBox.Text;
            int computerID = int.Parse(ComputerID.Text);
            DateTime currentDate = DateTime.Now;

            int learnerID = -1;
            try
            {
                // Get learner ID by ID number
                if (!string.IsNullOrEmpty(idNumber))
                {
                    learnerID = GetLearnerIDByIdNumber(idNumber);
                }

                if (learnerID > 0)
                {
                    // Update computer assignment in database
                    string query = "UPDATE Computer SET LearnerID = @LearnerID, DateOfIssue = @DateOfIssue WHERE ComputerID = @ComputerID";

                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@LearnerID", learnerID);
                            cmd.Parameters.AddWithValue("@DateOfIssue", currentDate);
                            cmd.Parameters.AddWithValue("@ComputerID", computerID);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            DisplayNotification($"Computer {computerID} assigned successfully to {learnerID}", true);
                        }
                    }
                }
                else
                {
                    DisplayNotification("Learner not found", false);
                }
            }
            catch (Exception ex)
            {
                DisplayNotification($"Unable to process your request. An error occurred: {ex.Message}", false);
            }
        }

        // Method to get learner ID by ID number
        private int GetLearnerIDByIdNumber(string idNumber)
        {
            int learnerID = -1;
            string query = "SELECT LearnerID FROM Student WHERE IdNumber = @IdNumber";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@IdNumber", idNumber);

                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        learnerID = Convert.ToInt32(result);
                    }
                }
            }

            return learnerID;
        }
        #endregion

        #region Computer Registration
        // Event handler for registering a new computer
        protected void btnRegisterComputer_Click(object sender, EventArgs e)
        {
            string serialNumber = txtSerialNumber.Text;
            string computerName = txtComputerName.Text;
            string description = Description.Text;

            string query = "INSERT INTO Computer (Serial_no, Name, Description) VALUES (@SerialNumber, @ComputerName, @Description)";
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SerialNumber", serialNumber);
                        cmd.Parameters.AddWithValue("@ComputerName", computerName);
                        cmd.Parameters.AddWithValue("@Description", description);

                        cmd.ExecuteNonQuery();
                    }

                    con.Close();
                }

                DisplayNotification($"Computer {serialNumber} registered successfully", true);
                ClearForm();
            }
            catch (Exception ex)
            {
                DisplayNotification($"An error occurred while processing your request: {ex.Message}", false);
            }
        }

        // Method to clear the computer registration form
        private void ClearForm()
        {
            txtComputerName.Text = "";
            Description.Text = "";
            txtSerialNumber.Text = GenerateSerialNumber();
        }
        #endregion

        #region Computer Data Management
        // Event handler for loading computer data into GridView
        protected void btnLoadComputers_Click(object sender, EventArgs e)
        {
            string query = "SELECT * FROM Computer";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvComputer.DataSource = dt;
                gvComputer.DataBind();

                if (dt.Rows.Count > 0)
                {
                    DisplayNotification("Successfully retrieved computer information", true);
                }
                else
                {
                    DisplayNotification("No computer information found", false);
                }
            }
        }

        // Event handler for sorting the GridView data
        protected void gvComputer_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = ViewState["ComputerData"] as DataTable;

            if (dt != null)
            {
                DataView dv = new DataView(dt);

                // Determine the sort direction
                string sortDirection = ViewState["SortDirection"] as string ?? "ASC";
                if (sortDirection == "ASC")
                {
                    sortDirection = "DESC";
                }
                else
                {
                    sortDirection = "ASC";
                }

                // Sort the data view
                dv.Sort = e.SortExpression + " " + sortDirection;

                // Store the new sort direction in ViewState
                ViewState["SortDirection"] = sortDirection;

                // Bind the sorted data to the GridView
                gvComputer.DataSource = dv;
                gvComputer.DataBind();
            }
        }

        // Event handler for dropdown selection change
        protected void ddlOrder_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortOrder = ddlOrder.SelectedValue;
            string query = $"SELECT * FROM Computer WHERE LearnerID IS NULL ORDER BY ComputerID {sortOrder}";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvComputer.DataSource = dt;
                gvComputer.DataBind();
            }
        }
        // Event handler for GridView row command (e.g., edit)
        protected void gvComputer_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditComputer")
            {
                // Retrieve the ComputerID from the CommandArgument
                int computerID = Convert.ToInt32(e.CommandArgument);

                // Redirect to the EditComputer.aspx page with the ComputerID as a query string
                Response.Redirect($"EditComputer.aspx?ComputerID={computerID}");
            }
        }
        #endregion

        #region Notification Display
        // Method to display notifications with success or error messages
        private void DisplayNotification(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            panel.Visible = true; // Show the panel

            // Set inline styles directly for debugging
            panel.Style.Add("background-color", isSuccess ? "#d4edda" : "#f8d7da");
            panel.Style.Add("border", isSuccess ? "1px solid #28a745" : "1px solid #dc3545");
            panel.Style.Add("color", isSuccess ? "#155724" : "#721c24");
            ScriptManager.RegisterStartupScript(this, GetType(), "HidePanel", "setTimeout(function() { hidePanel(); }, 3000);", true);
        }
        #endregion

        #region Learner Details
        // Event handler for IDTextBox text change to fetch learner details
        protected void IDTextBox_TextChanged(object sender, EventArgs e)
        {
            // Get the entered ID number
            string idNumber = IDTextBox.Text;

            // Fetch learner details from the database
            DataTable learnerDetails = GetLearnerDetailsByIdNumber(idNumber);

            // Display the details in the form controls
            if (learnerDetails.Rows.Count > 0)
            {
                DataRow row = learnerDetails.Rows[0];
                FirstName.Text = row["FirstName"].ToString();
                LastName.Text = row["LastSurname"].ToString();
            }
            else
            {
                // Clear the form controls if no learner is found
                FirstName.Text = "";
                LastName.Text = "";
            }
        }

        // Method to get learner details by ID number
        private DataTable GetLearnerDetailsByIdNumber(string idNumber)
        {
            DataTable dt = new DataTable();
            string query = "SELECT FirstName, LastSurname FROM Student WHERE IdNumber = @IdNumber";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@IdNumber", idNumber);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        #endregion

        protected void txtComputerName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnRegisterComputer_Click1(object sender, EventArgs e)
        {
            string serialNumber = txtSerialNumber.Text;
            string computerName = txtComputerName.Text;
            string description = Description.Text;

            string query = "INSERT INTO Computer (Serial_no, Name, Description) VALUES (@SerialNumber, @ComputerName, @Description)";
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SerialNumber", serialNumber);
                        cmd.Parameters.AddWithValue("@ComputerName", computerName);
                        cmd.Parameters.AddWithValue("@Description", description);

                        cmd.ExecuteNonQuery();
                    }

                    con.Close();
                }

                DisplayNotification($"Computer {serialNumber} registered successfully", true);
                ClearForm();
            }
            catch (Exception ex)
            {
                DisplayNotification($"An error occurred while processing your request: {ex.Message}", false);
            }
        }

        protected void btnAssignComputer_Click1(object sender, EventArgs e)
        {
            string firstName = FirstName.Text;
            string lastSurname = LastName.Text;
            string idNumber = IDTextBox.Text;
            int computerID = int.Parse(ComputerID.Text);
            DateTime currentDate = DateTime.Now;

            int learnerID = -1;
            try
            {
                // Get learner ID by ID number
                if (!string.IsNullOrEmpty(idNumber))
                {
                    learnerID = GetLearnerIDByIdNumber(idNumber);
                }

                if (learnerID > 0)
                {
                    // Update computer assignment in database
                    string query = "UPDATE Computer SET LearnerID = @LearnerID, DateOfIssue = @DateOfIssue WHERE ComputerID = @ComputerID";

                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@LearnerID", learnerID);
                            cmd.Parameters.AddWithValue("@DateOfIssue", currentDate);
                            cmd.Parameters.AddWithValue("@ComputerID", computerID);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            DisplayNotification($"Computer {computerID} assigned successfully to {learnerID}", true);
                        }
                    }
                }
                else
                {
                    DisplayNotification("Learner not found", false);
                }
            }
            catch (Exception ex)
            {
                DisplayNotification($"Unable to process your request. An error occurred: {ex.Message}", false);
            }
        }

        protected void ViewBtn_Click(object sender, EventArgs e)
        {
            string query = "SELECT * FROM Computer";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvComputer.DataSource = dt;
                gvComputer.DataBind();

                if (dt.Rows.Count > 0)
                {
                    DisplayNotification("Successfully retrieved computer information", true);
                }
                else
                {
                    DisplayNotification("No computer information found", false);
                }
            }
        }

        protected void gvComputer_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
