<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="CTS.Main" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eef2f7;
            margin: 0;
            padding: 0;
            color: #2c3e50;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }
        .welcome-panel {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #d4edda;
            border: 1px solid #28a745;
            color: #155724;
            border-radius: 5px;
            font-size: 18px;
            width: 100%;
            max-width: 800px;
            text-align: center;
        }
        .container {
            width: 100%;
            max-width: 800px;
            background-color: white;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .header {
            background-color: #34495e;
            color: white;
            padding: 20px;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            border-radius: 10px;
        }
        .button-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 20px;
            margin-top: 20px;
        }
        .button {
            background-color: #2980b9;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #3498db;
        }
           .PanelDisplay {
    background-color: #f8f9fa; /* Light background for both success and error */
    border-radius: 5px;
    padding: 10px;
    margin-top: 1px;
}

.welcome-panel.success {
    border: 1px solid #28a745; /* Green border for success */
    color: #28a745; /* Green text for success */
}

.welcome-panel.error {
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
.welcome-panel.show {
    visibility: visible;
    opacity: 1;
    animation: fadeIn 1s ease-in fadeIn;
}

/* Apply the fade-out effect */
.welcome-panel.hide {
    animation: fadeOut 1s ease-out forwards;
    visibility: hidden; /* Ensure it is hidden after the animation */
}
    </style>
    <script type="text/javascript">
        function confirmLogout() {
            return confirm("Are you sure you want to log out?");
        }
    </script>
     <script type="text/javascript">
         function hidePanel() {
             document.getElementById('<%= WelcomePanel.ClientID %>').style.display = 'none';
         }
    </script>
</head>
<body>
    <asp:Panel ID="WelcomePanel" runat="server" CssClass="welcome-panel">
        <asp:Label ID="WelcomeLabel" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <form id="MainForm" runat="server">
        <div class="container">
            <div class="header">
                Admin Dashboard
            </div>
            <div class="button-row">
                <asp:Button runat="server" Text="Maintain Students" ID="StudentsBtn" CssClass="button" OnClick="StudentsBtn_Click"/>
                <asp:Button runat="server" Text="Maintain Computers" ID="ComputersBtn" CssClass="button" OnClick="ComputersBtn_Click"/>
                <asp:Button ID="MaintainUsers" runat="server" Text="Maintain Users" CssClass="button" OnClick="MaintainUsers_Click" />
                <asp:Button runat="server" Text="Log out" CssClass="button" ID="Logout" OnClientClick="return confirmLogout();" OnClick="Logout_Click"/>
            </div>
        </div>
    </form>
</body>
</html>
