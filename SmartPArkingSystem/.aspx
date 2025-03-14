<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParkingSlots.aspx.cs" Inherits="SmartParkRide.ParkingSlots" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Parking Slots</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1>Available Parking Slots</h1>
        <asp:Repeater ID="ParkingSlotsRepeater" runat="server">
            <HeaderTemplate>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Address</th>
                            <th>Price</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Address") %></td>
                    <td>$<%# Eval("Price") %></td>
                    <td><%# Convert.ToBoolean(Eval("IsAvailable")) ? "Available" : "Unavailable" %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</body>
</html>
