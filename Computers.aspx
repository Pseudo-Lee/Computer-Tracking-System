<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Computers.aspx.cs" Inherits="CTS.Computers" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Computers Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header {
            background-color: #2c3e50;
            color: #ffffff;
            padding: 15px 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .container {
            display: flex;
            flex: 1;
        }
        .sidebar {
            width: 250px;
            background-color: #34495e;
            color: #ffffff;
            padding: 20px;
            box-shadow: 2px 0 8px rgba(0, 0, 0, 0.1);
        }
        .sidebar h2 {
            font-size: 22px;
            margin-bottom: 30px;
            font-weight: normal;
        }
        .sidebar .nav-links {
            list-style-type: none;
            padding: 0;
        }
        .sidebar .nav-links li {
            margin-bottom: 20px;
        }
        .sidebar .nav-links a {
            color: #ffffff;
            text-decoration: none;
            font-size: 18px;
            display: block;
            padding: 10px 15px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .sidebar .nav-links a:hover {
            background-color: #1abc9c;
        }
        .main-content {
            flex: 1;
            padding: 40px;
            background-color: #ffffff;
            overflow-y: auto;
        }
        .main-content h1 {
            font-size: 28px;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: bold;
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
            gap: 20px;
        }
        .form-container input, .form-container select {
            padding: 12px;
            border: 1px solid #bdc3c7;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-container button {
            padding: 12px;
            border: none;
            border-radius: 4px;
            background-color: #3498db;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .form-container button:hover {
            background-color: #2980b9;
        }
        .gridview-container {
            border-radius: 8px;
            overflow: hidden;
            background-color: #ecf0f1;
            padding: 20px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">Computers Management</div>
        <div class="container">
            <div class="sidebar">
                <h2>Navigation</h2>
                <ul class="nav-links">
                    <li><a href="#assign-section">Assign Computers</a></li>
                    <li><a href="#register-section">Register New Computer</a></li>
                    <li><a href="#view-section">View Computers</a></li>
                </ul>
            </div>
            <div class="main-content">
                <h1>Manage Computers</h1>

                <!-- Assign Computers Section -->
                <div class="section" id="assign-section">
                    <div class="section-header">Assign Computers</div>
                    <div class="form-container">
                        <asp:DropDownList ID="ddlStudents" runat="server" CssClass="form-control">
                            <!-- Populate with student names from database -->
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlComputers" runat="server" CssClass="form-control">
                            <!-- Populate with available computers from database -->
                        </asp:DropDownList>
                        <asp:Button ID="btnAssignComputer" runat="server" Text="Assign Computer" CssClass="btn" OnClick="btnAssignComputer_Click" />
                    </div>
                </div>

                <!-- Register New Computer Section -->
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
                        <asp:GridView ID="GridViewComputers" runat="server" AutoGenerateColumns="False" CssClass="GridView" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True" DataKeyNames="ComputerID">
                            <Columns>
                                <asp:BoundField DataField="ComputerID" HeaderText="Computer ID" InsertVisible="False" ReadOnly="True" SortExpression="ComputerID" />
                                <asp:BoundField DataField="ComputerName" HeaderText="Computer Name" SortExpression="ComputerName" />
                                <asp:BoundField DataField="ComputerType" HeaderText="Type" SortExpression="ComputerType" />
                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" SortExpression="AssignedTo" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="dtComputers" runat="server" ConnectionString="<%$ ConnectionStrings:connection %>" SelectCommand="SELECT * FROM Computers"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
