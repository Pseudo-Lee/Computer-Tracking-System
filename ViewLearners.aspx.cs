using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class ViewLearners : Page
    {
        // Connection string for database connection
        public string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TestDatabaseConnection(); // Only test connection on first load
                filterPanel.Visible = false; // Ensure filter panel is hidden initially
                HideBtn.Visible = false; // Hide the "Hide Advanced Filters" button initially
                // Load data initially if needed
                // LoadData(); // Uncomment if you want to load data on initial page load
               // BindGrid();
            }
        }

        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Log message for successful connection
                        // Consider using a logging framework instead of alert for production
                        Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Log message for connection error
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        protected void btnApplyFilters_Click(object sender, EventArgs e)
        {
            // This method will be used for applying advanced filters when implemented
            // Currently, it's empty and does not perform any action
        }

        protected void AdvFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = true; // Show the advanced filters panel
            AdvFilters.Visible = false; // Hide the "Show Advanced Filters" button
            HideBtn.Visible = true; // Show the "Hide Advanced Filters" button
        }

        protected void HideBtn_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = false; // Hide the advanced filters panel
            AdvFilters.Visible = true; // Show the "Show Advanced Filters" button
            HideBtn.Visible = false; // Hide the "Hide Advanced Filters" button
        }

        private string BuildQuery(string searchTerm)
        {
            if (searchTerm == "ALL")
            {
                // If the search term is "ALL", retrieve all records
                return "SELECT * FROM Student";
            }

            // Build the SQL query based on the search term
            string query = "SELECT * FROM Student WHERE ";

            // Check if the search term is numeric (likely an ID number or phone number)
            if (long.TryParse(searchTerm, out long numericTerm))
            {
                query += "IdNumber = @SearchTerm OR TelephoneNo LIKE '%' + @SearchTerm + '%'";
            }
            // Check if the search term looks like an email address
            else if (searchTerm.Contains("@"))
            {
                query += "EmailAddress LIKE '%' + @SearchTerm + '%'";
            }
            // Otherwise, treat it as a name or university search
            else
            {
                query += "UPPER(FirstName) LIKE '%' + @SearchTerm + '%' OR " +
                         "UPPER(LastName) LIKE '%' + @SearchTerm + '%' OR " +
                         "UPPER(University) LIKE '%' + @SearchTerm + '%'";
            }

            // Add sorting clause; will be appended in the sorting method
            return query;
        }

        private void LoadData()
        {
            
        }

        protected void btnLoadData_Click(object sender, EventArgs e)
        {
            // Get the search input from the search bar and convert it to uppercase
            string searchTerm = txtSearch.Text.Trim().ToUpper();

            // Initialize the SQL query using the search term
            string query = BuildQuery(searchTerm);

            // Append the ORDER BY clause based on the selected sort order
            string sortOrder = order.SelectedValue; // Get selected sort order
            if (sortOrder == "Asc") // Ascending
            {
                query += " ORDER BY FirstName ASC, LastName ASC, IdNumber ASC, EmailAddress ASC, DateOfBirth ASC";
            }
            else if (sortOrder == "Desc") // Descending
            {
                query += " ORDER BY FirstName DESC, LastName DESC, IdNumber DESC, EmailAddress DESC, DateOfBirth DESC";
            }
            else
            {

            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);

                    // Add parameter only if it's not the "ALL" case
                    if (searchTerm != "ALL")
                    {
                        cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GridViewLearners.DataSource = dt;
                    GridViewLearners.DataBind();

                    // Show success or no data message based on results
                    if (dt.Rows.Count > 0)
                    {
                        Response.Write("<script>alert('Successfully retrieved learners from database');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Unable to find data');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Log message for data retrieval error
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        protected void order_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Reload data when sorting order is changed
            LoadData();
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Implement filter logic if necessary
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Student";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewLearners.DataSource = dt;
                GridViewLearners.DataBind();
            }
        }
        protected void GridViewLearners_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewLearners.EditIndex = e.NewEditIndex;
            BindGrid(); // Rebind data to GridView to reflect edit mode
        }
        protected void GridViewLearners_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridViewLearners.Rows[e.RowIndex];
           
                int learnerID = Convert.ToInt32(GridViewLearners.DataKeys[e.RowIndex].Values["LearnerID"]);
            
           

            TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
            TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
            TextBox txtEmail = row.FindControl("txtEmail") as TextBox;
            TextBox txtIdNumber = row.FindControl("txtIdNumber") as TextBox;
            TextBox txtGender = row.FindControl("txtGender") as TextBox;
            
            string FirstName = txtFirstName != null ? txtFirstName.Text : string.Empty;
            string LastName = txtLastName != null ? txtLastName.Text : string.Empty;
            string EmailAddress = txtEmail != null ? txtEmail.Text : string.Empty;
            string IdNumber = txtIdNumber != null ? txtIdNumber.Text : string.Empty;
            string Gender = txtGender != null ? txtGender.Text : string.Empty;

            // Debug information
            Response.Write("<script>alert('Updating Data: " + FirstName + ", " + LastName + ", " + EmailAddress + ", " + IdNumber + ", " + Gender + "');</script>");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "UPDATE Student SET FirstName=@FirstName, LastName=@LastName, EmailAddress=@EmailAddress, IdNumber=@IdNumber, Gender=@Gender WHERE LearnerID=@LearnerID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@FirstName", FirstName);
                    cmd.Parameters.AddWithValue("@LastName", LastName);
                    cmd.Parameters.AddWithValue("@EmailAddress", EmailAddress);
                    cmd.Parameters.AddWithValue("@IdNumber", IdNumber);
                    cmd.Parameters.AddWithValue("@Gender", Gender);
                    cmd.Parameters.AddWithValue("@LearnerID", learnerID);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Response.Write("<script>alert('Record updated successfully.');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('No record was updated.');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }

            GridViewLearners.EditIndex = -1;
            BindGrid(); // Refresh the GridView data          
        }




        protected void GridViewLearners_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewLearners.EditIndex = -1; // Exit edit mode
            BindGrid(); // Rebind data to GridView
        }
        protected void GridViewLearners_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int learnerID = Convert.ToInt32(GridViewLearners.DataKeys[e.RowIndex].Values[0]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Student WHERE LearnerID=@LearnerID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LearnerID", learnerID);
                cmd.ExecuteNonQuery();
            }

            BindGrid(); // Rebind data to GridView
        }
         
       
    }
}
