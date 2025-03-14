<%@ Page Title="Book Parking" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BookParking.aspx.cs" Inherits="SmartPArkingSystem.BookParking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5efeb;
            margin: 0;
            padding: 0;
        }

        .booking-container {
            text-align: center;
            width: 90%;
            max-width: 600px;
            margin: auto;
            animation: fadeIn 1s ease-in-out;
            padding: 25px;
            background: white;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(20px);
            transition: transform 0.5s ease-in-out;
        }

        .booking-container:hover {
            transform: translateY(0);
        }

        h2 {
            color: #2F4156;
            font-size: 22px;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            margin: 15px 0;
            border-collapse: collapse;
        }

        td {
            padding: 12px;
            font-size: 16px;
            text-align: left;
            color: #2F4156;
        }

        .vehicle-input, .vehicle-select {
            padding: 12px;
            font-size: 16px;
            width: 100%;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: 0.3s;
        }

        .vehicle-input:focus, .vehicle-select:focus {
            border-color: #567C8D;
            box-shadow: 0px 0px 5px rgba(86, 124, 141, 0.5);
        }

        .confirm-btn {
            background-color: #2F4156;
            color: white;
            border: none;
            padding: 14px;
            width: 100%;
            cursor: pointer;
            font-size: 18px;
            border-radius: 8px;
            transition: 0.3s ease-in-out;
            font-weight: bold;
        }

        .confirm-btn:hover {
            background-color: #567C8D;
            box-shadow: 0px 4px 10px rgba(86, 124, 141, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media screen and (max-width: 600px) {
            .booking-container {
                width: 95%;
            }
        }
    </style>

    <div class="booking-container">
        <h2>Confirm Your Parking</h2>

        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

        <table>
            <tr><td><b>Parking Name:</b></td><td><asp:Label ID="lblParkingName" runat="server"></asp:Label></td></tr>
            <tr><td><b>City:</b></td><td><asp:Label ID="lblCity" runat="server"></asp:Label></td></tr>
            <tr><td><b>Area:</b></td><td><asp:Label ID="lblArea" runat="server"></asp:Label></td></tr>
            <tr><td><b>Price:</b></td><td><asp:Label ID="lblPrice" runat="server"></asp:Label></td></tr>
        </table>

        <asp:TextBox ID="txtVehicleNumber" runat="server" CssClass="vehicle-input" Placeholder="Enter Vehicle Number"></asp:TextBox>

        <asp:DropDownList ID="ddlVehicleType" runat="server" CssClass="vehicle-select">
            <asp:ListItem Text="2-wheeler" Value="2-wheeler"></asp:ListItem>
            <asp:ListItem Text="3-wheeler" Value="3-wheeler"></asp:ListItem>
            <asp:ListItem Text="4-wheeler" Value="4-wheeler"></asp:ListItem>
        </asp:DropDownList>

        <asp:Button ID="btnConfirmBooking" runat="server" CssClass="confirm-btn" Text="Confirm Booking" OnClick="btnConfirmBooking_Click" />

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>
