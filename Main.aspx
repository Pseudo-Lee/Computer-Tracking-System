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
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }
        .container {
            width: 100%;
            max-width: 1200px;
            background-color: white;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 40px;
            text-align: center;
        }
        .header {
            background-color: #34495e;
            color: white;
            padding: 20px;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 40px;
            border-radius: 10px;
        }
        .button-row {
            display: flex;
            justify-content: center;
            gap: 30px;
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
        table {
            width: 100%;
        }
        td {
            text-align: center;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form id="MainForm" runat="server">
        <div class="container">
            <div class="header">
                Admin Dashboard
            </div>
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="button-row" id="s">
                        <asp:Button runat="server" Text="Maintain Students" ID="StudentsBtn" CssClass="button" OnClick="StudentsBtn_Click"></asp:Button>
                        <asp:Button runat="server" Text="Maintain Computers" ID="ComputersBtn" CssClass="button" OnClick="ComputersBtn_Click"></asp:Button>
                        <asp:Button runat="server" Text="Log out" CssClass="button" OnClick="Logout_Click"></asp:Button>


                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>