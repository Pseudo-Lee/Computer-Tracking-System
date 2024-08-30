<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CTS.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <style>
        body {
            background-color: #00072D;
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .Header {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #fff;
        }
        .labelClass {
            font-size: 16px;
            color: #333;
            display: inline-block;
            text-align: left;
            margin-bottom: 5px;
        }
        .textboxClass {
            width: calc(100% - 20px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
            display: inline-block;
        }
        .full-width {
            width: 100%;
        }
        .buttonClass {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            display: block;
            margin-top: 10px;
        }
        .buttonClass:hover {
            background-color: #45a049;
        }
        .validatorText {
            color: red;
            font-size: 14px;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="Sign Up" CssClass="Header" ID="Label8"></asp:Label>

            <asp:Label ID="Label1" runat="server" Text="Enter your name:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="TxtbName" ErrorMessage="Name is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:TextBox ID="TxtbName" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="TxtbSurname" ErrorMessage="Surname is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:TextBox ID="TxtbSurname" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="TxtbID" ErrorMessage="ID number is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegexValidatorID" runat="server" 
                ControlToValidate="TxtbID" ErrorMessage="ID number must be 13 digits." 
                ValidationExpression="^\d{13}$" CssClass="validatorText"></asp:RegularExpressionValidator>
            <asp:TextBox ID="TxtbID" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label10" runat="server" Text="Date of Registration:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:TextBox ID="TxtbDate" runat="server" ReadOnly="True" CssClass="textboxClass full-width"></asp:TextBox>

            <asp:Label ID="Label6" runat="server" Text="Enter your cellphone number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="TxtbCellphone" ErrorMessage="Cellphone number is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegexValidatorCell" runat="server" 
                ControlToValidate="TxtbCellphone" ErrorMessage="Invalid cellphone number." 
                ValidationExpression="^\d{10}$" CssClass="validatorText"></asp:RegularExpressionValidator>
            <asp:TextBox ID="TxtbCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label5" runat="server" Text="Enter your email:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="TxtbEmail" ErrorMessage="Email is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" 
                ControlToValidate="TxtbEmail" ErrorMessage="Invalid email format." 
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" CssClass="validatorText"></asp:RegularExpressionValidator>
            <asp:TextBox ID="TxtbEmail" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label11" runat="server" Text="Enter your password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ControlToValidate="TxtbPassword" ErrorMessage="Password is required." 
                CssClass="validatorText"></asp:RequiredFieldValidator>
            <asp:TextBox ID="TxtbPassword" runat="server" CssClass="textboxClass"></asp:TextBox>

            <asp:Label ID="Label12" runat="server" Text="Confirm password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
            <!--<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TxtbPassword" ControlToValidate="TxtbConfirmPassword" ErrorMessage="Passwords does not match" ForeColor="Red"></asp:CompareValidator>-->
            <asp:TextBox ID="TxtbConfirmPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>

            <asp:Button ID="BtnSignUp" runat="server" Text="Sign Up" CssClass="buttonClass" OnClick="BtnSignUp_Click" />
        </div>
    </form>
</body>
</html>
