<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="SmartPArkingSystem.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: url('images/background.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 1.5s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .input-group {
            position: relative;
            margin-bottom: 15px;
        }
        .input-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
            transition: 0.3s;
        }
        .input-group input:focus {
            border-color: #8E2DE2;
            outline: none;
            box-shadow: 0 0 8px rgba(142, 45, 226, 0.2);
        }
        .btn {
            background: linear-gradient(to right, #FF512F, #DD2476);
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: 0.3s;
            animation: fadeIn 2s ease-in-out;
        }
        .btn:hover {
            background: linear-gradient(to right, #DD2476, #FF512F);
        }
        .forgot-password {
            display: block;
            margin: 10px 0;
            color: #555;
            text-decoration: none;
            transition: 0.3s;
        }
        .forgot-password:hover {
            color: #8E2DE2;
        }
        .signup-link {
            margin-top: 15px;
            color: #555;
        }
        .signup-link a {
            color: #8E2DE2;
            text-decoration: none;
            font-weight: bold;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
        
        /* Responsive Styles */
        @media screen and (max-width: 500px) {
            body {
                padding: 10px;
            }
            .container {
                width: 100%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sign In</h1>
        <form id="form1" runat="server">
            <div class="input-group">
                <asp:TextBox ID="EmailTextBoxSignIn" runat="server" placeholder="Email"></asp:TextBox>
            </div>
            <div class="input-group">
                <asp:TextBox ID="PasswordTextBoxSignIn" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>
            <a href="ForgotPassword.aspx" class="forgot-password">Forgot your password?</a>
            <asp:Button ID="SignInButton" runat="server" CssClass="btn" Text="Sign In" OnClick="SignIn_Click" />
            <div class="signup-link">Don't have an account? <asp:HyperLink ID="SignUpLink" runat="server" NavigateUrl="Signup.aspx">Sign up</asp:HyperLink></div>
        </form>
    </div>
</body>
</html> 