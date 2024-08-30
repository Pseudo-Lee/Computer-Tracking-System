<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Computers.aspx.cs" Inherits="CTS.Computers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Computers Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }
        .header {
            background-color: #2c3e50;
            color: #ffffff;
            padding: 20px 30px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            display: flex;
            flex: 1;
        }
        .sidebar {
            width: 250px;
            background-color: #34495e;
            color: #ffffff;
            padding: 30px 20px;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            transform: translateX(0);
        }
        .sidebar.hide {
            transform: translateX(-100%);
        }
        .sidebar h2 {
            font-size: 20px;
            margin-bottom: 30px;
            font-weight: normal;
        }
        .sidebar .nav-links {
            list-style-type: none;
            padding: 0;
        }
        .sidebar .nav-links li {
            margin-bottom: 15px;
        }
        .sidebar .nav-links a {
            color: #ffffff;
            text-decoration: none;
            font-size: 16px;
            display: block;
            padding: 12px 18px;
            border-radius: 4px;
            transition: background-color 0.3s, transform 0.3s;
        }
        .sidebar .nav-links a:hover {
            background-color: #1abc9c;
            transform: translateX(5px);
        }
        .main-content {
            flex: 1;
            padding: 40px;
            background-color: #ffffff;
            overflow-y: auto;
            box-shadow: inset 0 0 15px rgba(0, 0, 0, 0.05);
            transition: margin-left 0.3s ease;
            margin-left: 250px;
        }
        .main-content.full-width {
            margin-left: 0;
        }
        .toggle-btn {
            position: absolute;
            top: 15px;
            left: 15px;
            background-color: #2c3e50;
            color: #ffffff;
            border: none;
            padding: 10px 15px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            z-index: 1000;
        }
        .toggle-btn:hover {
            background-color: #1abc9c;
        }
        .main-content h1 {
            font-size: 26px;
            margin-bottom: 25px;
            color: #2c3e50;
            font-weight: bold;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
        }
        .section {
            margin-bottom: 40px;
        }
        .section-header {
            font-size: 20px;
            color: #34495e;
            margin-bottom: 20px;
            font-weight: normal;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 10px;
        }
        .form-container {
            display: grid;
            gap: 15px;
        }
        .form-container input, .form-container select {
            padding: 12px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f9f9f9;
        }
        .form-container input:focus, .form-container select:focus {
            outline: none;
            border-color: #2980b9;
        }
        .form-container button {
            padding: 12px;
            border: none;
            border-radius: 4px;
            background-color: #3498db;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        .form-container button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        .gridview-container {
            border-radius: 8px;
            overflow: hidden;
            background-color: #ecf0f1;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .GridView {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }
        .GridView th, .GridView td {
            border-bottom: 1px solid #bdc3c7;
            padding: 12px 15px;
            text-align: left;
        }
        .GridView th {
            background-color: #2c3e50;
            color: #fff;
        }
        .GridView tr:nth-child(even) {
            background-color: #ecf0f1;
        }
        .GridView tr:hover {
            background-color: #bdc3c7;
        }
        .button-container {
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                padding: 20px;
                transform: translateX(-100%);
            }
            .main-content {
                padding: 20px;
                margin-left: 0;
            }
            .main-content.full-width {
                margin-left: 0;
            }
            .toggle-btn {
                left: 10px;
                top: 10px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">Computers Management</div>
        <button class="toggle-btn" type="button" onclick="toggleSidebar()">☰</button>
        <div class="container">
            <div class="sidebar" id="sidebar">
                <h2>Navigation</h2>
                <ul class="nav-links">
                    <li><a href="#assign-section">Assign Computers</a></li>
                    <li><a href="#register-section">Register New Computer</a></li>
                    <li><a href="#view-section">View Computers</a></li>
                </ul>
            </div>
            <div class="main-content" id="mainContent">
                <h1>Manage Computers</h1>

                <!-- Assign Computers Section -->
                <div class="section" id="assign-section">
                    <div class="section-header">Assign Computers</div>
                    <div class="form-container">
                        <asp:Button ID="btnAssignComputer" runat="server" Text="Assign Computer" CssClass="btn" OnClick="btnAssignComputer_Click" />
                        <asp:Panel ID="Panel1" runat="server">
                            <asp:Label ID="Name" runat="server" Text="Label">LearnerName</asp:Label>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>

                             <asp:Label ID="CompNum" runat="server" Text="Label">Computer Number</asp:Label>
 <asp:TextBox ID="CompNumTxt" runat="server"></asp:TextBox>
                            <asp:Button ID="AssignBtn" runat="server" Text="Assign" OnClick="AssignBtn_Click" />

                        </asp:Panel>
                        </div>
                </div>

                <!-- Register New Computer Section -->
                <asp:Panel runat="server"></asp:Panel>
                <div class="section" id="register-section">
                    <div class="section-header">Register New Computer</div>
                    <div class="form-container">
                        <asp:TextBox ID="txtComputerName" runat="server" CssClass="form-control" Placeholder="Computer Name"></asp:TextBox>
                        <asp:TextBox ID="txtComputerType" runat="server" CssClass="form-control" Placeholder="Computer Type"></asp:TextBox>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Available" Value="Available" />
                            <asp:ListItem Text="In Use" Value="In Use" />
                            <asp:ListItem Text="Under Maintenance" Value="Under Maintenance" />
                        </asp:DropDownList>
                        <asp:Button ID="btnRegisterComputer" runat="server" Text="Register Computer" CssClass="btn" OnClick="btnRegisterComputer_Click" />
                    </div>
                </div>

                <!-- View Computers Section -->
                <div class="section" id="view-section">
                    <div class="section-header">View Computers</div>
                    <div class="button-container">
                        <asp:Button ID="btnLoadComputers" runat="server" Text="Load Computers" CssClass="btn" OnClick="btnLoadComputers_Click" />
                    </div>
                    <div class="gridview-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="GridView"></asp:GridView>
                    </div>
                </div>

            </div>
        </div>
    </form>

    <script>
        function toggleSidebar() {
            var sidebar = document.getElementById("sidebar");
            var mainContent = document.getElementById("mainContent");

            sidebar.classList.toggle("hide");
            mainContent.classList.toggle("full-width");
        }
    </script>
</body>
</html>
