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
                filterPanel.Visible = false;
                HideBtn.Visible = false;
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
                        Response.Write("<script>alert('Connected');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Connection error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

         protected void btnApplyFilters_Click(object sender, EventArgs e)
         {
         }


        protected void AdvFilters_Click(object sender, EventArgs e)
        {
            //filterPanel.Visible = true;
            AdvFilters.Visible = false;
            HideBtn.Visible = true;
        }

        protected void HideBtn_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = false;
            AdvFilters.Visible = true;
            HideBtn.Visible = false;
        }
       

        protected void btnSearch_Click(object sender, EventArgs e)
        {

            // Get the search input from the search bar and convert it to uppercase
            string searchTerm = txtSearch.Text.Trim().ToUpper();

            // Initialize the SQL query
            string query;

            if (searchTerm == "ALL")
            {
                // If the search term is "ALL", retrieve all records
                query = "SELECT * FROM Student";
            }
            else
            {
                // Build the SQL query based on the search term
                query = "SELECT * FROM Student WHERE ";

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
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }
    }
}
