<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="SmartPArkingSystem.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: url('images/signup_background.jpg') no-repeat center center/cover;
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
        h2 {
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
        .error {
            color: red;
            font-size: 12px;
            text-align: left;
            margin-top: 5px;
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
        }
        .btn:hover {
            background: linear-gradient(to right, #DD2476, #FF512F);
        }
        .signin-link {
            margin-top: 15px;
            color: #555;
        }
        .signin-link a {
            color: #8E2DE2;
            text-decoration: none;
            font-weight: bold;
        }
        .signin-link a:hover {
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
    <script>
        function validateForm() {
            let isValid = true;

            let name = document.getElementById("<%= NameTextBox.ClientID %>").value;
            let email = document.getElementById("<%= EmailTextBox.ClientID %>").value;
            let phone = document.getElementById("<%= PhoneTextBox.ClientID %>").value;
            let password = document.getElementById("<%= PasswordTextBox.ClientID %>").value;

            let nameError = document.getElementById("nameError");
            let emailError = document.getElementById("emailError");
            let phoneError = document.getElementById("phoneError");
            let passwordError = document.getElementById("passwordError");

            nameError.innerHTML = "";
            emailError.innerHTML = "";
            phoneError.innerHTML = "";
            passwordError.innerHTML = "";

            // Name Validation (Minimum 3 characters)
            if (name.length < 3) {
                nameError.innerHTML = "Name must be at least 3 characters";
                isValid = false;
            }

            // Email Validation (Regex)
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.innerHTML = "Enter a valid email address";
                isValid = false;
            }

            // Phone Validation (Only digits, 10 characters)
            let phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(phone)) {
                phoneError.innerHTML = "Enter a valid 10-digit phone number";
                isValid = false;
            }

            // Password Validation (At least 8 characters, 1 uppercase, 1 lowercase, 1 digit, 1 special char)
            let passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordPattern.test(password)) {
                passwordError.innerHTML = "Password must be at least 8 characters with uppercase, lowercase, number, and special character";
                isValid = false;
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Create Account</h2>
        <form id="signupForm" runat="server" onsubmit="return validateForm()">
            <div class="input-group">
                <asp:TextBox ID="NameTextBox" runat="server" placeholder="Name"></asp:TextBox>
                <div id="nameError" class="error"></div>
            </div>
            <div class="input-group">
                <asp:TextBox ID="EmailTextBox" runat="server" placeholder="Email"></asp:TextBox>
                <div id="emailError" class="error"></div>
            </div>
            <div class="input-group">
                <asp:TextBox ID="PhoneTextBox" runat="server" placeholder="Phone Number"></asp:TextBox>
                <div id="phoneError" class="error"></div>
            </div>
            <div class="input-group">
                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                <div id="passwordError" class="error"></div>
            </div>
            <asp:Button ID="SignUpButton" runat="server" CssClass="btn" Text="Sign Up" OnClick="SignUp_Click" />
        </form>
        <div class="signin-link">Already have an account? <asp:HyperLink ID="SignInLink" runat="server" NavigateUrl="Login.aspx">Sign in</asp:HyperLink></div>
    </div>
</body>
</html>
