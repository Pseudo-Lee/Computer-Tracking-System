using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CTS
{
    public partial class Login : System.Web.UI.Page
    {
        // Connecting to the database
        SqlConnection conn = new SqlConnection(@"Data Source=MR-LEE\SQLEXPRESS;Initial Catalog=C:\USERS\USER\SOURCE\REPOS\CTS\APP_DATA\COMPUTERTRACKERDB.MDF;Integrated Security=True;TrustServerCertificate=True");
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
                        Response.Write(" < script>alert('Connection successful.');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Handle connection error (optional)
                    MessageLabel.Text = "Connection error: " + ex.Message;
                    MessageLabel.ForeColor = System.Drawing.Color.Red;
                    MessageLabel.Visible = true;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            string username = TextBox1.Text;
            string password = TextBox2.Text;

            try
            {
                conn.Open();

                // SQL Command
                string query = "SELECT * FROM User WHERE Name=@Name AND Password=@Password";
                SqlCommand comm = new SqlCommand(query, conn);

                // Adding Parameters to prevent SQL Injection
                comm.Parameters.AddWithValue("@Name", username);
                comm.Parameters.AddWithValue("@Password", password);

                int count = Convert.ToInt32(comm.ExecuteScalar());


                if (count > 0)
                {
                    // User found, proceed to next step
                    Response.Write("<script>alert('Login Successful');</script>");
                }
                else
                {
                    // User not found
                    Response.Write("<script>alert('Login UnSuccessful');</script>");
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write("<script>alert('Error Searching for User');</script>");
                
            }
            finally
            {
                conn.Close();
            }
        }

    }
}
