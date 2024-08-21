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
    </style>
</head>
<body>
    <form id="AdminForm" runat="server">
        <div class="container">
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
            </table>

            <!-- Buttons -->
            <div class="button-row">
                <asp:Button ID="btnAdd" runat="server" Text="Add Learner" CssClass="button" OnClick="btnAdd_Click" />
                <asp:Button ID="btnSearch" runat="server" Text="Search Learners" CssClass="button" />
            </div>
        </div>
    </form>
</body>
</html>
