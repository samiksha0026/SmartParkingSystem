<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Masterpage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="SmartPArkingSystem.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-container animate-fade-in">
        <h2>Welcome, <asp:Label ID="lblUserName" runat="server" /></h2>
        <p>Email: <asp:Label ID="lblUserEmail" runat="server" /></p>

        <!-- Active Booking Section -->
        <div id="activeBookingSection" runat="server" visible="false" class="active-booking animate-slide-up">
            <h3>Active Booking</h3>
            <div class="booking-details">
                <p><strong>Booking ID:</strong> <asp:Label ID="lblBookingID" runat="server" /></p>
                <p><strong>Parking ID:</strong> <asp:Label ID="lblSlotID" runat="server" /></p>
                <p><strong>Vehicle Number:</strong> <asp:Label ID="lblVehicleNumber" runat="server" /></p>
            </div>
        </div>

        <!-- Recent Payments Section -->
        <h3>Recent Payments</h3>
        <asp:GridView ID="gvRecentPayments" runat="server" CssClass="payment-table animate-fade-in" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="PaymentID" HeaderText="Payment ID" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:F2}" />
                <asp:BoundField DataField="PaymentMethod" HeaderText="Payment Method" />
                <asp:BoundField DataField="PaymentDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
            </Columns>
        </asp:GridView>

        <!-- Logout Button -->
        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="btn-logout animate-pop" />
    </div>

    <style>
        /* Animation Classes */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pop {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        .animate-fade-in { animation: fadeIn 0.8s ease-in-out; }
        .animate-slide-up { animation: slideUp 0.8s ease-in-out; }
        .animate-pop { animation: pop 0.6s ease-out; }

        /* Dashboard Container */
        .dashboard-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 31, 63, 0.2);
            text-align: center;
            transition: transform 0.3s ease;
        }

        h2, h3 { color: #001f3f; margin-bottom: 15px; }

        /* Active Booking Section */
        .active-booking {
            background: #f1f1f1;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 31, 63, 0.2);
            margin-top: 20px;
        }

        .booking-details p {
            font-size: 16px;
            margin: 8px 0;
        }

        /* Recent Payments Table */
        .payment-table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
            box-shadow: 0px 4px 10px rgba(0, 31, 63, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        .payment-table th {
            background-color: #001f3f;
            color: white;
            padding: 12px;
            font-size: 16px;
        }

        .payment-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
            transition: background 0.3s;
        }

        .payment-table tr:nth-child(even) { background-color: #f8f9fa; }
        .payment-table tr:hover { background-color: #cce5ff; }

        /* Logout Button */
        .btn-logout {
            background: #ff4136;
            color: white;
            padding: 12px 24px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s;
            box-shadow: 0px 4px 10px rgba(255, 65, 54, 0.3);
        }

        .btn-logout:hover {
            background: #c70000;
            transform: scale(1.05);
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .dashboard-container { width: 95%; padding: 15px; }
        }
    </style>
</asp:Content>
