<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditLearner.aspx.cs" Inherits="CTS.EditLearner" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Learner</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #007bff;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group input.ReadNull {
            background-color: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }

        .button-group {
            text-align: center;
        }

        .button-group button {
            background-color: #007bff;
            color: #ffffff;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 8px;
            transition: background-color 0.3s ease;
        }

        .button-group button:hover {
            background-color: #0056b3;
        }

        .button-group .btn-danger {
            background-color: #dc3545;
        }

        .button-group .btn-danger:hover {
            background-color: #c82333;
        }

        .message-panel {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #fff;
           /*display: none;*/ 
        }

        .message-panel.success {
            background-color: #28a745;
        }

        .message-panel.error {
            background-color: #dc3545;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="message-panel" id="messagePanel" runat="server">
                <asp:Label ID="lblMessage" runat="server" />
            </div>
            <h1>Edit Learner</h1>
            <asp:Panel runat="server"></asp:Panel>
            <div class="form-group">
                <asp:Label ID="lblFirstName" runat="server" Text="First Name:" />
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblLastName" runat="server" Text="Last Name:" />
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email Address:" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblIdNumber" runat="server" Text="ID Number:" />
                <asp:TextBox ID="txtIdNumber" runat="server" CssClass="form-control ReadNull" ReadOnly="True" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblGender" runat="server" Text="Gender:" />
                <asp:TextBox ID="txtGender" runat="server" CssClass="form-control ReadNull" ReadOnly="True" />
            </div>
            <div class="button-group">
                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" CssClass="btn" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" CssClass="btn btn-danger" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
