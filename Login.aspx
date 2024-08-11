<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CTS.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CTS Login</title>
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
            
            background-color: #3498db; /* Lighter shade of blue */
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="CTS Login" ID="ctl00" CssClass="Header"></asp:Label>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Enter your username:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Enter your password:" CssClass="labelClass"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Button ID="LoginBtn" runat="server" Text="Login" CssClass="buttonClass" OnClick="LoginBtn_Click" />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="ForgotPassword.aspx" Text="Forgot Password?" CssClass="hyperlinkClass"></asp:HyperLink>
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="SignUp.aspx" Text="Sign Up" CssClass="hyperlinkClass"></asp:HyperLink>
        </div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
        <div class="cloud"></div>
    </form>
</body>
</html>
