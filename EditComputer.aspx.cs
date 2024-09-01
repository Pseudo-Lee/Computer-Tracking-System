using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace CTS
{
    public partial class EditComputer : Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\CTS.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComputerDetails();
            }
        }

        private void LoadComputerDetails()
        {
            // Assuming ComputerID is passed via query string
            int computerID = Convert.ToInt32(Request.QueryString["ComputerID"]);

            string query = "SELECT Serial_no, Name, Description, Location, AssignedTo FROM Computer WHERE ComputerID = @ComputerID";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ComputerID", computerID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtSerialNumber.Text = reader["Serial_no"].ToString();
                    txtName.Text = reader["Name"].ToString();
                    txtDescription.Text = reader["Description"].ToString();
                    txtLocation.Text = reader["Location"].ToString();
                    txtAssignedTo.Text = reader["AssignedTo"].ToString();
                }

                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int computerID = Convert.ToInt32(Request.QueryString["ComputerID"]);

            string query = "UPDATE Computer SET Name = @Name, Description = @Description, Location = @Location, AssignedTo = @AssignedTo WHERE ComputerID = @ComputerID";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Location", txtLocation.Text);
                cmd.Parameters.AddWithValue("@AssignedTo", txtAssignedTo.Text);
                cmd.Parameters.AddWithValue("@ComputerID", computerID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            DisplayNotification("Computer updated successfully", true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int computerID = Convert.ToInt32(Request.QueryString["ComputerID"]);

            string query = "DELETE FROM Computer WHERE ComputerID = @ComputerID";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ComputerID", computerID);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            DisplayNotification("Computer deleted successfully", true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to a previous page or home page
            Response.Redirect("ViewComputers.aspx");
        }

     
        private void DisplayNotification(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            messagePanel.Visible = true; // Show the panel

            // Set the CSS class using Attributes collection
            messagePanel.Attributes["class"] = isSuccess ? "message-panel success" : "message-panel error";
        }
    }
}
