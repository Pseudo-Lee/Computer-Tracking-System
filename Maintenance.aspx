<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="CTS.Maintenance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maintenance Request</title>
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

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 14px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus, .form-group textarea:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
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
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background-color: #23272b;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        . btn:active {
            transform: translateY(0);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
            <h1>Log a Maintenance Request</h1>
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Your Name:" />
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Your Email:" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Label ID="lblRequest" runat="server" Text="Request Details:" />
                <asp:TextBox ID="txtRequest" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" />
            </div>
            <div class="button-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Request" OnClick="btnSubmit_Click" CssClass="btn" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" CssClass="btn" />
            </div>
        </div>
    </form>
</body>
</html>
