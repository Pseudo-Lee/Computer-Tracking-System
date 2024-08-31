using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.XPath;

namespace CTS
{
    public partial class ViewLearners : Page
    {
        // Connection string to the database
        public string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the session exists
                if (Session["Username"] != null)
                {
                    // Display a welcome message with the username
                    string username = Session["Username"].ToString();
                    ShowMessage("Currently logged in as: " + username, true);
                }
                else
                {
                    // If no session exists, redirect to the login page
                    Response.Redirect("Login.aspx");
                }

                // Initial UI settings
                filterPanel.Visible = false;
                HideBtn.Visible = false;
            }
        }

        #region Database Connection

        private void TestDatabaseConnection()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Connection successful; no further action needed here
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Connection error: " + ex.Message, false);
                }
            }
        }

        #endregion

        #region GridView Management

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

        protected void GridViewLearners_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditLearner")
            {
                int learnerID = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditLearner.aspx?LearnerID=" + learnerID);
            }
        }

        protected void GridViewLearners_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int learnerID = Convert.ToInt32(GridViewLearners.DataKeys[e.RowIndex].Values[0]);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "DELETE FROM Student WHERE LearnerID = @LearnerID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@LearnerID", learnerID);
                cmd.ExecuteNonQuery();
            }

            BindGrid(); // Refresh the GridView after deletion
        }

        protected void GridViewLearners_RowEditing(object sender, GridViewEditEventArgs e)
        {
            if (e.NewEditIndex >= 0 && e.NewEditIndex < GridViewLearners.DataKeys.Count)
            {
                int learnerID = Convert.ToInt32(GridViewLearners.DataKeys[e.NewEditIndex].Values["LearnerID"]);
                Response.Redirect("EditLearner.aspx?LearnerID=" + learnerID);
            }
            else
            {
                ShowMessage("Invalid edit index", false);
            }
        }

        protected void GridViewLearners_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewLearners.EditIndex = -1; // Exit edit mode
            BindGrid(); // Refresh the GridView to reflect the changes
        }

        protected void btnRetrieveSelected_Click(object sender, EventArgs e)
        {
            List<int> selectedLearnerIDs = new List<int>();

            foreach (GridViewRow row in GridViewLearners.Rows)
            {
                CheckBox chkSelect = row.FindControl("chkSelect") as CheckBox;
                if (chkSelect != null && chkSelect.Checked)
                {
                    int learnerID = Convert.ToInt32(GridViewLearners.DataKeys[row.RowIndex].Values["LearnerID"]);
                    selectedLearnerIDs.Add(learnerID);
                }
            }

            if (selectedLearnerIDs.Count > 0)
            {
                ShowMessage("Selected Learner IDs: " + string.Join(", ", selectedLearnerIDs), true);
            }
            else
            {
                ShowMessage("No rows selected.", false);
            }
        }

        #endregion

        #region Search and Filters

        protected void btnLoadData_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            string filterColumn = ddlFilter.SelectedValue; // Get the selected column
            string sortOrder = ddlFilter.SelectedValue; // Get the selected sort order
            string query = "SELECT * FROM Student";
            bool hasWhereClause = false;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;

                    // Apply filter based on the selected column and search term
                    if (!string.IsNullOrEmpty(filterColumn) && filterColumn != "NULL" && !string.IsNullOrEmpty(searchTerm) && searchTerm != "ALL")
                    {
                        // Special case for numeric IdNumber search
                        if (filterColumn == "IdNumber" && long.TryParse(searchTerm, out _))
                        {
                            query += $" WHERE {filterColumn} = @SearchTerm";
                        }
                        else
                        {
                            query += $" WHERE {filterColumn} LIKE '%' + @SearchTerm + '%'";
                        }

                        hasWhereClause = true;
                        cmd.Parameters.AddWithValue("@SearchTerm", searchTerm);
                    }

                    // Apply sorting if sortOrder is valid
                    if (!string.IsNullOrEmpty(sortOrder) && (sortOrder == "ASC" || sortOrder == "DESC"))
                    {
                        query += $" ORDER BY {filterColumn} {sortOrder}";
                    }

                    cmd.CommandText = query;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GridViewLearners.DataSource = dt;
                    GridViewLearners.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        ShowMessage("Successfully retrieved learners from database", true);
                    }
                    else
                    {
                        ShowMessage("Unable to find data", false);
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message, false);
                }
            }
        }


        #endregion

        #region UI Controls

        protected void AdvFilters_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = true;
            AdvFilters.Visible = false;
            HideBtn.Visible = true;
        }

        protected void HideBtn_Click(object sender, EventArgs e)
        {
            filterPanel.Visible = false;
            AdvFilters.Visible = true;
            HideBtn.Visible = false;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        #endregion

        #region NonActiveField

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            Panel1.Visible = true; // Show the panel

            // Set inline styles directly for debugging
            Panel1.Style.Add("background-color", isSuccess ? "#d4edda" : "#f8d7da");
            Panel1.Style.Add("border", isSuccess ? "1px solid #28a745" : "1px solid #dc3545");
            Panel1.Style.Add("color", isSuccess ? "#155724" : "#721c24");
            ScriptManager.RegisterStartupScript(this, GetType(), "HidePanel", "setTimeout(function() { hidePanel(); }, 3000);", true);
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Optional: Update any UI or functionality based on the selected filter
        }

        protected void order_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Optional: Update sorting based on selected order
        }
         
       
    }
}
