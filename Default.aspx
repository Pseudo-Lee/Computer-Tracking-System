<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CTS.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Computer Tracking System</title>
    <style>
        /* Set the page background color to a shade of blue */
        body {
            display: none;
            background-color: #2c3e50; /* Darker shade of blue */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
            overflow: hidden; /* Prevent scrollbars */
        }

        /* Style for the header text */
        .header-text {
            color: white;
            font-size: 36px;
            text-shadow: 1px 1px 0 #000, 
                         2px 2px 0 #000, 
                         3px 3px 0 #000, 
                         4px 4px 0 #000;
            margin-top: -150px; /* Increase the space between the text and button */
            padding-top: -150px;
            transition: transform 0.3s ease-in-out, background-color 0.3s ease-in-out;
        }

        /* Style the button */
        .animated-button {
            padding: 15px 30px;
            background-color: #3498db; /* Lighter shade of blue */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: transform 0.3s ease-in-out, background-color 0.3s ease-in-out;
            margin-top: 20px; /* Add some space between the text and button */
        }

        /* Hover effect for the button */
        .animated-button:hover {
            transform: scale(1.1);
            background-color: #2980b9; /* Even darker shade of blue */
        }

        /* Canvas for matrix effect */
        #matrix {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* Ensure it is behind other elements */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- Header text -->

            <!-- Centered button -->
            <asp:Button runat="server" Text="Go to Login" OnClick="btnLogin_Click" CssClass="animated-button" ID="btnLogin"></asp:Button>
        </div>
    </form>

    <!-- Canvas for matrix effect -->
    <canvas id="matrix"></canvas>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Fade in the body when the page loads
            $("body").fadeIn(2000); // Fades in over 2 seconds
        });

        // Matrix effect
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        const fontSize = 16;
        const columns = canvas.width / fontSize;

        const drops = [];
        for (let x = 0; x < columns; x++) {
            drops[x] = 1;
        }

        function draw() {
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            ctx.fillStyle = '#0F0';
            ctx.font = fontSize + 'px arial';

            for (let i = 0; i < drops.length; i++) {
                const text = letters[Math.floor(Math.random() * letters.length)];
                ctx.fillText(text, i * fontSize, drops[i] * fontSize);

                if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
                    drops[i] = 0;
                }

                drops[i]++;
            }
        }

        setInterval(draw, 33);
    </script>
</body>
            <asp:Label runat="server" Text="Computer Tracking System" CssClass="header-text" ID="lblHeader"></asp:Label>
</html>
