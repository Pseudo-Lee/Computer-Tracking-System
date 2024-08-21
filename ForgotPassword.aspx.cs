using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Data;
using Microsoft.JScript;
using System.Configuration;
using System.Net.PeerToPeer;

namespace CTS
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /*
        String str = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\GUSTAV\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security = True";

        //declare my sql variables
        SqlConnection conn;
        SqlCommand comm;
        SqlDataAdapter adap;
        SqlDataReader read;
        DataSet ds;


        protected void BtnPasswordReset_Click(object sender, EventArgs e)
        {


            //declare the variables and assign them to the textboxes
            String username = txtUserName.Text.Trim();
            String IdNum = txtIdNum.Text.Trim();
            String Email = txtEmail.Text.Trim();
            String NewPassword = txtPassword.Text.Trim();
            // String password= txtConfirmPassword.Text.Trim();

            /*  if(username == "" || IdNum =="" || Email =="" || NewPassword =="" || password =="")
              {
                 // LblUpdatedPS.Text = " please enter your information to reset password";
              }

              LblComment.Text = " please enter your information to reset password";
              Response.Write("<script>alert('Please enter correct information');</script<");
          }
            




            // Hash the password before storing (optional but recommended)
            // string hashedPassword = HashPassword(password);

            // Update the password in the database
            //string connectionString = ConfigurationManager.ConnectionStrings["Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\GUSTAV\\Source\\Repos\\Group13Projects\\Computer-Tracking-System\\App_Data\\ComputerTrackerDB.mdf;Integrated Security = True\""].ConnectionString;


            // SqlConnection conn = new SqlConnection(str);
            // SqlCommand comm = new SqlCommand("SELECT * FROM [USER] WHERE ";




        */

        }


    }
