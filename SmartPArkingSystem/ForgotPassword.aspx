<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="SmartPArkingSystem.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Smart Park & Ride</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Background */
        body {
            background: linear-gradient(135deg, #f8c291, #6a89cc);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px;
        }

        /* Forgot Password Card */
        .forgot-password-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 30px;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 1s ease-in-out;
        }

        /* Fade-in Animation */
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

        /* Button Hover */
        .btn-primary:hover {
            background: #0056b3;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 576px) {
            .forgot-password-card {
                padding: 20px;
            }
            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <div class="forgot-password-card">
        <h2 class="text-center">Forgot Password</h2>
        <p class="text-center text-muted">Enter your email to receive a password reset link</p>
        <form method="post" runat="server">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email" TextMode="Email" required="true"></asp:TextBox>
            </div>
            
            <!-- Success/Error Message -->
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

            <div class="d-grid gap-2 mt-3">
                <!-- Reset Password Button -->
                <asp:Button ID="btnReset" runat="server" Text="Send Reset Link" CssClass="btn btn-primary" OnClick="btnReset_Click" />

                <!-- Back to Login Button -->
                <a href="Login.aspx" class="btn btn-secondary">Back to Login</a>
            </div>
        </form>
    </div>
</body>
</html>
