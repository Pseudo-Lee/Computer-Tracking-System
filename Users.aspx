<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="CTS.Users" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>User Management</title>
    <link rel="stylesheet" href="styles.css" /> <!-- Optional for custom styles -->
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            color: #0056b3;
        }

        .header, .footer {
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        nav a {
            margin: 0 15px;
            font-size: 16px;
            color: white;
            font-weight: bold;
        }

        nav a.logout {
            color: #ff6b6b;
        }

        nav a:hover {
            color: #0056b3;
        }

        nav a.logout:hover {
            color: #d9534f;
        }

        .footer {
            text-align: center;
            padding: 15px;
            font-size: 14px;
        }

        .footer p {
            margin: 5px 0;
        }

        .footer a {
            color: white;
        }

        .footer a:hover {
            color: #0056b3;
        }

        /* Main Content Styling */
        .main-content {
            padding: 20px;
            margin: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .search-filter-panel {
            margin-bottom: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .search-filter-panel input[type="text"],
        .search-filter-panel select,
        .search-filter-panel .radio-buttons,
        .search-filter-panel .checkbox {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            max-width: 300px;
            box-sizing: border-box;
        }

        .search-filter-panel .radio-buttons label {
            margin-right: 10px;
        }

        .search-filter-panel .checkbox label {
            margin-left: 5px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .user-table th,
        .user-table td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }

        .user-table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .user-table td {
            background-color: #f9f9f9;
        }

        .user-table tr:hover {
            background-color: #f1f1f1;
        }

        .user-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .user-table button {
            padding: 8px 12px;
            font-size: 14px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .user-table button:hover {
            background-color: #0056b3;
        }

        .user-table button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .batch-actions {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
        }

        .batch-actions button {
            padding: 10px 15px;
            font-size: 16px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .batch-actions button:hover {
            background-color: #218838;
        }

        .batch-actions button:last-child {
            background-color: #dc3545;
        }

        .batch-actions button:last-child:hover {
            background-color: #c82333;
        }

        .batch-actions button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h1>User Management</h1>
            <nav>
                <a href="Main.aspx">Home</a>
                <a href="learners.aspx">Dashboard</a>
                <a href="Login.aspx" class="logout">Logout</a>
            </nav>
        </div>

        <div class="main-content">
            <!-- Search & Filter Panel -->
            <div class="search-filter-panel">
                <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search users by name, email, or ID"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

                <asp:RadioButtonList ID="rblFilterRole" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Admins" Value="Admin"></asp:ListItem>
                    <asp:ListItem Text="Non-Admins" Value="NonAdmin"></asp:ListItem>
                </asp:RadioButtonList>

                <asp:DropDownList ID="ddlSortBy" runat="server">
                    <asp:ListItem Text="Name" Value="Name"></asp:ListItem>
                    <asp:ListItem Text="Role" Value="Role"></asp:ListItem>
                    <asp:ListItem Text="Date Added" Value="DateAdded"></asp:ListItem>
                </asp:DropDownList>

                <asp:CheckBox ID="chkShowActive" runat="server" Text="Show only active users" Checked="True" />
            </div>

            <!-- User Table -->
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="user-table"
                OnRowCommand="gvUsers_RowCommand" OnRowEditing="gvUsers_RowEditing" OnRowDeleting="gvUsers_RowDeleting">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkSelectAll" runat="server" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="UserID" HeaderText="User ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Edit" />
                            <asp:Button ID="btnChangeRole" runat="server" CommandName="ChangeRole" Text='<%# Eval("Role").ToString() == "Admin" ? "Demote to User" : "Promote to Admin" %>' CommandArgument='<%# Eval("UserID") %>' />
                            <asp:Button ID="btnRemove" runat="server" CommandName="Delete" Text="Remove" CommandArgument='<%# Eval("UserID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- Batch Actions -->
            <div class="batch-actions">
                <asp:Button ID="btnChangeRoleBulk" runat="server" Text="Change Role for Selected" OnClick="btnChangeRoleBulk_Click" />
                <asp:Button ID="btnRemoveSelected" runat="server" Text="Remove Selected" OnClick="btnRemoveSelected_Click" />
                <asp:Button ID="btnToggleActive" runat="server" Text="Activate/Deactivate Selected" OnClick="btnToggleActive_Click" />
            </div>
        </div>

        <div class="footer">
            <p>© CTS 2024</p>
            <a href="PrivacyPolicy.aspx">Privacy Policy</a> | 
            <a href="TermsOfService.aspx">Terms of Service</a>
        </div>
    </form>
</body>
</html>
