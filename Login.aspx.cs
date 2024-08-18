using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Login : System.Web.UI.Page
    {
<<<<<<< HEAD
        // Connecting to the database
        SqlConnection conn = new SqlConnection("""Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename="C:\Users\User\OneDrive-North-West University\Documents\COMPUTER TRACKING SYSTEM\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf";Integrated Security=True""");

        protected void Page_Load(object sender, EventArgs e)
        {
            MessageLabel.Visible = false;
            if (!IsPostBack)
            {
                try
                {
                    conn.Open();
                    if (conn.State == ConnectionState.Open)
                    {
                        // Connection successful
                        Response.Write("""<script>alert('Connection successful.');</script>""");
                    }
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    MessageLabel.Text = """Connection error: """ + ex.Message;
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    MessageLabel.Visible = true;
                }
                finally
                {
                    conn.Close();
                }
            }
=======
        protected void Page_Load(object sender, EventArgs e)
        {
            
>>>>>>> a8d51d3f56bf5f3cede9ee1d9950cf6a6dc4b058
        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
<<<<<<< HEAD
          
        }

        protected System.Void LoginBtn_Click(System.Object sender, System.EventArgs e)
        {
            string username = TextBox1.Text;
            string password = TextBox2.Text;

            try
            {
                conn.Open();

                // SQL Command
                string query = """SELECT COUNT(*) FROM [User] WHERE Name=@Name AND Password=@Password""";
                SqlCommand comm = new SqlCommand(query, conn);

                // Adding Parameters to prevent SQL Injection
                comm.Parameters.AddWithValue("""@Name""", username);
                comm.Parameters.AddWithValue("""@Password""", password);

                int count = Convert.ToInt32(comm.ExecuteScalar());

                if (count > 0)
                {
                    // User found, proceed to next step
                    Response.Write("""<script>alert('Login Successful');</script>""");
                }
                else
                {
                    // User not found
                    Response.Write("""<script>alert('Login Unsuccessful');</script>""");
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write("""<script>alert('Error searching for user: """ + ex.Message.Replace("""'""", """\'""") + """');</script>""");
            }
            finally
            {
                conn.Close();
            }
=======

>>>>>>> a8d51d3f56bf5f3cede9ee1d9950cf6a6dc4b058
        }
    }
}