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
            overflow: hidden;
            position: relative;
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

        .trail-star {
            position: absolute;
            width: 2px;
            height: 2px;
            background-color: white;
            border-radius: 50%;
            box-shadow: 0 0 10px white;
            animation: trail 5s ease-in-out;
        }

        @keyframes fade {
            0%, 100% { opacity: 0; }
            50% { opacity: 1; }
        }

        @keyframes shoot {
            0% { transform: translate(0, 0); opacity: 1; }
            100% { transform: translate(100vw, -100vh); opacity: 0; }
        }

        @keyframes trail {
            0% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
</head>
<body>
    <asp:Label runat="server" Text="Computer Tracking System" CssClass="header-text" ID="lblHeader"></asp:Label>
    <form id="form1" runat="server">
        <div>
            <!-- Header text -->
            

            <!-- Centered button -->
            <asp:Button runat="server" Text="Go to Login" OnClick="btnLogin_Click" CssClass="animated-button" ID="btnLogin"></asp:Button>
        </div>

    </form>

    <!-- jQuery -->
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
                star.style.animationDuration = Math.random() * 2.5 + 2.5 + 's';
                document.body.appendChild(star);
            }

            function createShootingStar() {
                const shootingStar = document.createElement('span');
                shootingStar.classList.add('shooting-star');
                shootingStar.style.left = Math.random() * 100 + '%';
                shootingStar.style.top = Math.random() * 100 + '%';
                document.body.appendChild(shootingStar);

                for (let i = 1; i <= 10; i++) {
                    const trailStar = document.createElement('span');
                    trailStar.classList.add('trail-star');
                    trailStar.style.left = shootingStar.style.left;
                    trailStar.style.bottom = shootingStar.style.bottom;
                    trailStar.style.width = (4 - i * 0.3) + 'px';
                    trailStar.style.height = (4 - i * 0.3) + 'px';
                    trailStar.style.animationDelay = (i * 0.1) + 's';
                    trailStar.style.transform = `translate(${i * 10}px, ${-i * 10}px)`;
                    document.body.appendChild(trailStar);
                    setTimeout(() => trailStar.remove(), 5000);
                }

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
