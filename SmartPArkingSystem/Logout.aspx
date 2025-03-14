<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.master" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="SmartPArkingSystem.Logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #0A1F44, #162A5C);
            color: white;
            font-family: Arial, sans-serif;
        }
        .logout-container {
            text-align: center;
            padding: 20px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }
    </style>
    
    <div class="logout-container">
        <h2>Logging Out...</h2>
        <p>You will be redirected to the login page shortly.</p>
    </div>
    
    <script>
        setTimeout(function () {
            window.location.href = 'Login.aspx';
        }, 2000); 
    </script>
</asp:Content>
