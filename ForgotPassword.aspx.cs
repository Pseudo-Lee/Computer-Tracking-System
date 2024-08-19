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
            String username = txtUserName.Text;
            String IdNum = txtIdNum.Text;
            String Email = txtEmail.Text.Trim();
            String NewPassword = txtPassword.Text;
            String password = txtConfirmPassword.Text;




            // Hash the password before storing (optional but recommended)
            // string hashedPassword = HashPassword(password);

            // Update the password in the database
            //string connectionString = ConfigurationManager.ConnectionStrings["Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=C:\\Users\\GUSTAV\\Source\\Repos\\Group13Projects\\Computer-Tracking-System\\App_Data\\ComputerTrackerDB.mdf;Integrated Security = True\""].ConnectionString;


            SqlConnection conn = new SqlConnection(str);
           // SqlCommand comm = new SqlCommand("SELECT * FROM [USER] WHERE ";




            }
        
    }
}