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

        protected void btnLoadData_Click(object sender, EventArgs e)
        {
            string query = "SELECT LearnerID, FirstName, LastName, DateOfBirth, University, TelephoneNo, EmailAddress, IdNumber FROM Student";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GridViewLearners.DataSource = dt;
                    GridViewLearners.DataBind();
                    if(dt.Rows.Count <= 0)
                    {
                        Response.Write("<script>alert('Unable to find data');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Successfully retrieved learners from data base');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }

        protected void GridViewLearners_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
