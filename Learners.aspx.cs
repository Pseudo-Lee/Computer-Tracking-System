using System;
using System.Data.SqlClient;
using System.Diagnostics.Eventing.Reader;
using System.Web.UI;

namespace CTS
{
    public partial class Learners : Page
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
            // Attempt to open a connection to the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    // Connection successful
                }
                catch (Exception ex)
                {
                    // Handle connection error
                    ShowMessage($"Connection error: {ex}", false);
                }
            }
        }

        protected void AddLearnerBtn_Click(object sender, EventArgs e)
        {
            bool hasError = false;

            // Reset previous highlights
            ResetFieldHighlights();

            // Validate all input fields
            hasError = ValidateFields();

            if (hasError)
            {
                ShowMessage("Please enter all fields", false);
                return;
            }

            // Parse DateOfBirth into a DateTime object
            DateTime dob;
            string[] formats = {
        "dd/MM/yyyy", "MM/dd/yyyy", "yyyy-MM-dd", "d/M/yyyy", "M/d/yyyy", "yyyy-M-d",
        "dd-MM-yyyy", "MM-dd-yyyy", "d-M-yyyy", "M-d-yyyy", "dd MMM yyyy", "MMM dd, yyyy"
    };

            if (!DateTime.TryParseExact(txtDOB.Text, formats, System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out dob))
            {
                txtDOB.CssClass = "highlight"; // Highlight if the date format is invalid
                ShowMessage("Error: Invalid Date format", false);
                return;
            }

            // If the date is valid, continue processing
            txtDOB.CssClass = ""; // Remove highlight if any
            ShowMessage("Date is valid", true);

            // Validate the first 6 digits of the IdNumber against DateOfBirth
            if (!ValidateIdNumber(txtID.Text, dob))
            {
                txtID.CssClass = "highlight"; // Highlight if the ID doesn't match the DOB
                ShowMessage("Error: First 6 digits do not match Date of birth. Please check DOB or ID number", false);
                return;
            }

            // Validate gender based on the SSSS portion of the ID number
            string genderType = ddlGender.SelectedValue;
            if (!ValidateGender(txtID.Text, genderType))
            {
                ddlGender.CssClass += " highlight";
                ShowMessage("Gender does not match ID constraint.", false);
                return;
            }

            // Stores gender value
            string genderValue = ddlGender.SelectedValue == "Male" ? "M" : "F";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "INSERT INTO [Student] (FirstName, LastName, DateOfBirth, TelephoneNo, EmailAddress, IdNumber, Gender) " +
                                   "VALUES (@FirstName, @LastName, @DateOfBirth, @TelephoneNo, @EmailAddress, @IdNumber, @Gender)";

                    using (SqlCommand comm = new SqlCommand(query, conn))
                    {
                        comm.Parameters.AddWithValue("@FirstName", txtName.Text);
                        comm.Parameters.AddWithValue("@LastName", txtSurname.Text);
                        comm.Parameters.AddWithValue("@DateOfBirth", dob);
                        comm.Parameters.AddWithValue("@TelephoneNo", txtPhone.Text);
                        comm.Parameters.AddWithValue("@EmailAddress", txtEmail.Text);
                        comm.Parameters.AddWithValue("@IdNumber", txtID.Text);
                        comm.Parameters.AddWithValue("@Gender", genderValue);

                        int rowsAffected = comm.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            ShowMessage("Successfully added learner", true);

                            // Clear textboxes and reset dropdown
                            txtName.Text = "";
                            txtSurname.Text = "";
                            txtEmail.Text = "";
                            txtPhone.Text = "";
                            txtID.Text = "";
                            txtDOB.Text = "";
                            ddlGender.SelectedIndex = 0; // Reset to default option
                        }
                        else
                        {
                            ShowMessage("Error adding learner", false);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage($"Error: {ex.Message}. Please contact Support.", false);
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            Panel1.Visible = true; // Show the panel

            // Set inline styles directly for debugging
            Panel1.Style.Add("background-color", isSuccess ? "#d4edda" : "#f8d7da");
            Panel1.Style.Add("border", isSuccess ? "1px solid #28a745" : "1px solid #dc3545");
            Panel1.Style.Add("color", isSuccess ? "#155724" : "#721c24");
            ScriptManager.RegisterStartupScript(this, GetType(), "HidePanel", "setTimeout(function() { hidePanel(); }, 3000);", true);
        }
        private bool ValidateFields()
        {
            bool hasError = false;

            if (string.IsNullOrEmpty(txtName.Text))
            {
                txtName.CssClass = "highlight";
                hasError = true;
            }
            else
            {
                
            }

            if (string.IsNullOrEmpty(txtSurname.Text))
            {
                txtSurname.CssClass = "highlight";
                hasError = true;
            }
            else
            {
               
            }

            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                txtEmail.CssClass = "highlight";
                hasError = true;
            }

            if (string.IsNullOrEmpty(txtPhone.Text))
            {
                txtPhone.CssClass = "highlight";
                hasError = true;
            }

            if (string.IsNullOrEmpty(txtID.Text))
            {
                txtID.CssClass = "highlight";
                hasError = true;
            }

            if (string.IsNullOrEmpty(txtDOB.Text))
            {
                txtDOB.CssClass = "highlight";
                hasError = true;
            }

            return hasError;
        }

        private bool ValidateIdNumber(string idNumber, DateTime dob)
        {
            if (idNumber.Length < 12)
            {
                return false; // ID number is too short
            }

            // Extract the first 6 digits of the ID number
            string idDatePart = idNumber.Substring(0, 6);
            string idYear = idNumber.Substring(0, 2);

            /*if(idYear = int.TryParse(idYear, out int Year)
             {


                }*/
            // Convert the DateOfBirth to YYMMDD format
            string dobPart = dob.ToString("yyMMdd");

            // Compare the ID part with the DateOfBirth part
            return idDatePart == dobPart;
        }

        private bool ValidateGender(string idNumber, string genderType)
        {
            string ssssPart = idNumber.Substring(6, 4);
            int ssssNumber = int.Parse(ssssPart);

            return (genderType == "Male" && ssssNumber >= 5000) || (genderType == "Female" && ssssNumber < 5000);
        }

        private void ResetFieldHighlights()
        {
            txtName.CssClass = txtSurname.CssClass = txtEmail.CssClass = txtPhone.CssClass = txtID.CssClass = txtDOB.CssClass = "";
        }

       /* private void DisplayAlert(string message, bool isSuccess = true)
        {
            message = message.Replace("'", "\\'");

            // Create the script to call showModal
            string script = $"showModal('{message}', {isSuccess.ToString().ToLower()});";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowModal", script, true);
        }*/

        protected void btnView_Click(object sender, EventArgs e)
        {
            // Redirect to the ViewLearners page
            Response.Redirect("ViewLearners.aspx");
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            // Redirect to the login page on logout
            Response.Redirect("Login.aspx");
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            txtName.CssClass = "highlightNon";// when text is changed,textbox becomes green
        }
    }
}
