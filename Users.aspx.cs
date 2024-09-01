using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Users : System.Web.UI.Page
    {
        // Connection string to the database
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        #region Page Load
        /// <summary>
        /// Handles the Page_Load event. Binds the GridView only if it's not a postback.
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsersGrid();
            }
        }
        #endregion

        #region Search Users
        /// <summary>
        /// Handles the search functionality for users based on Name or Email.
        /// </summary>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            string roleFilter = rblFilterRole.SelectedValue;
            string query;

            if (roleFilter == "All")
            {
                query = "SELECT * FROM [User] WHERE Name LIKE @SearchTerm OR Email LIKE @SearchTerm";
            }
            else if (roleFilter == "Admin")
            {
                query = "SELECT * FROM [User] WHERE Role = 1 AND (Name LIKE @SearchTerm OR Email LIKE @SearchTerm)";
            }
            else // NonAdmin
            {
                query = "SELECT * FROM [User] WHERE Role = 0 AND (Name LIKE @SearchTerm OR Email LIKE @SearchTerm)";
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }
        #endregion

        #region Bulk Role Change
        /// <summary>
        /// Handles the bulk role change for selected users.
        /// </summary>
        protected void btnChangeRoleBulk_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    foreach (GridViewRow row in gvUsers.Rows)
                    {
                        CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                        if (chkSelect != null && chkSelect.Checked)
                        {
                            int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);
                            string newRole = (row.FindControl("ddlRole") as DropDownList)?.SelectedValue;

                            string query = "UPDATE [User] SET Role = @Role WHERE UserID = @UserID";
                            SqlCommand cmd = new SqlCommand(query, conn, transaction);
                            cmd.Parameters.AddWithValue("@Role", newRole);
                            cmd.Parameters.AddWithValue("@UserID", UserID);

                            cmd.ExecuteNonQuery();
                        }
                    }
                    transaction.Commit();
                    ShowMessage("Roles updated successfully.", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    Debug.WriteLine($"Exception occurred: {ex.Message}");
                    ShowMessage("An error occurred while updating roles. Please try again.", false);
                }
            }

            BindUsersGrid();
        }
        #endregion

        #region Remove Selected Users
        /// <summary>
        /// Handles the removal of selected users.
        /// </summary>
        protected void btnRemoveSelected_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    foreach (GridViewRow row in gvUsers.Rows)
                    {
                        CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                        if (chkSelect != null && chkSelect.Checked)
                        {
                            int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);

                            string query = "DELETE FROM [User] WHERE UserID = @UserID";
                            SqlCommand cmd = new SqlCommand(query, conn, transaction);
                            cmd.Parameters.AddWithValue("@UserID", UserID);

                            cmd.ExecuteNonQuery();
                        }
                    }
                    transaction.Commit();
                    ShowMessage("Selected users removed successfully.", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    Debug.WriteLine($"Exception occurred: {ex.Message}");
                    ShowMessage("An error occurred while removing users. Please try again.", false);
                }
            }

            BindUsersGrid();
        }
        #endregion

        #region Toggle Active Status
        /// <summary>
        /// Toggles the active status of selected users.
        /// </summary>
        protected void btnToggleActive_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    foreach (GridViewRow row in gvUsers.Rows)
                    {
                        CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                        CheckBox chkSelectAll = (CheckBox)row.FindControl("chkSelectAll");
                        if ((chkSelect != null && chkSelect.Checked) || (chkSelectAll != null && chkSelectAll.Checked))
                        {
                            int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);

                            string query = "UPDATE [User] SET IsActive = NOT IsActive WHERE UserID = @UserID";
                            SqlCommand cmd = new SqlCommand(query, conn, transaction);
                            cmd.Parameters.AddWithValue("@UserID", UserID);

                            cmd.ExecuteNonQuery();
                        }
                    }
                    transaction.Commit();
                    ShowMessage("User statuses updated successfully.", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    Debug.WriteLine($"Exception occurred: {ex.Message}");
                    ShowMessage("An error occurred while updating user statuses. Please try again.", false);
                }
            }

            BindUsersGrid();
        }
        #endregion

        #region GridView Events
        /// <summary>
        /// Handles the GridView RowEditing event to enable editing mode.
        /// </summary>
        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            if (e.NewEditIndex >= 0 && e.NewEditIndex < gvUsers.DataKeys.Count)
            {
                int UserID = Convert.ToInt32(gvUsers.DataKeys[e.NewEditIndex].Values["UserID"]);
                Response.Redirect("EditUser.aspx?UserID=" + UserID);
            }
            else
            {
                ShowMessage("Invalid edit index", false);
            }
            BindUsersGrid();
        }

        /// <summary>
        /// Handles the GridView RowDeleting event to delete a user.
        /// </summary>
        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int UserID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM [User] WHERE UserID = @UserID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", UserID);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage("User deleted successfully.", true);
                        }
                        else
                        {
                            ShowMessage("No user found with the given ID. Deletion failed.", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"An error occurred while processing your request: {ex.Message}", false);
            }

            BindUsersGrid();
        }

        /// <summary>
        /// Handles the GridView RowCommand event for custom commands.
        /// </summary>
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string commandName = e.CommandName;

            try
            {
                int rowIndex;
                if (int.TryParse(e.CommandArgument.ToString(), out rowIndex))
                {
                    if (rowIndex >= 0 && rowIndex < gvUsers.Rows.Count)
                    {
                        int UserID = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

                        switch (commandName)
                        {
                            case "Edit":
                                Response.Redirect($"EditUser.aspx?UserId={UserID}");
                                break;

                            case "Delete":
                                DeleteUser(UserID);
                                BindUsersGrid();
                                break;

                            default:
                                ShowMessage("Unknown command", false);
                                break;
                        }
                    }
                    else
                    {
                        ShowMessage("Invalid row format", false);
                    }
                }
                else
                {
                    ShowMessage("Invalid row format", false);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Exception occurred: {ex.Message}");
                ShowMessage("An error occurred", false);
            }
        }
        #endregion

        #region Helper Methods
        /// <summary>
        /// Deletes a user by UserID.
        /// </summary>
        /// <param name="userId">The UserID of the user to delete.</param>
        private void DeleteUser(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM [User] WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        /// <summary>
        /// Displays a message to the user in a message panel.
        /// </summary>
        /// <param name="message">The message to display.</param>
        /// <param name="isSuccess">Whether the operation was successful.</param>
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            Panel1.Visible = true; // Show the panel

            // Set inline styles directly for debugging
            Panel1.Style.Add("background-color", isSuccess ? "green" : "red");
            lblMessage.ForeColor = System.Drawing.Color.White;
        }

        /// <summary>
        /// Binds the data to the GridView.
        /// </summary>
        private void BindUsersGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, Name, Email, Role,DateAdded, Status FROM [User]";
                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }
        #endregion

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {

        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            // Set the content type and file name
            Response.ContentType = "text/csv";
            Response.AddHeader("content-disposition", "attachment;filename=UsersData.csv");
            Response.Charset = "";

            using (System.IO.StringWriter sw = new System.IO.StringWriter())
            {
                // Write the header row
                for (int i = 0; i < gvUsers.Columns.Count; i++)
                {
                    if (i > 0)
                        sw.Write(",");
                    sw.Write("\"" + gvUsers.Columns[i].HeaderText.Replace("\"", "\"\"") + "\""); // Escape double quotes
                }
                sw.Write("\n");

                // Write the data rows
                foreach (GridViewRow row in gvUsers.Rows)
                {
                    for (int i = 0; i < gvUsers.Columns.Count; i++)
                    {
                        if (i > 0)
                            sw.Write(",");
                        sw.Write("\"" + row.Cells[i].Text.Replace("\"", "\"\"") + "\""); // Escape double quotes
                    }
                    sw.Write("\n");
                }

                // Output the CSV data
                Response.Write(sw.ToString());
                Response.End();
            }
        }
    }
}
