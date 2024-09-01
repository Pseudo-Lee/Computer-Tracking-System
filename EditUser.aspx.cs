using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CTS
{
    public partial class EditUser : Page
    {
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["UserId"] != null)
                {
                    int userId;
                    if (int.TryParse(Request.QueryString["UserId"], out userId))
                    {
                        PopulateUserData(userId);
                    }
                    else
                    {
                        ShowMessage("Invalid User ID", false);
                    }
                }
                else
                {
                    ShowMessage("User ID not provided", false);
                }
            }
        }

        private void PopulateUserData(int userId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Name, Role  FROM [User] WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    // Use DBNull.Value to check for null values
                    txtFirstName.Text = reader["Name"] != DBNull.Value ? reader["Name"].ToString() : string.Empty;
                    txtRole.Text = reader["Role"] != DBNull.Value ? reader["Role"].ToString() : string.Empty;

                    // Convert DBNull to boolean safely
                    chkIsAdmin.Checked = reader["Role"] != DBNull.Value ? Convert.ToBoolean(reader["Role"]) : false;
                }
                else
                {
                    ShowMessage("User not found", false);
                }
                con.Close();
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            
            
            
            int userId;
            if (int.TryParse(Request.QueryString["UserId"], out userId))
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "UPDATE [User] SET Name = @Name, Role = @Role WHERE UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", txtFirstName.Text);
                    cmd.Parameters.AddWithValue("@Role", chkIsAdmin.Checked);
                    //cmd.Parameters.AddWithValue("@IsAdmin", chkIsAdmin.Checked);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("User updated successfully", true);
                        if (chkIsAdmin.Checked)
                        {
                            txtRole.Text = "Admin";
                        }
                        else
                        {
                            txtRole.Text = "Is not Admin";
                        }
                        btnCancel.Text = "Return";
                        //Response.Redirect("Users.aspx");
                    }
                    else
                    {
                        ShowMessage("User update failed", false);
                    }

                }
            }
            else
            {
                ShowMessage("Invalid User ID", false);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int userId;
            if (int.TryParse(Request.QueryString["UserId"], out userId))
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM User WHERE UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("User deleted successfully", true);
                        btnCancel.Text = "Return";
                       // Response.Redirect("User.aspx"); // Redirect to the user list page after deletion
                    }
                    else
                    {
                        ShowMessage("User deletion failed", false);
                    }
                }
            }
            else
            {
                ShowMessage("Invalid User ID", false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "message-panel success" : "message-panel error";
            messagePanel.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect back to the user list or any other page
            Response.Redirect("Users.aspx");
        }

        protected void chkIsAdmin_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}
