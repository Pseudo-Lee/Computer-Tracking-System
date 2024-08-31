using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Users : System.Web.UI.Page
    {
        private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\GUSTAV\Documents\CTS\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsersGrid();
            }


        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM [User] WHERE Name LIKE @SearchTerm OR Email LIKE @SearchTerm";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void btnChangeRoleBulk_Click(object sender, EventArgs e)
        {
            //string newRole = ddlRoles.SelectedValue;

            foreach (GridViewRow row in gvUsers.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);
                    string newRole = (row.FindControl("ddlRole") as DropDownList)?.SelectedValue;

                    //bool newRole = Convert.ToBoolean(gvUsers.DataMember[row.RowIndex].ToString());
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE [User] SET Role = @Role WHERE UserID = @UserID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Role", newRole);
                        cmd.Parameters.AddWithValue("@UserID", UserID);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
            }

            BindUsersGrid();
        }

        protected void btnRemoveSelected_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvUsers.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    try
                    {
                        // Ensure the row index is valid
                        if (row.RowIndex >= 0 && row.RowIndex < gvUsers.DataKeys.Count)
                        {
                            int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);

                            using (SqlConnection conn = new SqlConnection(connectionString))
                            {
                                string query = "DELETE FROM [User] WHERE UserID = @UserID";
                                SqlCommand cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@IdNumber", UserID);

                                conn.Open();
                                cmd.ExecuteNonQuery();
                                conn.Close();
                            }
                        }
                        else
                        {
                            // Log or handle the invalid row index
                            // Example: Log the issue or notify the user
                            Debug.WriteLine($"Invalid RowIndex: {row.RowIndex} - DataKeys count: {gvUsers.DataKeys.Count}");
                            // Optionally, display a user-friendly message
                            LblMessage.Text = "An error occurred while processing some rows. Please try again.";
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the exception details and/or display a user-friendly message
                        Debug.WriteLine($"Exception occurred: {ex.Message}");
                        // Optionally, display an error message to the user
                        LblMessage.Text = "An error occurred while removing selected users. Please try again.";
                    }
                }
            }

            // Rebind the GridView to reflect the changes
            BindUsersGrid();
        }

        protected void btnToggleActive_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvUsers.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                CheckBox chkSelectAll = (CheckBox)row.FindControl("chkSelectAll");
                if ((chkSelect != null && chkSelect.Checked) || (chkSelectAll != null && chkSelectAll.Checked))
                {
                    int UserID = Convert.ToInt32(gvUsers.DataKeys[row.RowIndex].Value);
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "UPDATE [User] SET IsActive = NOT IsActive WHERE UserID = @UserID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@UserID", UserID);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
            }

            BindUsersGrid();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            BindUsersGrid();
        }

        private void BindUsersGrid()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserID, Name, IdNumber, Email, Role, Status FROM [User]";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Retrieve the user ID from the DataKeys collection
                int UserID;
                if (int.TryParse(gvUsers.DataKeys[e.RowIndex].Value.ToString(), out UserID))
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "DELETE FROM [User] WHERE UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", UserID);

                            conn.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();

                            // Check if the deletion was successful
                            if (rowsAffected > 0)
                            {
                                Debug.WriteLine($"User with ID {UserID} deleted successfully.");
                            }
                            else
                            {
                                Debug.WriteLine($"No user found with ID {UserID}. Deletion failed.");
                            }
                        }
                    }

                    // Rebind the GridView to refresh the data
                    BindUsersGrid();
                }
                else
                {
                    // Handle invalid user ID format
                    Debug.WriteLine($"Invalid user ID format: {gvUsers.DataKeys[e.RowIndex].Value}");
                    // Optionally, display a user-friendly message
                    LblMessage.Text = "Invalid user ID format. Please try again.";
                }
            }
            catch (SqlException sqlEx)
            {
                // Handle SQL exceptions
                Debug.WriteLine($"SQL exception occurred: {sqlEx.Message}");
                // Optionally, display an error message to the user
                LblMessage.Text = "An error occurred while deleting the user. Please try again.";
            }
            catch (Exception ex)
            {
                // Handle general exceptions
                Debug.WriteLine($"Exception occurred: {ex.Message}");
                // Optionally, display an error message to the user
                LblMessage.Text = "An error occurred while processing your request. Please try again.";
            }
        }


        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string commandName = e.CommandName;

            try
            {
                // Safely get the row index from CommandArgument
                int rowIndex;
                if (int.TryParse(e.CommandArgument.ToString(), out rowIndex))
                {
                    // Ensure the row index is valid
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
                                BindUsersGrid(); // Ensure grid is refreshed after deletion
                                break;


                        }
                    }
                    else
                    {
                        // Handle invalid row index
                        Debug.WriteLine($"Invalid rowIndex: {rowIndex}. Total rows: {gvUsers.Rows.Count}");
                        // Optionally, display a user-friendly message
                        LblMessage.Text = "Invalid row index. Please try again.";
                    }
                }
                else
                {
                    // Handle invalid CommandArgument
                    Debug.WriteLine($"Invalid CommandArgument: {e.CommandArgument}");
                    // Optionally, display a user-friendly message
                    LblMessage.Text = "Invalid command argument. Please try again.";
                }
            }
            catch (Exception ex)
            {
                // Log the exception details and/or display a user-friendly message
                Debug.WriteLine($"Exception occurred: {ex.Message}");
                // Optionally, display an error message to the user
                LblMessage.Text = "An error occurred while processing your request. Please try again.";
            }
        }


        private void DeleteUser(int UserID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM [User] WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", UserID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void gvUsers_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}