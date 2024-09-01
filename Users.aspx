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
            position: relative;
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

        /* Pop-up Panel Styling */
       .popup-panel {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    display:none;
}

.popup-content {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    text-align: center;
}

.popup-content button {
    margin-top: 10px;
}

        .popup-content button {
            margin-top: 15px;
            padding: 10px 15px;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .popup-content button:hover {
            background-color: #0056b3;
        }
           .PanelDisplay {
    background-color: #f8f9fa; /* Light background for both success and error */
    border-radius: 5px;
    padding: 10px;
    margin-top: 1px;
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

/* Apply the fade-in effect */
.PanelDisplay.show {
    visibility: visible;
    opacity: 1;
    animation: fadeIn 1s ease-in fadeIn;
}

/* Apply the fade-out effect */
.PanelDisplay.hide {
    animation: fadeOut 1s ease-out forwards;
    visibility: hidden; /* Ensure it is hidden after the animation */
}
/* GridView Button Styling */
.user-table .edit-button,
.user-table .delete-button {
    padding: 8px 12px;
    font-size: 14px;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
    text-align: center;
    display: inline-block;
}

.user-table .edit-button {
    background-color: #28a745; /* Green for Edit */
}

.user-table .edit-button:hover {
    background-color: #218838;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}

.user-table .edit-button:disabled {
    background-color: #6c757d; /* Gray for disabled */
    cursor: not-allowed;
}

.user-table .delete-button {
    background-color: #dc3545; /* Red for Delete */
}

.user-table .delete-button:hover {
    background-color: #c82333;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}

.user-table .delete-button:disabled {
    background-color: #6c757d; /* Gray for disabled */
    cursor: not-allowed;
}
.btn{
    background-color: dodgerblue;
color: #ffffff;
border: none;
padding: 12px 20px;
border-radius: 6px;
cursor: pointer;
font-size: 16px;
margin: 0 8px;
transition: background-color 0.3s ease;
}
.btn-delete{
    background-color: indianred;
color: #ffffff;
border: none;
padding: 12px 20px;
border-radius: 6px;
cursor: pointer;
font-size: 16px;
margin: 0 8px;
transition: background-color 0.3s ease;
}
.btn-delete:hover{
    background-color:red;
}
.btn:hover{
    background-color:midnightblue;
}

    </style>
    <script>
        function showPopup(message) {
            document.getElementById('popupMessage').innerText = message;
            document.getElementById('popupPanel').style.display = 'flex';
        }

        function hidePopup() {
            document.getElementById('popupPanel').style.display = 'none';
        }

    </script>
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
         function confirmLogout() {
             return confirm("Are you sure you want to log out?");
         }
     </script>
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="header">
            <h1>User Management</h1>
            <nav>
                <a href="Main.aspx">Home</a>
                <a href="learners.aspx">Dashboard</a>
                <a href="Login.aspx" class="logout" OnClientClick="return confirmLogout();" >Logout</a>
            </nav>
        </div>

        <div class="main-content">
            <!-- Search & Filter Panel -->
            <asp:Panel ID="Panel1" runat="server" CssClass ="PanelDisplay">
    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label></asp:Panel>
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
                OnRowCommand="gvUsers_RowCommand" OnRowEditing="gvUsers_RowEditing" OnRowDeleting="gvUsers_RowDeleting" DataKeyNames="UserID" >
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
                    <asp:BoundField DataField="Role" HeaderText="Admin" />
                    <asp:BoundField DataField="DateAdded" HeaderText="Date Added" DataFormatString="{0:yyyy-MM-dd}" />
                  <asp:TemplateField>
    <ItemTemplate>
        <asp:Button ID="btnEdit" runat="server" CommandName="Edit" CssClass="edit-button" Text="Edit" />
        <asp:Button ID="btnDelete" runat="server" CommandName="Delete" CssClass="delete-button" Text="Delete"   OnClientClick="return confirm('Are you sure you want to delete this record?');" />
    </ItemTemplate>
</asp:TemplateField>
               
                </Columns>
            </asp:GridView>

            <!-- Batch Actions -->
            <div class="batch-actions">
                <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected" OnClick="btnDeleteSelected_Click" CssClass ="btn-delete"/>
                <asp:Button ID="btnExport" runat="server" Text="Export to CSV" OnClick="btnExport_Click" CssClass ="btn"/>
            </div>
        </div>

        <div class="footer">
            <p>&copy; 2024 CTS. All Rights Reserved.</p>
            <p><a href="privacy-policy.html">Privacy Policy</a> | <a href="terms-of-service.html">Terms of Service</a></p>
        </div>

        <!-- Pop-up Panel -->
        <div id="popupPanel" class="popup-panel">
            <div class="popup-content">
                <p id="popupMessage">fhghg</p>
                <button onclick="hidePopup()">Close</button>
            </div>
        </div>
    </form>
</body>
</html>
