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
            display: block;
            text-align: left;
            margin-bottom: 5px;
        }
        .textboxClass {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }
        .buttonClass {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .buttonClass:hover {
            background-color: #45a049;
        }
        .star {
            position: absolute;
            width: 2px;
            height: 2px;
            background-color: white;
            border-radius: 50%;
            box-shadow: 0 0 10px white;
            animation: fade 5s infinite ease-in-out;
        }
        .shooting-star {
            position: absolute;
            width: 4px;
            height: 4px;
            background-color: white;
            border-radius: 50%;
            box-shadow: 0 0 20px white;
            animation: shoot 5s ease-in-out;
        }
        @keyframes fade {
            0%, 100% { opacity: 0; }
            50% { opacity: 1; }
        }
        @keyframes shoot {
            0% { transform: translate(0, 0); opacity: 1; }
            100% { transform: translate(100vw, -100vh); opacity: 0; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="Sign Up" ID="Header" CssClass="Header"></asp:Label>
            
            <asp:Label ID="Label1" runat="server" Text="Enter your name:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Please enter your name"></asp:CustomValidator>
            
            <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxSurname" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="TextBoxSurname" ErrorMessage="Please enter your surname"></asp:CustomValidator>
            
            <asp:Label ID="Label3" runat="server" Text="Enter your email:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="Enter correct email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            
            <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxID" runat="server" CssClass="textboxClass"></asp:TextBox>
            
            <asp:Label ID="Label5" runat="server" Text="Enter your cellphone number:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>
            
            <asp:Label ID="Label6" runat="server" Text="Add new password:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxPassword" ErrorMessage="Password is required"></asp:RequiredFieldValidator>
            
            <asp:Label ID="Label7" runat="server" Text="Confirm password:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxConfirmPassword" runat="server" CssClass="textboxClass" TextMode="Password"></asp:TextBox>

            <asp:Button ID="SignUpBtn" runat="server" Text="Sign Up" CssClass="buttonClass" OnClick="SignUpBtn_Click" />
        </div>
    </form>
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
                shootingStar.style.right = Math.random() * 100 + '%';
                shootingStar.style.bottom = Math.random() * 100 + '%';
                document.body.appendChild(shootingStar);

                setTimeout(() => shootingStar.remove(), 5000);
            }

            for (let i = 0; i < 100; i++) {
                setTimeout(createStar, Math.random() * 5000);
            }

            setInterval(createShootingStar, Math.random() * 5000 + 5000);
        });
    </script>
</body>
</html>
