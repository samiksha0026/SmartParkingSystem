<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpage.master" AutoEventWireup="true" CodeFile="Ticket.aspx.cs" Inherits="SmartPArkingSystem.Ticket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .ticket-container {
            text-align: center;
            width: 80%;
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #2F4156;
        }
        .ticket-details {
            text-align: left;
            font-size: 16px;
            margin-top: 20px;
        }
        .qr-code {
            margin-top: 20px;
        }
        .btn {
            background-color: #2F4156;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            cursor: pointer;
            font-size: 18px;
            border-radius: 5px;
            transition: 0.3s;
            margin-top: 15px;
        }
        .btn:hover {
            background-color: #567C8D;
        }
    </style>

    <div class="ticket-container">
        <h2>Parking Ticket</h2>
        <div class="ticket-details">
            <p><strong>Booking ID:</strong> <asp:Label ID="lblBookingID" runat="server"></asp:Label></p>
            <p><strong>Vehicle Number:</strong> <asp:Label ID="lblVehicleNumber" runat="server"></asp:Label></p>
            <p><strong>Parking Slot:</strong> <asp:Label ID="lblSlot" runat="server"></asp:Label></p>
            <p><strong>Amount Paid:</strong> ₹<asp:Label ID="lblAmount" runat="server"></asp:Label></p>
            <asp:Label ID="lblError" runat="server" ForeColor="Red" />

        </div>
        
        <div class="qr-code">
            <asp:Image ID="imgQRCode" runat="server" />
        </div>
        
        <asp:Button ID="btnPrint" runat="server" CssClass="btn" Text="Print Ticket" OnClientClick="window.print(); return false;" />
    </div>
</asp:Content>

