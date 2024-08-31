<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Learners.aspx.cs" Inherits="CTS.Learners" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Manage Learners</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eef2f7;
            margin: 0;
            padding: 0;
            color: #2c3e50;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            background-color: white;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 30px;
            position: relative;
        }

        .header {
            background-color: #34495e;
            color: white;
            padding: 20px;
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 05px;
            border-radius: 10px;
        }

        table {
            width: 100%;
            border-spacing: 20px;
        }

        td {
            vertical-align: middle;
        }

        .label {
            font-size: 16px;
            text-align: right;
            padding-right: 10px;
            white-space: nowrap;
        }

        .input {
            padding: 5px;
    font-size: 14px;
    width: 200px;
    box-sizing: border-box; /* Ensures padding and border are included in width and height */
    border: 1px solid #ccc; /* Default border for textboxes */
    transition: border-color 0.3s, background-color 0.3s; /* Smooth transition for highlighting */
        }

        .button-row {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 20px;
        }

        .button {
            background-color: #2980b9;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #3498db;
        }

        .logout-button {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .logout-button:hover {
            background-color: #c0392b;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .link {
            color: #2980b9;
            text-decoration: none;
            font-size: 16px;
            margin: 0 10px;
        }

        .link:hover {
            text-decoration: underline;
        }

        .highlight {
            border: 1px solid #dc3545; /* Red border to indicate error */
            background-color: #f8d7da; /* Light red background */
             width: 200px; /* Set the desired width */
             padding: 5px; /* Add padding */
             font-size: 14px; /* Set the font size */
        }
        .highlightNon {
    border: 1px solid #28a745; /* green border to indicate error */
    background-color: lightgreen; /* Light red background */
     width: 200px; /* Set the desired width */
     padding: 5px; /* Add padding */
     font-size: 14px; /* Set the font size */
}

        .PanelDisplay {
            background-color: #f8f9fa; /* Light background for both success and error */
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 30px;
        }

        .PanelDisplay.success {
            border: 1px solid #28a745; /* Green border for success */
            color: #28a745; /* Green text for success */
        }

        .PanelDisplay.error {
            border: 1px solid #dc3545; /* Red border for error */
            color: #dc3545; /* Red text for error */
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
            }
        }

        .PanelDisplay.show {
            visibility: visible;
            opacity: 1;
            animation: fadeIn 1s ease-in fadeIn;
        }

        .PanelDisplay.hide {
            animation: fadeOut 1s ease-out forwards;
            visibility: hidden; /* Ensure it is hidden after the animation */
        }
    </style>

    <script type="text/javascript">
        function hidePanel() {
            var panel = document.getElementById('<%= Panel1.ClientID %>');
            if (panel) {
                panel.classList.remove('show');
                panel.classList.add('hide');

                // After the animation ends, set the panel to hidden without affecting layout
                panel.addEventListener('animationend', function () {
                    panel.style.visibility = 'hidden'; // Hide the panel while reserving space
                }, { once: true });
            }
        }
    </script>
</head>
<body>
    <form id="AdminForm" runat="server">
      
        <div class="container">
            <asp:Button ID="LogoutBtn" runat="server" Text="Logout" CssClass="logout-button" OnClientClick="return confirmLogout();" OnClick="LogoutBtn_Click" />
            <div class="header">
                Manage Learners
            </div>
              <div class="content">
      <asp:Panel ID="Panel1" runat="server" CssClass="PanelDisplay">
          <asp:Label ID="lblMessage" runat="server"></asp:Label>
      </asp:Panel>
  </div>

            <table>
                <tr>
                    <td class="label"><label for="txtName">Name:</label></td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" CssClass="input" OnTextChanged="txtName_TextChanged" oninput="highlightTextbox(this)"></asp:TextBox></td>
                    <td class="label"><label for="txtSurname">Surname:</label></td>
                    <td><asp:TextBox ID="txtSurname" runat="server" CssClass="input" oninput="highlightTextbox(this)"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="label"><label for="txtEmail">Email:</label></td>
                    <td><asp:TextBox ID="txtEmail" runat="server" CssClass="input" oninput="highlightTextbox(this)"></asp:TextBox></td>
                    <td class="label"><label for="txtPhone">Telephone:</label></td>
                    <td><asp:TextBox ID="txtPhone" runat="server" CssClass="input" oninput="highlightTextbox(this)"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="label"><label for="txtID">ID Number:</label></td>
                    <td><asp:TextBox ID="txtID" runat="server" CssClass="input" oninput="highlightTextbox(this)"></asp:TextBox></td>
                    <td class="label"><label for="txtDOB">Date of Birth:</label></td>
                    <td><asp:TextBox ID="txtDOB" runat="server" type="date" CssClass="input" oninput="highlightTextbox(this)"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="label"><label for="ddlGender">Gender:</label></td>
                    <td>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="input" oninput="highlightTextbox(this)">
                            <asp:ListItem Text="Select Gender" Value="Null" />
                            <asp:ListItem Text="Male" Value="Male" />
                            <asp:ListItem Text="Female" Value="Female" />
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>

            <!-- Buttons -->
            <div class="button-row">
                <asp:Button runat="server" Text="Add Learner" CssClass="button" OnClick="AddLearnerBtn_Click" ID="AddLearnerBtn"></asp:Button>
                <asp:Button ID="btnView" runat="server" Text="View Learner" CssClass="button" OnClick="btnView_Click" />
            </div>

            <!-- Hyperlinks -->
            <div class="links">
                <a href="Main.aspx" class="link">Home</a>
                <a href="Computers.aspx" class="link">Go to Computers</a>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        function highlightTextbox(element) {
            if (element.value.trim() !== "") {
                element.classList.add("highlightNon");
            } else {
                element.classList.remove("highlightNon");
            }
        }
    </script>
 <script type="text/javascript">
        $(document).ready(function () {
            $(".datepicker").datepicker({
                dateFormat: "yyyy-mm-dd", // Format can be changed as needed
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+0" // Limits the year range
            });
        });
</script>
    <!-- JavaScript for additional functionalities -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
    </script>
</body>
</html>
