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
        .hyperlinkClass {
            color: #1E90FF;
            text-decoration: none;
            margin-right: 10px;
        }
        .hyperlinkClass:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="Forgot Password" ID="Header" CssClass="Header"></asp:Label>
            <br />

            <asp:Label ID="LblFSUserName" runat="server" Text="Enter your username:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserName" ErrorMessage="Username is required" CssClass="labelClass"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtUserName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />

            <asp:Label ID="LblFSIdNum" runat="server" Text="Enter your ID number:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtIdNum" ErrorMessage="ID Number is required" CssClass="labelClass"></asp:RequiredFieldValidator>
            <br />
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtIdNum" ErrorMessage="Enter a valid ID number" MinimumValue="0000000000000" MaximumValue="9999999999999" Type="Double" CssClass="labelClass"></asp:RangeValidator>
            <br />
            <asp:TextBox ID="txtIdNum" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />

            <asp:Label ID="LblFSEmail" runat="server" Text="Enter your email:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="labelClass"></asp:RequiredFieldValidator>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Enter valid email address" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" CssClass="labelClass"></asp:RegularExpressionValidator>
            <br />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />

            <asp:Label ID="LblFSPassword" runat="server" Text="Enter new password:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" CssClass="labelClass"></asp:RequiredFieldValidator>
            <br />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>
            <br />

            <asp:Label ID="Label1" runat="server" Text="Confirm your new password:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm your password" CssClass="labelClass"></asp:RequiredFieldValidator>
            <br />
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match" CssClass="labelClass"></asp:CompareValidator>
            <br />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>
            <br />

            <asp:Button ID="BtnPasswordReset" runat="server" Text="Reset Password" CssClass="buttonClass" OnClick="UpdatePasswordBtn_Click" Height="39px" />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Login.aspx" Text="Back to login" CssClass="hyperlinkClass"></asp:HyperLink>
            <br />
            <asp:Label ID="LblUpdatedPS" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
