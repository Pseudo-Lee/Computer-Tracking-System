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

        protected void BtnPasswordReset_Click(object sender, EventArgs e)
        {
           if(Page.IsValid)
            {
                String UserName = txtUserName.Text.Trim();
                String IdNum = txtIdNum.Text.Trim();
                String Email = txtEmail.Text.Trim();
                String Password = txtPassword.Text.Trim();
                String NewPassword = ConfirmTxt.Text.Trim();

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



