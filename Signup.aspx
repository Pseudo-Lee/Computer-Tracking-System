<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CTS.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <style>
        body {
            background-color: #00072D;
            overflow: hidden;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .Header {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #fff;
            text-align: center;
        }
        .form-container {
            text-align: center;
            background: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            width: 400px;
            z-index: 10;
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
        .input-pair {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .input-pair > div {
            width: 48%;
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
        .date-container {
            text-align: left;
            margin-bottom: 15px;
        }
        .validatorText {
            color: red;
            font-size: 14px;
            margin-left: 10px;
        }
        .auto-style3 {
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            width: 847px;
            z-index: 10;
            left: 3px;
            top: -2px;
            height: 967px;
        }
        .auto-style8 {
            height: 489px;
            width: 803px;
        }
        .auto-style19 {
            height: 547px;
            width: 864px;
            text-align: justify;
        }
        .auto-style20 {
            margin-top: 0px;
        }
        .auto-style21 {
            text-align: center;
            height: 77px;
        }
        .auto-style22 {
            text-align: center;
        }
        .auto-style14 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            margin-top: 10px;
        }
        .auto-style25 {
            width: 862px;
        }
        .auto-style28 {
            height: 110px;
            text-align: left;
            width: 430px;
        }
        .auto-style29 {
            text-align: left;
            width: 430px;
        }
    </style>
</head>
<body style="left: 0px; top: 0px; height: 969px">
    <form id="form1" runat="server">
        <div class="auto-style3">
            <div class="auto-style20">
                <div class="auto-style19">
                    <table class="auto-style8">
                        <tbody class="auto-style22">
                            <tr>
                                <td class="auto-style21">
                                    <table class="auto-style25">
                                        <tr>
                                            <td colspan="2">
            <asp:Label runat="server" Text="Sign Up" CssClass="Header" ID="Label8"></asp:Label>
            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style29">
                    <asp:Label ID="Label1" runat="server" Text="Enter your name:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBoxName" ErrorMessage="Name is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                    <asp:TextBox ID="TextBoxName" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                    <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBoxSurname" ErrorMessage="Surname is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                    <asp:TextBox ID="TextBoxSurname" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style28">
                    <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="TextBoxID" ErrorMessage="ID number is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorID" runat="server" 
                        ControlToValidate="TextBoxID" ErrorMessage="ID number must be 13 digits." 
                        ValidationExpression="^\d{13}$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                    <asp:TextBox ID="TextBoxID" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style28">
                    <asp:Label ID="LabelDate" runat="server" Text="Date:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <br />
                                                <br />
                    <asp:Label ID="lblDate" runat="server" BackColor="White" Height="34px" Width="430px"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <br />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style29">
                    <asp:Label ID="Label5" runat="server" Text="Enter your phone number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="TextBoxCellphone" ErrorMessage="Phone number is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorPhone" runat="server" 
                        ControlToValidate="TextBoxCellphone" ErrorMessage="Invalid phone number format." 
                        ValidationExpression="^(\+27|0)[6-8][0-9]{8}$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                    <asp:TextBox ID="TextBoxCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                    <asp:Label ID="Label3" runat="server" Text="Enter your email:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="TextBoxEmail" ErrorMessage="Email is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" 
                        ControlToValidate="TextBoxEmail" ErrorMessage="Invalid email format." 
                        ValidationExpression="^[\w\.\-]+@[\w\-]+\.[A-Za-z]{2,4}$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                                                <br />
                    <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style29">
                    <asp:Label ID="Label6" runat="server" Text="Add new password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="TextBoxPassword" ErrorMessage="Password is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                    <asp:TextBox ID="TextBoxPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                    <asp:Label ID="Label7" runat="server" Text="Confirm password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="TextBoxConfirmPassword" ErrorMessage="Confirm password is required." 
                        CssClass="validatorText"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToValidate="TextBoxConfirmPassword" ControlToCompare="TextBoxPassword" 
                        ErrorMessage="Passwords do not match." CssClass="validatorText"></asp:CompareValidator>
                                                <br />
                    <asp:TextBox ID="TextBoxConfirmPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
            
            <asp:Button ID="SignUpBtn" runat="server" Text="Sign Up" CssClass="auto-style14" OnClick="SignUpBtn_Click" Height="60px" Width="862px" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </form>
<<<<<<< HEAD
</body>
</html>
=======

    <!-- Shooting stars effect -->
    <div class="shooting-star"></div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            function createStar() {
                const star = document.createElement('span');
                star.classList.add('star');
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                star.style.animationDuration = Math.random() * 2.5 + 2.5 + 's';
                document.body.appendChild(star);
            }

            function createShootingStar() {
                const shootingStar = document.createElement('span');
                shootingStar.classList.add('shooting-star');
                shootingStar.style.left = Math.random() * 100 + '%';
                shootingStar.style.top = Math.random() * 100 + '%';
                document.body.appendChild(shootingStar);

                setTimeout(() => shootingStar.remove(),

    </script>
</body >

</html>
>>>>>>> be3fe7b53d8f47c27c583f388ca2c575eb6f38d0
