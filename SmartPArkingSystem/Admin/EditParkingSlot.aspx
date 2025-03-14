<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditParkingSlot.aspx.cs" Inherits="SmartPArkingSystem.Admin.EditParkingSlot" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Parking Slot</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            width: 90%;
            max-width: 400px;
        }
        h2 {
            text-align: center;
            color: #0a1036;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #0a1036;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn:hover {
            background: #2a2f80;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Edit Parking Slot</h2>
            <asp:HiddenField ID="hfSlotID" runat="server" />
            <div class="form-group">
                <label>Location:</label>
                <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label>Vehicle Type:</label>
                <asp:DropDownList ID="ddlVehicleType" runat="server">
                    <asp:ListItem Text="2-Wheeler" Value="2-Wheeler"></asp:ListItem>
                    <asp:ListItem Text="4-Wheeler" Value="4-Wheeler"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Availability:</label>
                <asp:CheckBox ID="chkAvailable" runat="server" />
            </div>
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn" OnClick="btnUpdate_Click" />
        </div>
    </form>
</body>
</html>
