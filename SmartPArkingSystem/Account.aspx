<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="SmartPArkingSystem.Account" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Libre+Franklin:wght@300&display=swap" rel="stylesheet">
    <title>Account</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Libre Franklin', sans-serif;
            background: #4568DC;
            background: -webkit-linear-gradient(to right, #B06AB3, #4568DC);
            background: linear-gradient(to right, #B06AB3, #4568DC);
            color: white;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background-color: #ffffff;
            color: #333;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.25), 0 5px 5px rgba(0, 0, 0, 0.22);
            width: 700px;
            padding: 20px;
        }

        h1 {
            color: #6441A5;
            margin-bottom: 20px;
            text-align: center;
        }

        .section {
            margin-bottom: 30px;
        }

        .section h2 {
            margin-bottom: 15px;
            font-size: 20px;
            color: #6441A5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        table th {
            background-color: #6441A5;
            color: white;
        }

        .btn-grad {
            background-image: linear-gradient(to right, #6441A5 0%, #2a0845 51%, #6441A5 100%);
            margin: 10px;
            padding: 10px 20px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: white;
            border-radius: 5px;
            display: inline-block;
            cursor: pointer;
            border: none;
        }

        .btn-grad:hover {
            background-position: right center;
            color: #fff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>My Account</h1>

        <!-- Personal Details Section -->
       <div class="section" id="personal-details">
    <h2>Personal Details</h2>
    <p><strong>Name:</strong> <asp:Label ID="lblName" runat="server" Text=""></asp:Label></p>
    <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></p>
    <p><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" Text=""></asp:Label></p>
</div>


        <!-- Booked Parking Section -->
        <div class="section" id="booked-parking">
    <h2>Booked Parking</h2>
    <asp:GridView ID="gvBookedParking" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type" />
            <asp:BoundField DataField="ParkingLocation" HeaderText="Parking Location" />
            <asp:BoundField DataField="SlotNumber" HeaderText="Slot Number" />
            <asp:BoundField DataField="BookingTime" HeaderText="Booking Time" DataFormatString="{0:yyyy-MM-dd hh:mm tt}" />
        </Columns>
    </asp:GridView>
</div>


        <!-- Parking History Section -->
        <div class="section" id="parking-history">
    <h2>Parking History</h2>
    <asp:GridView ID="gvParkingHistory" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type" />
            <asp:BoundField DataField="ParkingLocation" HeaderText="Parking Location" />
            <asp:BoundField DataField="SlotNumber" HeaderText="Slot Number" />
            <asp:BoundField DataField="CheckIn" HeaderText="Check-in" DataFormatString="{0:yyyy-MM-dd hh:mm tt}" />
            <asp:BoundField DataField="CheckOut" HeaderText="Check-out" DataFormatString="{0:yyyy-MM-dd hh:mm tt}" />
        </Columns>
    </asp:GridView>
</div>

        <!-- Logout Button -->
       <div class="section" style="text-align: center;">
    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-grad" OnClick="Logout_Click" />
</div>

    </div>
</body>
</html>
