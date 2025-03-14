<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="SmartPArkingSystem.Admin.AdminLogin" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background: url('images/adminbk.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 10px;
        }
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(5px);
            padding: 40px;
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            transition: transform 0.3s ease-in-out;
        }
        .login-container:hover {
            transform: scale(1.03);
        }
        .logo {
            width: 70px;
            height: 70px;
            margin-bottom: 10px;
        }
        .btn {
            background: linear-gradient(135deg, #0D47A1, #1565C0);
            color: white;
            padding: 12px;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 8px;
            transition: background 0.3s, transform 0.2s;
            font-size: 16px;
            margin-top: 15px;
        }
        .btn:hover {
            transform: scale(1.05);
        }
        .input-box {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-bottom: 2px solid #ccc;
            background: transparent;
            outline: none;
            font-size: 16px;
            color: black;
            transition: border-color 0.3s;
        }
        .input-box:focus {
            border-color: #0D47A1;
        }
        .input-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        .icon {
            position: absolute;
            left: 15px;
            font-size: 18px;
            color: #ccc;
        }
        .input-box { padding-left: 40px; }
        .forgot-password {
            margin-top: 15px;
            font-size: 14px;
        }
        .forgot-password a {
            color: #0D47A1;
            text-decoration: none;
        }
        h2 {
            color: #0D47A1;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                padding: 30px;
                width: 90%;
            }
            .btn {
                padding: 10px;
                font-size: 14px;
            }
            .input-box {
                font-size: 14px;
                padding: 10px;
            }
            .forgot-password {
                font-size: 13px;
            }
        }
    </style>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <script>
        function validateForm() {
            var email = document.getElementById("<%= txtUsername.ClientID %>").value;
            var password = document.getElementById("<%= txtPassword.ClientID %>").value;
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            if (password.length < 6) {
                alert("Password must be at least 6 characters long.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return validateForm();">
        <div class="login-container">
            <img src="images/adminlogo.jpg" alt="Admin Logo" class="logo">
            <h2>Admin Login</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <div class="input-container">
                <i class="fas fa-user icon"></i>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-box" placeholder="Email"></asp:TextBox>
            </div>
            <div class="input-container">
                <i class="fas fa-lock icon"></i>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>
            <asp:Button ID="btnLogin" runat="server" CssClass="btn" Text="Login" OnClick="btnLogin_Click" />
            <div class="forgot-password">
                <a href="#">Forgot Password?</a>
            </div>
        </div>
    </form>
</body>
</html>