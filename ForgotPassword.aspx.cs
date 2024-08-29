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
    public partial class ForgotPassword :Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnPasswordReset_Click(object sender, EventArgs e)
=====
        String str = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\GUSTAV\Source\Repos\Group13Projects\Computer-Tracking-System\App_Data\ComputerTrackerDB.mdf;Integrated Security = True";

        //declare my sql variables
        SqlConnection conn;
        SqlCommand comm;
        SqlDataAdapter adap;
        SqlDataReader read;
        DataSet ds;

        protected void UpdatePasswordBtn_Click(object sender, EventArgs e)
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96
        {
           if(Page.IsValid)
            {
                String UserName = txtUserName.Text.Trim();
                String IdNum = txtIdNum.Text.Trim();
                String Email = txtEmail.Text.Trim();
                String Password = txtPassword.Text.Trim();
                String NewPassword = ConfirmTxt.Text.Trim();

<<<<<<< HEAD
                if(String.IsNullOrEmpty(txtUserName.Text))
                {
                    LblComment.Text = "enter  characters for username";
                    return;
                }
                else if(Password != NewPassword)
                {
                    LblComment.Text = "password do not match";
                }
                else if(Password == NewPassword)
                {
                    LblComment.Text = "Password reset succesfull!";
                }
            }

        }

    }
}



=======
            }







        }
    }
}
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96
