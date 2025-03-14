<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="SmartPArkingSystem.Admin.Logout" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #0a1036;
            --secondary-color: #1a237e;
            --bg-light: #f4f7fa;
        }

        body {
            font-family: 'Poppins', Arial, sans-serif;
            background-color: var(--bg-light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }

        .logout-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 90%;
            max-width: 500px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            opacity: 0;
            animation: fadeIn 0.8s ease forwards;
        }

        h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: bold;
        }

        p {
            color: #555;
            margin-bottom: 30px;
        }

        .login-btn {
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 12px 25px;
            border: none;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
            font-weight: 500;
        }

        .login-btn:hover {
            background: linear-gradient(45deg, var(--secondary-color), var(--primary-color));
            transform: translateY(-3px);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 576px) {
            .logout-container {
                padding: 20px;
            }

            h2 {
                font-size: 1.5rem;
            }

            p {
                font-size: 1rem;
            }

            .login-btn {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="logout-container">
            <h2>You have been logged out</h2>
            <p>Redirecting to login...</p>

            <asp:Button ID="btnLogin" runat="server" CssClass="login-btn" Text="Login Again" OnClick="btnLogin_Click" />
        </div>
    </form>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
