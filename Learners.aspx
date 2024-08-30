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
            margin-bottom: 30px;
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
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%;
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

        /* Modal styles */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
            max-width: 500px;
            border-radius: 5px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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
    </style>
    <script>
        function showModal(message) {
            var modal = document.getElementById("myModal");
            var modalText = document.getElementById("modalText");
            modalText.textContent = message;
            modal.style.display = "block";
        }

        function closeModal() {
            var modal = document.getElementById("myModal");
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            var modal = document.getElementById("myModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
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

            <table>
                <tr>
                    <td class="label"><label for="txtName">Name:</label></td>
                    <td><asp:TextBox ID="txtName" runat="server" CssClass="input"></asp:TextBox></td>
                    <td class="label"><label for="txtSurname">Surname:</label></td>
                    <td><asp:TextBox ID="txtSurname" runat="server" CssClass="input"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="label"><label for="txtEmail">Email:</label></td>
                    <td><asp:TextBox ID="txtEmail" runat="server" CssClass="input"></asp:TextBox></td>
                    <td class="label"><label for="txtPhone">Telephone:</label></td>
                    <td><asp:TextBox ID="txtPhone" runat="server" CssClass="input"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="label"><label for="txtID">ID Number:</label></td>
                    <td><asp:TextBox ID="txtID" runat="server" CssClass="input"></asp:TextBox></td>
                    <td class="label"><label for="txtDOB">Date of Birth:</label></td>
                    <td><asp:TextBox ID="txtDOB" runat="server" CssClass="input"></asp:TextBox></td>
                </tr>
                <td class="label"><label for="ddlGender">Gender:</label></td>
    <td>
        <asp:DropDownList ID="ddlGender" runat="server" CssClass="input">
            <asp:ListItem Text="Select Gender" Value="Null" />
            <asp:ListItem Text="Male" Value="Male" />
            <asp:ListItem Text="Female" Value="Female" />
        </asp:DropDownList>
    </td>
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

    <!-- Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <p id="modalText"></p>
        </div>
    </div>
        
</body>
</html>
