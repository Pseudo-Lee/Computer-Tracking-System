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
            position: relative;
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
            .shooting-star2 {
    position: absolute;
    width: 4px;
    height: 4px;
    background-color: white;
    border-radius: 50%;
    box-shadow: 0 0 20px white;
    animation: shoot 5s ease-in-out;
}@keyframes fade {

}
 @keyframes fade {
    0%, 100% { opacity: 0; }
    50% { opacity: 1; }
}

@keyframes shoot {
    0% { transform: translate(0, 0); opacity: 1; }
    50% { transform: translate(20vw, 20vh); opacity: 0.8; }
 
    100% { transform: translate(100vw, 100vh); opacity: 0; }
}


    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <asp:Label runat="server" Text="Sign Up" ID="Header" CssClass="Header"></asp:Label>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Enter your name:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxSurname" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Enter your email:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxID" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Enter your cellphone number:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Label ID="Label6" runat="server" Text="Choose your username:" CssClass="labelClass"></asp:Label>
            <br />
            <asp:TextBox ID="TextBoxUsername" runat="server" CssClass="textboxClass"></asp:TextBox>
            <br />
            <asp:Button ID="SignUpBtn" runat="server" Text="Sign Up" CssClass="buttonClass" OnClick="SignUpBtn_Click" />
        </div>
    </form>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Fade in the body when the page loads
            $("body").fadeIn(5000); // Fades in over 2 seconds

            function createStar() {
                const star = document.createElement('span');
                star.classList.add('star');
                star.style.left = Math.random() * 100 + '%';
                star.style.top = Math.random() * 100 + '%';
                star.style.animationDuration = Math.random() * 5 + 5 + 's';
                document.body.appendChild(star);
            }

            function createShootingStar() {
                const shootingStar = document.createElement('span');
                shootingStar.classList.add('shooting-star');
                shootingStar.style.left = Math.random() * 100 + '%';
                shootingStar.style.top = Math.random() * 100 + '%';
                document.body.appendChild(shootingStar);

                setTimeout(() => shootingStar.remove(), 5000);
            }

            for (let i = 0; i < 100; i++) {
                setTimeout(createStar, Math.random() * 5000);
            }

            setInterval(createShootingStar, Math.random() * 2000 + 5000);
        });
    </script>

</body>
</html>
