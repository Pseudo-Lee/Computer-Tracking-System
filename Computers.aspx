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
        .auto-style1 {
            margin-bottom: 40px;
            height: 297px;
        }
        .auto-style2 {
            display: grid;
            gap: 15px;
            height: 231px;
        }
        .auto-style3 {
            width: 74%;
            height: 171px;
            margin-top: 0px;
        }
        .auto-style4 {
            width: 199px;
        }
        .auto-style5 {
            text-align: center;
        }
    </style>
    <style>
        .good-news {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .bad-news {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
    </style>
    <style>
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

</style>
    <style>
        /* GridView Styling */
.gridview {
    width: 100%;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
    margin-top: 20px;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.gridview th, .gridview td {
    padding: 12px 15px;
    text-align: left;
}

.gridview th {
    background-color: #007bff;
    color: #ffffff;
    font-weight: bold;
    border-bottom: 2px solid #dddddd;
}

.gridview td {
    background-color: #f9f9f9;
    border-bottom: 1px solid #dddddd;
    color: #333333;
}

.gridview tr:nth-child(even) td {
    background-color: #f1f1f1;
}

.gridview tr:hover td {
    background-color: #e0e0e0;
}

.gridview .btn-primary {
    background-color: #007bff;
    color: #ffffff;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    transition: background-color 0.3s ease;
}

.gridview .btn-primary:hover {
    background-color: #0056b3;
}

.gridview th, .gridview td:first-child {
    border-radius: 0;
}

.gridview td:last-child {
    text-align: center;
}

.gridview th:first-child {
    border-radius: 8px 0 0 0;
}

.gridview th:last-child {
    border-radius: 0 8px 0 0;
}

.gridview tr:last-child td:first-child {
    border-radius: 0 0 0 8px;
}

.gridview tr:last-child td:last-child {
    border-radius: 0 0 8px 0;
}
/* Style for the DropDownList */
.orderlist {
    display: inline-block; /* Ensure the dropdown doesn't stretch across the entire width */
    padding: 8px 12px;
    font-size: 14px;
    color: #333;
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
    outline: none;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    left: 20px; /* Adjust this value to move it further to the right */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Adds a subtle shadow effect */
}

/* Style for the DropDownList when focused */
.orderlist:focus {
    border-color: #007bff;
    box-shadow: 0 2px 4px rgba(0, 123, 255, 0.25);
}

/* Style for the DropDownList when hovered */
.orderlist:hover {
    border-color: #888;
}

/* Style for the DropDownList items */
.orderlist option {
    padding: 8px;
    font-size: 14px;
}

/* Optional: Style for dropdown arrow */
.orderlist {
    background: linear-gradient(to bottom, #fff 0%, #f9f9f9 100%);
    background-image: url('data:image/svg+xml;charset=UTF-8,%3Csvg viewBox="0 0 10 6" xmlns="http://www.w3.org/2000/svg"%3E%3Cpath d="M5 6l5-5H0z" fill="%23333"/%3E%3C/svg%3E');
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 12px;
}



    </style>
</head>
<body>
    <form runat ="server">
    <div class="header">
        Computers Management
    </div>
                                <asp:Panel ID="panel" runat="server" CssClass ="PanelDisplay">
<asp:Label ID="lblMessage" runat="server" Text=""></asp:Label></asp:Panel>
    <div class="container">
        <div class="sidebar">
            <button class="toggle-btn" onclick="toggleSidebar()">☰ Menu</button>
            <br />
            <br />
            <h2>Navigation</h2>
            <ul class="nav-links">
                <li><a href="Computers.aspx">Home</a></li>
                <li><a href="RegisterComputer.aspx">Register New Computer</a></li>
                <li><a href="AssignComputer.aspx">Assign Computer</a></li>
                  <a href="Help.aspx">Help</a>
            </ul>
        </div>
        <div class="main-content">
            <h1>Computers Management</h1>
            <div class="section">
                <div class="section-header">Register New Computer</div>
                <div class="form-container">
                    <asp:TextBox ID="txtComputerName" runat="server" Placeholder="Computer Name" ToolTip="Enter Computer Name" OnTextChanged="txtComputerName_TextChanged" />
                    <asp:TextBox ID="txtSerialNumber" runat="server" Placeholder="Serial Number" ToolTip="SerialNumber" />
                    <asp:TextBox ID="Description" runat="server" Placeholder="Description" ToolTip="Enter Computer Description" />
                    <asp:DropDownList ID="Condition" runat="server" ToolTip="Enter computer condition">
                         <asp:ListItem Text="Condition" Value="NULL" />
                         <asp:ListItem Text="New" Value="New" />
                        <asp:ListItem Text="Good" Value="Good" />
                        <asp:ListItem Text="Fair" Value="Fair" />
                    </asp:DropDownList>
                    <asp:Button ID="btnRegisterComputer" runat="server" Text="Register Computer" CssClass="btn" OnClick="btnRegisterComputer_Click1" BackColor ="#0047ab" />
                </div>
            </div>
                     
            <div class="section">
                <div class="section-header">Assign Computer</div>
                <div class="form-container">
                    <asp:TextBox ID="ComputerID" runat="server" Placeholder="Computer ID" />
                    <asp:TextBox ID="IDTextBox" runat="server" Placeholder="Learner ID" ToolTip="Enter Learner Id Number" AutoPostBack="True" />
                    <asp:TextBox ID="FirstName" runat="server" Placeholder="Learner Name" ReadOnly="True" AutoPostBack="True" />
                    <asp:TextBox ID="LastName" runat="server" Placeholder="Learner Surname" ReadOnly="True" AutoPostBack="True" />
                    <asp:Button ID="btnAssignComputer" runat="server" Text="Assign Computer" CssClass="btn" ForeColor="White" BackColor="#0047ab" OnClick="btnAssignComputer_Click1" />
                </div>
       
            </div>
            <div class="section">
                <asp:Button ID="ViewBtn" runat="server" Text="View Computers" CssClass="btn" ForeColor="White" BackColor="#0047ab" OnClick="ViewBtn_Click" />
                <asp:DropDownList runat="server" ID="ddlOrder" AutoPostBack="True" OnSelectedIndexChanged="ddlOrder_SelectedIndexChanged" CssClass="orderlist" ToolTip="Select order">
    <asp:ListItem Text="Sort by: Ascending" Value="ASC"></asp:ListItem>
    <asp:ListItem Text="Sort by: Descending" Value="DESC"></asp:ListItem>
</asp:DropDownList>

                <div class="section-header">Computers List</div>
                <div class="gridview-container">

                  <asp:GridView ID="gvComputer" runat="server" AutoGenerateColumns="False" CssClass="gridview" OnSelectedIndexChanged="gvComputer_SelectedIndexChanged">
    <Columns>
        <asp:BoundField DataField="ComputerID" HeaderText="Computer ID" />
        <asp:BoundField DataField="Serial_no" HeaderText="Serial Number" />
        <asp:BoundField DataField="Name" HeaderText="Computer Name" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:BoundField DataField="LearnerID" HeaderText="Learner ID" />
        <asp:BoundField DataField="DateOfIssue" HeaderText="Date of Issue" />
         <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditComputer" CommandArgument='<%# Eval("ComputerID") %>' CssClass="btn-primary" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

                </div>
            </div>
        </div>
    </div>
        </form>
    <script>
        function showMessage(message, isGoodNews) {
            var panel = document.getElementById('<%= panel.ClientID %>');
            var label = document.getElementById('<%= lblMessage.ClientID %>');

            if (label) {
                label.innerText = message;
            }

            if (panel) {
                // remove any previous state classes first
                panel.classList.remove('good-news', 'bad-news');
                panel.classList.add(isGoodNews ? 'good-news' : 'bad-news');
                panel.classList.add('show');

                // Remove the 'show' class after the animation completes
                setTimeout(function () {
                    if (panel) panel.classList.remove('show');
                }, 3500); // Matches the timing of your animation
            }
        }

    </script>


</body>
</html>
