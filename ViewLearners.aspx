<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewLearners.aspx.cs" Inherits="CTS.ViewLearners" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Learners List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            padding: 0;
            margin: 0;
            overflow-x: auto; /* Prevent horizontal scrolling */
        }

        .container {
            display: flex;
        }

        .side-tab {
            width: 250px;
            background-color: #666666;
            color: #ffffff;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            padding-top: 20px;
            box-sizing: border-box;
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .side-tab.show {
            transform: translateX(0);
        }

        .side-tab a, .side-tab button {
            display: block;
            color: #ffffff;
            background-color: #888888;
            padding: 15px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 18px;
            margin: 10px 0;
            transition: background-color 0.3s;
        }

        .side-tab a:hover, .side-tab button:hover {
            background-color: #666666;
        }

        .toggle-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            background-color: #0056b3;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            z-index: 1000;
        }

        .content {
            margin-left: 250px; /* Match the width of .side-tab */
            padding: 20px;
            width: calc(100% - 250px); /* Match the width of .side-tab */
            box-sizing: border-box;
        }

        .header {
            background-color: #666666;
            color: #ffffff;
            padding: 20px;
            text-align: center;
            width: 100%;
            position: relative; /* Changed from page */
            box-sizing: border-box;
        }

        .header h1 {
            font-size: 36px;
            margin: 0;
        }

        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-container input, .search-container select {
            padding: 10px;
            font-size: 16px;
            margin-right: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .btn {
            background-color: #0056b3;
            color: #ffffff;
            padding: 12px 24px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #003d7a;
        }

        .panel-container {
            text-align: center;
            margin-top: 20px;
        }

        .filter-panel {
          /* Hidden by default */
            text-align: center;
            padding: 20px;
            border-radius: 8px;
            background-color: #e9ecef;
            border: 1px solid #ccc;
            margin-top: 20px;
        }

        .filter-panel input {
            display: inline-block;
            margin: 10px;
            border-radius: 8px;
            background-color: #ffffff;
            border: 1px solid #ccc;
            text-align: center;
        }

        .gridview-container {
            margin: 20px auto; /* Added margin to ensure spacing from other elements */
            width: calc(100% - 20px); /* Adjust width as needed */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #ffffff;
            overflow: hidden; /* Adjust if content overflows */
        }

        .GridView {
            width: 100%;
            border-collapse: collapse;
            table-layout: auto; /* Ensure proper layout */
        }

        .GridView th, .GridView td {
            border-bottom: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }

        .GridView th {
            background-color: #0056b3;
            color: #ffffff;
        }

        .GridView tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .GridView tr:hover {
            background-color: #e9ecef;
        }

        .label-toggle {
            cursor: pointer;
            color: #0056b3;
            text-decoration: underline;
        }

        .center {
            text-align: center;
        }
    </style>
    <script>
        function toggleSideTab() {
            var sideTab = document.querySelector('.side-tab');
            sideTab.classList.toggle('show');
        }

        function toggleFilterPanel() {
            var filterPanel = document.querySelector('.filter-panel');
            filterPanel.style.display = filterPanel.style.display === 'none' ? 'block' : 'none';
        }
    </script>
    <script type="text/javascript">
        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
    </script>
</head>
<body>
    <header class="header">Learners List</header>
    <div class="container">
        <form id="form1" runat="server">
            <button class="toggle-btn" type="button" onclick="toggleSideTab()">☰ Menu</button>
            <div class="side-tab">
                <br />
                <br />
                <br />
                <a href="Main.aspx">Home</a>
                <a href="Computers.aspx">Computer Page</a>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="btnLogout_Click" OnClientClick="return confirmLogout();" />
            </div>
            <div class="content">
                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Enter search term"></asp:TextBox>
                    <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                        <asp:ListItem Text="Select" Value="Null"></asp:ListItem>
                        <asp:ListItem Text="First Name" Value="FirstName"></asp:ListItem>
                        <asp:ListItem Text="Last Name" Value="LastName"></asp:ListItem>
                        <asp:ListItem Text="Email" Value="Email"></asp:ListItem>
                        <asp:ListItem Text="ID Number" Value="IdNumber"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="order" runat="server" AutoPostBack="True" OnSelectedIndexChanged="order_SelectedIndexChanged">
                        <asp:ListItem Text="Order" Value="Null"></asp:ListItem>
                        <asp:ListItem Text="Ascending" Value="Asc"></asp:ListItem>
                        <asp:ListItem Text="Descending" Value="Desc"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnLoadData" runat="server" Text="Load Learners" CssClass="btn" OnClick="btnLoadData_Click" />
                </div>
                <div class="center">
                    <asp:Button ID="AdvFilters" runat="server" Text="Show Advanced Filters" OnClick="AdvFilters_Click" CssClass="btn" />
                    <asp:Button ID="HideBtn" runat="server" Text="Hide Advanced Filters" OnClick="HideBtn_Click" CssClass="btn" />
                    <br />
                     <asp:Panel ID="filterPanel" runat="server" CssClass="filter-panel">
     <asp:CheckBox ID="chkName" runat="server" Text="Name" />
     <asp:CheckBox ID="chkSurname" runat="server" Text="Surname" />
     <asp:CheckBox ID="chkID" runat="server" Text="ID" />
     <asp:CheckBox ID="chkEmail" runat="server" Text="Email" />
     <asp:CheckBox ID="chkDOB" runat="server" Text="DOB" />
 </asp:Panel>
                </div>
               
                <div class="gridview-container">
                    <asp:GridView ID="GridViewLearners" runat="server" AutoGenerateColumns="False" CssClass="GridView" AutoGenerateEditButton="True" AutoGenerateDeleteButton="True" OnRowEditing="GridViewLearners_RowEditing" OnRowUpdating="GridViewLearners_RowUpdating" OnRowCancelingEdit="GridViewLearners_RowCancelingEdit" DataKeyNames="LearnerID" OnSelectedIndexChanged="GridViewLearners_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="LearnerID" HeaderText="Learner ID" />
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                            <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
                            <asp:BoundField DataField="IdNumber" HeaderText="ID Number" />
                             <asp:BoundField DataField="Gender" HeaderText="Gender" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
