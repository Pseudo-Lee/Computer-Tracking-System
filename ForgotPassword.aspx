<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="CTS.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <style>
        body {
            background-color: lightblue;
            overflow: hidden;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .Header {
            display: block;
            text-align: center;
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 20px;
            position: relative;
            z-index: 10;
        }
        .form-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .labelClass {
            font-size: 16px;
            color: #333;
        }
        .textboxClass {
            width: 200px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .buttonClass {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .buttonClass:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="Forgot Password" ID="Header" CssClass="Header"></asp:Label>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Enter your username:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxUsername" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Enter your ID number:" CssClass="labelClass"></asp:Label>
            <br />
            
            <asp:TextBox ID="TextBoxID" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Enter your email:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Enter new password:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Button ID="UpdatePasswordBtn" runat="server" Text="Update Password" CssClass="buttonClass" OnClick="UpdatePasswordBtn_Click" />
        </div>
    </form>

</body>
</html>
