<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CTS.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CTS Login</title>
    <style>
        body {
            background-color: #7B4B94;
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
        .cloud {
            width: 200px;
            height: 60px;
            background: #fff;
            border-radius: 200px;
            position: absolute;
            top: 50px;
            left: 50%;
            margin-left: -100px;
            animation: bounceClouds 5s ease-in-out infinite;
            opacity: 0.8;
            box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.1);
            z-index: -1;
        }
        .cloud:before, .cloud:after {
            content: '';
            position: absolute;
            background: #fff;
            width: 100px;
            height: 80px;
            position: absolute;
            top: -30px;
            left: 10px;
            border-radius: 100px;
            box-shadow: 10px 10px 30px rgba(0, 0, 0, 0.1);
        }
        .cloud:after {
            width: 120px;
            height: 120px;
            top: -40px;
            left: auto;
            right: 10px;
            border-radius: 200px;
        }
        .cloud:nth-child(2) {
            top: 100px;
            left: 20%;
            animation-duration: 6s;
        }
        .cloud:nth-child(3) {
            top: 150px;
            left: 70%;
            animation-duration: 7s;
        }
        .cloud:nth-child(4) {
            top: 200px;
            left: 40%;
            animation-duration: 8s;
        }
        .cloud:nth-child(5) {
            top: 250px;
            left: 10%;
            animation-duration: 9s;
        }
        .cloud:nth-child(6) {
            top: 300px;
            left: 80%;
            animation-duration: 10s;
        }
        @keyframes bounceClouds {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
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
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.3s ease-in-out, background-color 0.3s ease-in-out;
        }
        .hyperlinkClass {
            color: #1E90FF;
            text-decoration: none;
            margin-right: 10px;
        }
        .hyperlinkClass:hover {
            text-decoration: underline;
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
        .popup {
            position: fixed;
            top: -50px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            font-size: 16px;
            font-weight: bold;
            z-index: 1000;
            transition: top 0.5s ease;
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
    <div id="connectionStatus" class="popup">Connected</div>
    <div class="shooting-star"></div>
    <form id="form1" runat="server">
        <div class="form-container">
            <br />
            <asp:Label runat="server" Text="CTS Login" ID="Header" CssClass="Header"></asp:Label>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Enter your username:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="txtName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Enter your password:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Button ID="LoginBtn" runat="server" Text="Login" OnClick="LoginBtn_Click" CssClass="buttonClass" />
            <br />
            <asp:HyperLink ID="HyperLinkForgotpassword" runat="server" NavigateUrl="ForgotPassword.aspx" Text="Forgot Password?" CssClass="hyperlinkClass"></asp:HyperLink>
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Signup.aspx" Text="Sign Up" CssClass="hyperlinkClass"></asp:HyperLink>
        </div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
 




    </form>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   
  

    <script>
        $(document).ready(function () {
            $("body").fadeIn(2000); // Fades in over 2 seconds

            function createStar() {
                const star = document.createElement('span');
                star.classList.add('star');
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                star.style.animationDuration = Math.random() * 2.5 + 2.5 + 's';
                document.body.appendChild(star);
                setTimeout(() => star.remove(), 5000);
            }
            setInterval(createStar, 100);

            function createShootingStar() {
                const shootingStar = document.createElement('span');
                shootingStar.classList.add('shooting-star');
                shootingStar.style.left = Math.random() * 100 + 'vw';
                shootingStar.style.top = Math.random() * 50 + 'vh';
                shootingStar.style.animationDuration = Math.random() * 1 + 4 + 's';
                document.body.appendChild(shootingStar);
                setTimeout(() => shootingStar.remove(), 5000);
            }
            setInterval(createShootingStar, 3000);

            // Show the popup on page load
            const connectionPopup = document.getElementById('connectionStatus');
            setTimeout(() => {
                connectionPopup.style.top = '20px';
            }, 500);
            setTimeout(() => {
                connectionPopup.style.top = '-50px';
            }, 4000);
        });
    </script>
</body>
</html>
