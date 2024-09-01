<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="CTS.EditUser" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #343a40;
            margin-bottom: 25px;
            font-size: 26px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 700;
            color: #495057;
        }

        .form-group input {
            width: 100%;
            padding: 14px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
        }

        .form-group input.ReadNull {
            background-color: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }

        .button-group {
            text-align: center;
        }

         .btn {
            background-color: #343a40;
            color: #ffffff;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 10px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .button-group btn:hover {
            background-color: #23272b;
            transform: translateY(-2px);
        }

        .button-group btn:active {
            background-color: #1d2124;
            transform: translateY(0);
        }

        .button-group .btn-danger {
            background-color: #e03131;
        }

        .button-group .btn-danger:hover {
            background-color: #c92a2a;
            transform: translateY(-2px);
        }

        .button-group .btn-danger:active {
            background-color: #b02a2a;
            transform: translateY(0);
        }

        .message-panel {
            padding: 18px;
            border-radius: 8px;
            margin-bottom: 25px;
            color: #ffffff;
            display: none;
        }

        .message-panel.success {
            background-color: #51cf66;
        }

        .message-panel.error {
            background-color: #fa5252;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="message-panel" id="messagePanel" runat="server">
                <asp:Label ID="lblMessage" runat="server" />
            </div>
            <h1>Edit User</h1>
            <div class="form-group">
                <asp:Label ID="lblFirstName" runat="server" Text="First Name:" />
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ReadOnly="True" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblRole" runat="server" Text="Role:" />
                <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" ReadOnly="True" />
            </div>
          
                <asp:CheckBox ID="chkIsAdmin" runat="server" Text="Promote to Admin" OnCheckedChanged="chkIsAdmin_CheckedChanged" CssClass="Checkbox" />
            
            <div class="button-group">
                <br />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="btn btn-danger" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
