<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CTS.SignUp" %>

<!DOCTYPE html>
<script runat="server">

    protected void TextBoxName_TextChanged(object sender, EventArgs e)
    {

    }

    protected void BtnSignUp_Click(object sender, EventArgs e)
    {

    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <style>
        body {
<<<<<<< HEAD
    background-color: #00072D;
    overflow: auto; /* Enable scrolling */
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
    position: absolute;
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
    height: 589px;
}
.auto-style8 {
    height: 593px;
    width: 803px;
}
.auto-style19 {
    height: 593px;
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
.auto-style30 {
    text-align: justify;
    width: 430px;
=======
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
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
<<<<<<< HEAD
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
                                                    ControlToValidate="TxtbName" ErrorMessage="Name is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="TxtbName" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                                                <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                    ControlToValidate="TxtbSurname" ErrorMessage="Surname is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="TxtbSurname" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style28">
                                                <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                    ControlToValidate="TxtbID" ErrorMessage="ID number is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegexValidatorID" runat="server" 
                                                    ControlToValidate="TxtbID" ErrorMessage="ID number must be 13 digits." 
                                                    ValidationExpression="^\d{13}$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                                                <asp:TextBox ID="TxtbID" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                                                <asp:Label ID="Label10" runat="server" Text="Date of Registration:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <br />
                                                <asp:TextBox ID="TxtbDate" runat="server" ReadOnly="True" CssClass="textboxClass full-width"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style28">
                                                <asp:Label ID="Label6" runat="server" Text="Enter your cellphone number:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                    ControlToValidate="TxtbCellphone" ErrorMessage="Cellphone number is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegexValidatorCell" runat="server" 
                                                    ControlToValidate="TxtbCellphone" ErrorMessage="Invalid cellphone number." 
                                                    ValidationExpression="^\d{10}$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                                                <asp:TextBox ID="TxtbCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style30">
                                                <asp:Label ID="Label5" runat="server" Text="Enter your email:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                                    ControlToValidate="TxtbEmail" ErrorMessage="Email is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" 
                                                    ControlToValidate="TxtbEmail" ErrorMessage="Invalid email format." 
                                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" CssClass="validatorText"></asp:RegularExpressionValidator>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="TxtbEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style28">
                                                <asp:Label ID="Label11" runat="server" Text="Enter your password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                                    ControlToValidate="TxtbPassword" ErrorMessage="Password is required." 
                                                    CssClass="validatorText"></asp:RequiredFieldValidator>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="TxtbPassword" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                            <td class="auto-style29">
                                                <asp:Label ID="Label12" runat="server" Text="Confirm password:" CssClass="labelClass" ForeColor="#9966FF"></asp:Label>
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TxtbPassword" ControlToValidate="TxtbConfirmPassword" ErrorMessage="Passwords does not match" ForeColor="Red"></asp:CompareValidator>
                                                <br />
                                                <br />
                                                <asp:TextBox ID="TxtbConfirmPassword" runat="server" CssClass="textboxClass"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Button ID="BtnSignUp" runat="server" Text="Sign Up" CssClass="buttonClass" OnClick="BtnSignUp_Click" />
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
=======
        <div class="form-container">
            <asp:Label runat="server" Text="Sign Up" ID="Header" CssClass="Header"></asp:Label>
            
            <asp:Label ID="Label1" runat="server" Text="Enter your name:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxName" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldName" runat="server" ControlToValidate="TextBoxName" ErrorMessage="Name Required"></asp:RequiredFieldValidator>
            
            <asp:Label ID="Label2" runat="server" Text="Enter your surname:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxSurname" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="TextBoxSurname" ErrorMessage="Please enter your surname"></asp:CustomValidator>
            
            <asp:Label ID="Label3" runat="server" Text="Enter your email:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="textboxClass"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBoxEmail" ErrorMessage="Enter correct email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            
            <asp:Label ID="Label4" runat="server" Text="Enter your ID number:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxID" runat="server" CssClass="textboxClass"></asp:TextBox>
            
            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TextBoxID" ErrorMessage="Invalid ID number " MaximumValue="9999999999999" MinimumValue="0000000000000" Type="Double"></asp:RangeValidator>
            
            <asp:Label ID="Label5" runat="server" Text="Enter your cellphone number:" CssClass="labelClass"></asp:Label>
            <asp:TextBox ID="TextBoxCellphone" runat="server" CssClass="textboxClass"></asp:TextBox>
            
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBoxCellphone" ErrorMessage="Invalid number " MaximumValue="9999999999" MinimumValue="0000000000" Type="Double"></asp:RangeValidator>
            
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
>>>>>>> 04cdbb1825274f3624d457a935282f52b6be1d96
</body>
</html>
