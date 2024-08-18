using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Data;

namespace CTS
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        String str = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\GUSTAV\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security = True";

        //declare my sql variables
        SqlConnection conn;
        SqlCommand comm;
        SqlDataAdapter adap;
        SqlDataReader read;
        DataSet ds;


        protected void UpdatePasswordBtn_Click(object sender, EventArgs e)
        {
           

            //declare the variables and assign them to the textboxes
            String UserName = txtUserName.Text; 
            String IdNum = txtIdNum.Text;
            String Email = txtEmail.Text.Trim();   
            String Password = txtPassword.Text;


            try
            {
                conn = new SqlConnection(str);
                conn.Open();

                if (UserName != "" && IdNum != "" && Email != "" && Password != "")
                {
                    LblUpdatedPS.Text = "Password updated sucessfully!";
                }


                conn.Close();




            }
            catch (Exception ex)
            {

            }







        }
    }
}