using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace CTS
{
    public partial class SignUp : System.Web.UI.Page
    {
        string str = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\leseg\source\repos\Group13Projects\Computer-Tracking-System\App_Data\CTS.mdf;Integrated Security=True";
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader rdr;
        SqlDataAdapter adapter;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {

           
        }


        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            
            string name = TextBoxName.Text;
            string surname = TextBoxSurname.Text;
            string email = TextBoxEmail.Text;
            string idnumber = TextBoxID.Text;
            string cellphone = TextBoxCellphone.Text;
            string password = TextBoxPassword.Text;
            string confirmPassword = TextBoxConfirmPassword.Text;

            SqlConnection con = new SqlConnection(str);
            
            String query = "INSERT INTO [User] (name,password) VALUES (@name ,@password )";

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name",name);
                //cmd.Parameters.AddWithValue("@surname", surname);
                //cmd.Parameters.AddWithValue("@email", email);
                //cmd.Parameters.AddWithValue("@idnumber", idnumber);
                //cmd.Parameters.AddWithValue("@cellphone", cellphone);
                cmd.Parameters.AddWithValue("@password", password);
                //cmd.Parameters.AddWithValue("@confirmPassword", confirmPassword);
                cmd.ExecuteNonQuery();
                Response.Redirect("Login.aspx", false);



                //if (password == confirmPassword)
                {

                }
                //else
                {
                    //TextBoxConfirmPassword.Text = string.Empty;
                    //TextBoxConfirmPassword.Focus();
                }
            }
            catch(Exception ex) 
            {
                MessageBox.Show("Error" + ex.Message);
            }
        }

       

        

       
    }
}
