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
            margin: 0;
            overflow-x: hidden; /* Prevent horizontal scrolling */
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
            text-align: center;
            padding: 20px;
            border-radius: 8px;
            background-color: #e9ecef;
            border: 1px solid #ccc;
            margin-top: 20px;
            display: block; /* Initially hidden */
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
            margin: 20px auto;
            width: calc(100% - 40px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #ffffff;
            overflow: hidden;
        }

        .GridView {
            width: 100%;
            border-collapse: collapse;
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
        .display-info {
    padding: 15px;
    border-radius: 5px;
    margin-bottom: 20px;
    font-size: 16px;
    color: #333;
}
        .btn-edit {
    background-color: #007bff;
    color: #ffffff;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.btn-edit:hover {
    background-color: #0056b3;
}

.btn-delete {
    background-color: #dc3545;
    color: #ffffff;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s;
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

.btn-delete:hover {
    background-color: #c82333;
}
.btnFilter{
     background-color: #007bff;
 color: #ffffff;
 border: none;
 padding: 8px 16px;
 border-radius: 5px;
 font-size: 14px;
 cursor: pointer;
 transition: background-color 0.3s;
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

        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
        function showNotification() {
            var Panel1 = document.getElementById("Panel1");
            Panel1.classList.remove("hide"); // Remove hide class if it's there
            Panel1.classList.add("show"); // Add show class to trigger the fade-in and slide-in animation
            Panel1.style.visibility = "visible"; // Ensure the panel is visible during the animation

            // Automatically hide after a certain time (e.g., 3 seconds)
            setTimeout(function () {
                Panel1.classList.remove("show");
                Panel1.classList.add("hide");
            }, 3000); // Adjust timing as needed
        }

    </script>
</head>
<body>
    <header class="header">
        <h1>Learners List</h1>
    </header>
    <div class="container">
        <form id="form1" runat="server">
            <button class="toggle-btn" type="button" onclick="toggleSideTab()">☰ Menu</button>
           
            <div class="side-tab">
                 <br />
 <br />
                <a href="Main.aspx">Home</a>
                <a href="Computers.aspx">Computer Page</a>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="btnLogout_Click" OnClientClick="return confirmLogout();" />
            </div>
  
            <div class="content">
               <asp:Panel ID="Panel1" runat="server" CssClass ="PanelDisplay">
                   <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label></asp:Panel>
                <br />
               

                <div class="search-container">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Enter search term"></asp:TextBox>
                    <asp:DropDownList ID="ddlFilter" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                        <asp:ListItem Text="Select" Value="Null"></asp:ListItem>
                         <asp:ListItem Text="LearnerID" Value="LearnerID"></asp:ListItem>
                        <asp:ListItem Text="First Name" Value="FirstName"></asp:ListItem>
                        <asp:ListItem Text="Last Name" Value="LastName"></asp:ListItem>
                        <asp:ListItem Text="Email" Value="Email"></asp:ListItem>
                        <asp:ListItem Text="ID Number" Value="IdNumber"></asp:ListItem>
                         <asp:ListItem Text="Gender" Value="Gender"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="order" runat="server" AutoPostBack="True" OnSelectedIndexChanged="order_SelectedIndexChanged">
                        <asp:ListItem Text="Order" Value="Null"></asp:ListItem>
                        <asp:ListItem Text="Ascending" Value="Asc"></asp:ListItem>
                        <asp:ListItem Text="Descending" Value="Desc"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnLoadData" runat="server" Text="Load Learners" CssClass="btn" OnClick="btnLoadData_Click" />
                </div>
                <div class="center">
        <asp:Panel runat="server"></asp:Panel>
                    <asp:Button ID="AdvFilters" runat="server" Text="Show Advanced Filters" OnClick="AdvFilters_Click" CssClass="btn" />
                    <asp:Button ID="HideBtn" runat="server" Text="Hide Advanced Filters" OnClick="HideBtn_Click" CssClass="btn" />
                    <asp:Panel ID="filterPanel" runat="server" CssClass="filter-panel">
                        <asp:CheckBox ID="chkName" runat="server" Text="Name" />
                        <asp:CheckBox ID="chkSurname" runat="server" Text="Surname" />
                        <asp:CheckBox ID="chkID" runat="server" Text="ID" />
                        <asp:CheckBox ID="chkEmail" runat="server" Text="Email" />
                        <asp:CheckBox ID="chkDOB" runat="server" Text="DOB" /><asp:Button ID="filterBtn" runat="server" Text="Filter" CssClass="btnFilter" OnClick="filterBtn_Click" />
                    </asp:Panel>
                </div>
              <div class="gridview-container">
    <asp:GridView ID="GridViewLearners" runat="server" AutoGenerateColumns="False" CssClass="GridView" 
        OnRowEditing="GridViewLearners_RowEditing" OnRowCancelingEdit="GridViewLearners_RowCancelingEdit"
        OnRowDeleting="GridViewLearners_RowDeleting" DataKeyNames="LearnerID">
        <Columns>
            <asp:BoundField DataField="LearnerID" HeaderText="LearnerID" />
            <asp:BoundField DataField="IdNumber" HeaderText="ID Number" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
            <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" />
            <asp:TemplateField>
                <ItemTemplate>
                   <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn-edit" CommandName="Edit"  />
                   <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn-delete" CommandName="Delete"  OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
            </div>
        </form>
    </div>
</body>
</html>